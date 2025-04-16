import 'package:flutter/material.dart';
import 'package:app_guias/presentation/controllers/guide/guide.flow.controller.dart';
import 'package:app_guias/core/services/csv.service.dart';
import 'package:intl/intl.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:app_guias/core/services/efact.service.dart';
import 'dart:io';
import 'package:app_guias/services/log/logger.service.dart';
import 'package:app_guias/presentation/widgets/modals/procesando.modal.dart';
import 'package:app_guias/presentation/widgets/modals/resultado.modal.dart';
import 'package:provider/provider.dart';
import 'package:app_guias/providers/guia.provider.dart';
import 'package:app_guias/providers/auth.provider.dart';

class NewGuideController extends ChangeNotifier {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  final GuideFlowController flowController;
  final CsvService _csvService = CsvService();
  final EfactService _efactService = EfactService();
  bool _isInitialized = false;
  String _csvPath = '';
  String _pdfPath = '';
  bool _isLoading = false;
  String _error = '';

  bool get isInitialized => _isInitialized;
  GuideFlowController get guideFlowController => flowController;
  String get csvPath => _csvPath;
  String get pdfPath => _pdfPath;
  bool get isLoading => _isLoading;
  String get error => _error;

  NewGuideController({required this.flowController}) {
    init();
  }

  Future<void> init() async {
    if (_isInitialized) return;

    LoggerService.info('Inicializando NewGuideController');
    _isInitialized = true;
    notifyListeners();
  }

  // Método para configurar el contexto desde la página
  void setContext(BuildContext context) {
    if (navigatorKey.currentContext == null) {
      LoggerService.info('Contexto configurado en NewGuideController');
    }
  }

  // Obtener el correlativo directamente del servicio
  Future<String> _getNextCorrelativo(BuildContext context) async {
    try {
      LoggerService.info(
          '-------- INICIANDO OBTENCIÓN DE CORRELATIVO --------');

      // Obtener el provider
      final guiaProvider = Provider.of<GuiaProvider>(context, listen: false);
      LoggerService.info('Provider GuiaProvider obtenido correctamente');

      // Obtener el correlativo directamente del servicio
      LoggerService.info('Solicitando correlativo al servicio...');
      final String? correlativo =
          await guiaProvider.getCorrelativoFromService();

      if (correlativo != null && correlativo.isNotEmpty) {
        LoggerService.info(
            'ÉXITO: Correlativo obtenido del servicio: $correlativo');
        LoggerService.info(
            '-------- FIN OBTENCIÓN DE CORRELATIVO: ÉXITO --------');
        return correlativo;
      } else {
        LoggerService.error(
            'No se pudo obtener un correlativo válido del servicio');
        LoggerService.info(
            '-------- FIN OBTENCIÓN DE CORRELATIVO: ERROR --------');
        throw Exception(
            'No se pudo obtener un correlativo válido del servicio');
      }
    } catch (e) {
      // En caso de error, no usamos valores por defecto sino que lanzamos una excepción
      // para que el proceso de generación de guía se detenga
      LoggerService.error('Error fatal al obtener el correlativo: $e');
      LoggerService.info(
          '-------- FIN OBTENCIÓN DE CORRELATIVO: EXCEPCIÓN --------');
      throw Exception('No se pudo generar un correlativo válido. Error: $e');
    }
  }

  // Método para generar la guía utilizando el contexto proporcionado directamente
  Future<void> generateGuide([BuildContext? providedContext]) async {
    // Verificar y mostrar logs para depuración
    LoggerService.info('Iniciando generación de guía...');

    // Usar el contexto proporcionado o intentar con el navigatorKey
    final BuildContext? context =
        providedContext ?? navigatorKey.currentContext;

    if (context == null) {
      LoggerService.error(
          'Error: No hay contexto disponible para mostrar el modal');
      return;
    }

    // Verificar si es transporte privado y validar placa
    final modalidadTraslado =
        flowController.motivoTrasladoController.modalidadTraslado.text;
    String? codigoModalidad;
    flowController.motivoTrasladoController.modalidades
        .forEach((codigo, texto) {
      if (texto == modalidadTraslado) {
        codigoModalidad = codigo;
      }
    });

    final isPrivado = codigoModalidad == '02';

    if (isPrivado) {
      // Verificar que la placa esté presente
      final placa = flowController.transporteController.placaController.text
          .replaceAll('-', '');
      if (placa.isEmpty) {
        // Mostrar error
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
                'Error: La placa del vehículo es obligatoria para transporte privado'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }
    }

    // Verificar que el contexto sigue siendo válido
    if (!context.mounted) return;

    // Mostrar modal de procesamiento usando el nuevo ProcesandoModal
    ProcesandoModal.show(
      context,
      title: 'Procesando guía',
      message: 'Generando guía de remisión, por favor espere...',
    );

    // Procesar la guía usando el contexto verificado
    await _processGuide(context);
  }

  // Método privado para procesar la generación de la guía
  Future<void> _processGuide(BuildContext context) async {
    // Obtener providers al inicio, antes de operaciones asíncronas
    final guiaProvider = Provider.of<GuiaProvider>(context, listen: false);
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final userId = authProvider.userId;

    try {
      // Obtener el RUC exacto sin manipulación adicional
      final rucEmisor = dotenv.env['RUC'];

      try {
        // Generar el siguiente correlativo directamente
        final serieCorrelativo = await _getNextCorrelativo(context);
        LoggerService.info(
            'Generando guía con serieCorrelativo: $serieCorrelativo');

        // 1. Generar CSV
        String csvFilePath = await _csvService.generateCsv(
          rucEmisor: rucEmisor!,
          serieCorrelativo: serieCorrelativo,
          data: await _generateGuideData(),
        );
        _csvPath = csvFilePath;

        // Log del CSV generado - este archivo se mantendrá guardado localmente
        LoggerService.info('CSV generado exitosamente en: $_csvPath');

        // Agregamos un log para indicar explícitamente que el CSV se guardará localmente
        LoggerService.info(
            'ARCHIVO CSV GUARDADO LOCALMENTE para uso posterior en: $_csvPath');

        // 2. Procesar guía con Efact
        final processResult = await _efactService.processGuide(_csvPath);

        // Verificar si el proceso fue exitoso y extraer la ruta del PDF
        if (processResult['success'] == true) {
          String pdfFilePath = processResult['pdfPath'] as String;
          _pdfPath = pdfFilePath;

          // 3. Guardar guía en el backend cuando eFact retorna el PDF correctamente
          try {
            LoggerService.info('----- INICIO: Subiendo guía al servidor -----');

            // Obtener el archivo PDF como bytes
            final pdfFile = File(_pdfPath);
            if (await pdfFile.exists()) {
              final pdfBytes = await pdfFile.readAsBytes();

              LoggerService.info(
                  'Archivo PDF leído correctamente. Tamaño: ${pdfBytes.length} bytes');

              // Obtener el nombre del archivo PDF
              final nombrePdf = _pdfPath.split('/').last;
              LoggerService.info('Nombre de archivo para subida: $nombrePdf');

              if (userId == null) {
                LoggerService.warning(
                    'No se pudo obtener el ID del usuario actual');
                throw Exception('Usuario no autenticado');
              }

              LoggerService.info('ID de usuario para subida: $userId');

              // Subir la guía al backend incluyendo el ID del usuario
              final guia =
                  await guiaProvider.uploadGuia(nombrePdf, pdfBytes, userId);

              if (guia != null) {
                LoggerService.info(
                    'Guía guardada exitosamente en el backend con ID: ${guia.id}');

                // Eliminar el archivo PDF local después de la subida exitosa
                try {
                  if (await pdfFile.exists()) {
                    await pdfFile.delete();
                    LoggerService.info(
                        'Archivo PDF local eliminado después de subir al servidor: $_pdfPath');
                  }
                } catch (deleteError) {
                  LoggerService.warning(
                      'No se pudo eliminar el archivo PDF local después de subirlo: $deleteError');
                }
              } else {
                final errorMsg = guiaProvider.error ?? 'Error desconocido';
                LoggerService.warning(
                    'No se pudo guardar la guía en el backend: $errorMsg');

                // En lugar de solo loggear, lanzamos una excepción específica para manejarla
                throw Exception('ERROR_BACKEND:$errorMsg');
              }
            } else {
              LoggerService.warning(
                  'El archivo PDF no existe en la ruta: $_pdfPath');
              throw Exception('El archivo PDF no existe en la ruta: $_pdfPath');
            }
            LoggerService.info('----- FIN: Subida de guía al servidor -----');
          } catch (uploadError) {
            // Ahora manejamos el error aquí, guardando información para el mensaje personalizado
            LoggerService.error(
                'Error al subir la guía al backend: $uploadError');

            // Si el PDF se generó, pero hubo un error en la subida, lanzamos una excepción específica
            // que incluye la ruta del PDF para poder mostrar un mensaje personalizado
            if (_pdfPath.isNotEmpty) {
              throw Exception(
                  'ERROR_PDF_GUARDADO:$_pdfPath:${uploadError.toString().replaceAll('Exception: ', '')}');
            } else {
              rethrow; // Re-lanzar el error original si no tenemos PDF
            }
          }
        } else {
          // Si hubo un error, lanzarlo para que lo maneje el bloque catch
          String message =
              processResult['message'] as String? ?? 'Error desconocido';
          String code = processResult['code'] as String? ?? 'UNKNOWN';

          // Añadimos un log específico para indicar que se mantendrá el CSV aunque haya fallado el PDF
          LoggerService.info(
              'SE MANTIENE EL ARCHIVO CSV en: $_csvPath a pesar del error en la generación del PDF');

          throw Exception('$message [Código: $code]');
        }
      } catch (e) {
        // Revisamos si es un error de autenticación de EFACT
        if (e.toString().toLowerCase().contains('autenticación') ||
            e.toString().toLowerCase().contains('authentication') ||
            e.toString().contains('contrase')) {
          LoggerService.error('Error de autenticación EFACT: $e');

          // Mostrar el mensaje de error original sin procesar
          throw Exception(e.toString().replaceAll('Exception: ', ''));
        }
        // Revisamos si es un error específico de correlativo
        else if (e.toString().toLowerCase().contains('correlativo')) {
          LoggerService.error('Error crítico con el correlativo: $e');
          throw Exception(
              'No se pudo generar la guía porque no se pudo obtener un correlativo válido del servidor. Por favor, verifique su conexión e inténtelo nuevamente.');
        }
        // Para otros tipos de error
        else {
          LoggerService.error('Error en procesamiento de guía: $e');
          throw Exception('Error en procesamiento de guía: $e');
        }
      }

      notifyListeners();

      // Cerrar el modal de carga
      if (context.mounted) {
        Navigator.of(context).pop();
      }

      // Mantenemos el archivo CSV para el historial local
      LoggerService.info(
          'El archivo CSV se ha guardado permanentemente en: $_csvPath para el historial local');

      // Mostrar mensaje de éxito usando ResultadoModal
      if (context.mounted) {
        ResultadoModal.showSuccess(
          context,
          title: 'Guía generada exitosamente',
          message: 'La guía ha sido generada y transmitida correctamente.',
          onButtonPressed: () {
            // Reiniciar todos los formularios
            resetAllFormData();
            Navigator.pop(context);
          },
        );
      }
    } catch (e) {
      // Cerrar el modal de carga
      if (context.mounted) {
        Navigator.of(context).pop();
      }

      notifyListeners();

      // Verificar si es un error de PDF generado pero no subido al backend
      if (e.toString().startsWith('Exception: ERROR_PDF_GUARDADO:')) {
        // Extraer información del error
        final errorParts = e
            .toString()
            .replaceAll('Exception: ERROR_PDF_GUARDADO:', '')
            .split(':');
        final pdfPath = errorParts[0];
        final errorDetail =
            errorParts.length > 1 ? errorParts[1] : 'Error desconocido';

        // Guardar la ruta del PDF
        _pdfPath = pdfPath;

        // Mostrar mensaje de éxito parcial usando ResultadoModal
        if (context.mounted) {
          List<Widget> details = [
            const Text(
                'La guía se ha generado correctamente y está disponible en su dispositivo.'),
            const SizedBox(height: 8),
            const Text('Sin embargo, no se pudo subir al servidor debido a:'),
            const SizedBox(height: 4),
            Text(errorDetail,
                style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            const Text(
                'Puede encontrar el archivo PDF en la carpeta de Guías y subirlo manualmente más tarde desde la sección de Historial.')
          ];

          ResultadoModal.showWarning(
            context,
            title: 'Guía generada con advertencia',
            message:
                'La guía se guardó localmente pero no se pudo subir al servidor.',
            details: details,
            onButtonPressed: () {
              // Reiniciar todos los formularios
              resetAllFormData();
              Navigator.pop(context);
            },
          );
          return;
        }
      }
      // Error específico de backend
      else if (e.toString().startsWith('Exception: ERROR_BACKEND:')) {
        final errorDetail =
            e.toString().replaceAll('Exception: ERROR_BACKEND:', '');

        // Mostrar mensaje de éxito parcial usando ResultadoModal
        if (context.mounted) {
          List<Widget> details = [
            const Text(
                'La guía se ha generado correctamente y está disponible en su dispositivo.'),
            const SizedBox(height: 8),
            const Text('Sin embargo, no se pudo subir al servidor debido a:'),
            const SizedBox(height: 4),
            Text(errorDetail,
                style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            const Text(
                'Puede encontrar el archivo PDF en la carpeta de Guías y subirlo manualmente más tarde desde la sección de Historial.')
          ];

          ResultadoModal.showWarning(
            context,
            title: 'Guía generada con advertencia',
            message:
                'La guía se guardó localmente pero no se pudo subir al servidor.',
            details: details,
            onButtonPressed: () {
              // Reiniciar todos los formularios
              resetAllFormData();
              Navigator.pop(context);
            },
          );
          return;
        }
      }

      // Extraer código y descripción del error si es posible
      String errorMessage = e.toString();
      String? errorCode;

      // Si el error contiene código y descripción del servicio EFACT
      if (e.toString().contains('Código:')) {
        try {
          final regex = RegExp(r'\[Código: (.*?)\]');
          final match = regex.firstMatch(e.toString());
          if (match != null) {
            errorCode = match.group(1);
          }
        } catch (_) {}
      }

      // Mostrar error usando ResultadoModal
      if (context.mounted) {
        List<Widget> details = [];

        if (errorCode != null) {
          details.add(Text('Código de error: $errorCode'));
          details.add(const SizedBox(height: 8));
        }

        details.add(Text('Detalle del error:'));

        // Simplificación del mensaje de error para mostrar directamente el del servicio
        String cleanError = errorMessage.replaceAll('Exception: ', '');

        // Eliminar la parte del código para no duplicarlo en la UI
        if (errorCode != null) {
          final codePattern = RegExp(r'\[Código: .*?\]');
          cleanError = cleanError.replaceAll(codePattern, '').trim();
        }

        details.add(Text(
          cleanError,
          style: const TextStyle(fontSize: 14),
        ));

        details.add(const SizedBox(height: 8));
        details.add(const Text(
          'Puede intentar nuevamente o revisar los datos ingresados.',
          style: TextStyle(fontSize: 14),
        ));

        ResultadoModal.showError(
          context,
          title: 'Error al generar guía',
          message: 'No se pudo completar la generación de la guía.',
          details: details,
        );
      }
    }
  }

  Future<Map<String, dynamic>> _generateGuideData() async {
    final dateFormat = DateFormat('yyyy-MM-dd');
    final timeFormat = DateFormat('HH:mm:ss');
    final now = DateTime.now();

    // Obtener datos de todos los controladores
    final partidaData = flowController.partidaController.toJson();
    final llegadaData = flowController.llegadaController.toJson();
    final destinatarioData = flowController.destinatarioController.toJson();
    final transporteData = flowController.transporteController.toJson();
    final detalleData = flowController.detalleCargaController.toJson();
    final transportistaData = flowController.transportistaController.toJson();
    final motivoTrasladoData = flowController.motivoTrasladoController.toJson();
    final usoInternoData = flowController.usoInternoController.toJson();

    // Determinar modalidad de transporte
    // 01 = Transporte público, 02 = Transporte privado
    final modalidadTraslado = motivoTrasladoData['modalidadTraslado'] ?? '01';
    final isPrivado = modalidadTraslado == '02';

    // Log de datos para depuración
    LoggerService.info(
        'MODALIDAD: $modalidadTraslado (${isPrivado ? 'PRIVADO' : 'PÚBLICO'})');
    LoggerService.info('DATOS TRANSPORTE: ${transporteData.toString()}');
    if (isPrivado) {
      // Validar que la placa esté presente
      final placa = transporteData['vehiculo']?['placa'] ?? '';
      if (placa.isEmpty) {
        LoggerService.error(
            'ERROR: La placa del vehículo es obligatoria para transporte privado');
        throw Exception(
            'La placa del vehículo es obligatoria para transporte privado');
      }
      LoggerService.info('VEHÍCULO - PLACA: $placa');
    }

    // Construir el objeto de datos completo con las reglas SUNAT
    final data = {
      'fechaEmision': dateFormat.format(now),
      'horaEmision': timeFormat.format(now),
      'items': detalleData['items'],
      'remitente': {
        'razonSocial': 'AGROINDUSTRIAL LAREDO SAA',
        'tipoDocumento': '6',
        'numeroDocumento': dotenv.env['RUC'],
        'ubigeo': partidaData['ubigeo'],
        'direccion': partidaData['direccion'],
        'urbanizacion': partidaData['urbanizacion'],
        'provincia': partidaData['provincia'],
        'departamento': partidaData['departamento'],
        'distrito': partidaData['distrito'],
      },
      'destinatario': {
        'razonSocial': destinatarioData['razonSocial'],
        'tipoDocumento': destinatarioData['tipoDocumento'],
        'numeroDocumento': destinatarioData['numeroDocumento'],
        'ubigeo': llegadaData['ubigeo'],
        'direccion': llegadaData['direccion'],
        'urbanizacion': llegadaData['urbanizacion'],
        'provincia': llegadaData['provincia'],
        'departamento': llegadaData['departamento'],
        'distrito': llegadaData['distrito'],
      },
      'transporteData': transporteData,
      'envio': {
        'motivoTraslado': motivoTrasladoData['motivoTraslado'],
        'modalidadTraslado': modalidadTraslado,
        'descripcionMotivo': motivoTrasladoData['descripcionMotivo'],
        'pesoBruto': detalleData['pesoBruto'],
        'unidadMedida': detalleData['unidadMedida'] ?? 'TNE',
        'fechaInicioTraslado': transporteData['fechaTraslado'],
        // Solo incluir transportista si es transporte público (01)
        'transportista': isPrivado
            ? {}
            : {
                'razonSocial': transportistaData['razonSocial'],
                'ruc': transportistaData['ruc'],
              },
        'puntoPartida': {
          'ubigeo': partidaData['ubigeo'],
          'direccion': partidaData['direccion'],
          'urbanizacion': partidaData['urbanizacion'],
          'provincia': partidaData['provincia'],
          'departamento': partidaData['departamento'],
          'distrito': partidaData['distrito'],
        },
        'puntoLlegada': {
          'ubigeo': llegadaData['ubigeo'],
          'direccion': llegadaData['direccion'],
          'urbanizacion': llegadaData['urbanizacion'],
          'provincia': llegadaData['provincia'],
          'departamento': llegadaData['departamento'],
          'distrito': llegadaData['distrito'],
        },
      },
      // Solo incluir conductor si es transporte privado (02)
      'conductor': isPrivado
          ? {
              'numeroDocumento': transporteData['conductor']['numeroDocumento'],
              'tipoDocumento': transporteData['conductor']['tipoDocumento'],
              'nombres': transporteData['conductor']['nombres'],
              'apellidos': transporteData['conductor']['apellidos'],
              'licencia': transporteData['conductor']['licencia'],
            }
          : {},
      // Solo incluir vehículo si es transporte privado (02)
      'vehiculo': isPrivado
          ? {
              'placa': transporteData['vehiculo']['placa'],
            }
          : {},
      'observaciones': usoInternoData['observaciones'],
    };

    return data;
  }

  Future<void> resetAllFormData() async {
    try {
      // Reiniciar todos los formularios
      await flowController.partidaController.resetToDefault();
      await flowController.llegadaController.resetToDefault();
      flowController.destinatarioController.resetToDefault();
      flowController.transporteController.clear();
      flowController.transportistaController.clear();
      flowController.motivoTrasladoController.resetToDefault();
      flowController.usoInternoController.resetToDefault();

      // Limpiar los detalles de carga
      await flowController.detalleCargaController.resetData();

      LoggerService.info(
          'Todos los formularios han sido reiniciados correctamente');
    } catch (e) {
      LoggerService.error('Error al reiniciar formularios: $e');
    }
  }

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void resetError() {
    _error = '';
    notifyListeners();
  }

  void setError(String value) {
    _error = value;
    notifyListeners();
  }

  void showMessage(String message, {bool isError = true}) {
    if (isError) {
      ScaffoldMessenger.of(navigatorKey.currentContext!).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Colors.red,
        ),
      );
    } else {
      ScaffoldMessenger.of(navigatorKey.currentContext!).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  Future<void> initInformation() async {
    try {
      LoggerService.info('NewGuideController: Inicializando información...');
      setLoading(true);

      // Obtener el correlativo directamente del servicio
      if (navigatorKey.currentContext != null) {
        await _getNextCorrelativo(navigatorKey.currentContext!);
      } else {
        LoggerService.warning(
            'No hay contexto disponible para obtener el correlativo');
      }

      // ... existing code ...
    } catch (e) {
      setError('Error al inicializar: ${e.toString()}');
    } finally {
      setLoading(false);
    }
  }
}
