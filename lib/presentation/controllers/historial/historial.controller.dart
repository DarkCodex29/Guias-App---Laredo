import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as path;
import 'package:app_guias/services/log/logger.service.dart';
import 'package:open_file/open_file.dart';
import 'package:provider/provider.dart';
import 'package:app_guias/providers/guia.provider.dart';
import 'package:app_guias/providers/auth.provider.dart';
import 'package:app_guias/models/guia.dart';

class GuideFile {
  final String fileName;
  final String fullPath;
  final DateTime creationDate;
  final FileSystemEntityType type;
  final String extension;
  final bool isPdf;
  final bool isCsv;

  // Información extraída del nombre (para archivos SUNAT)
  final String? ruc;
  final String? tipoDocumento;
  final String? serieCorrelativo;

  GuideFile({
    required this.fileName,
    required this.fullPath,
    required this.creationDate,
    required this.type,
    required this.extension,
    required this.isPdf,
    required this.isCsv,
    this.ruc,
    this.tipoDocumento,
    this.serieCorrelativo,
  });

  // Métodos para extraer información del nombre del archivo
  static GuideFile fromFile(FileSystemEntity entity) {
    final File file = File(entity.path);
    final String fileName = path.basename(file.path);
    final String extension = path.extension(file.path).toLowerCase();
    final DateTime creationDate = file.statSync().changed;

    // Determinar tipo de archivo
    final bool isPdf = extension == '.pdf';
    final bool isCsv = extension == '.csv';

    // Intentar extraer información del nombre si sigue el formato SUNAT
    // Formato esperado: <RUC>-<TipoDoc>-<Serie>-<Correlativo>.<ext>
    // Ejemplo: 20132377783-09-T002-00000603.pdf
    String? ruc;
    String? tipoDocumento;
    String? serieCorrelativo;

    final RegExp guiaRegExp = RegExp(r'^(\d+)-(\d+)-([A-Z0-9]+-\d+)\..*$');
    final match = guiaRegExp.firstMatch(fileName);

    if (match != null && match.groupCount >= 3) {
      ruc = match.group(1);
      tipoDocumento = match.group(2);
      serieCorrelativo = match.group(3);
    }

    return GuideFile(
      fileName: fileName,
      fullPath: file.path,
      creationDate: creationDate,
      type: FileSystemEntity.typeSync(file.path),
      extension: extension,
      isPdf: isPdf,
      isCsv: isCsv,
      ruc: ruc,
      tipoDocumento: tipoDocumento,
      serieCorrelativo: serieCorrelativo,
    );
  }

  // Método para crear un GuideFile a partir de un objeto Guia del backend
  static GuideFile fromGuia(Guia guia) {
    final serieCorrelativoMatch =
        RegExp(r'([A-Z0-9]+-\d+)').firstMatch(guia.nombre);
    final serieCorrelativo = serieCorrelativoMatch?.group(1);

    return GuideFile(
      fileName: guia.nombre,
      fullPath: '', // No tenemos path físico para archivos del backend
      creationDate: guia.fechaSubida,
      type: FileSystemEntityType.file,
      extension: '.pdf', // Asumimos que todos son PDF
      isPdf: true,
      isCsv: false,
      ruc: null, // No tenemos esta información
      tipoDocumento: null, // No tenemos esta información
      serieCorrelativo: serieCorrelativo,
    );
  }
}

class HistorialController extends ChangeNotifier {
  final List<GuideFile> _archivosPdf = [];
  List<GuideFile> _archivosCsv =
      []; // Dejamos esta lista para mantener compatibilidad
  bool _isLoading = false;
  String _errorMessage = '';
  late GuiaProvider _guiaProvider;
  late AuthProvider _authProvider;
  bool _mounted =
      true; // Variable para controlar si el controlador está montado

  // Getters
  List<GuideFile> get archivosPdf => _archivosPdf;
  List<GuideFile> get archivosCsv => _archivosCsv;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;
  bool get hasError => _errorMessage.isNotEmpty;
  bool get isAdmin => _authProvider.role == 'ADMINISTRADOR';
  bool get mounted => _mounted;

  @override
  void dispose() {
    _mounted = false;
    super.dispose();
  }

  void initialize(BuildContext context) {
    // Verificar que el componente sigue montado
    if (!context.mounted || !_mounted) return;

    _guiaProvider = Provider.of<GuiaProvider>(context, listen: false);
    _authProvider = Provider.of<AuthProvider>(context, listen: false);

    // Determinar si el usuario es administrador
    final isAdmin = _authProvider.role == 'ADMINISTRADOR';

    // Cargar las guías apropiadas según el rol
    cargarArchivos(isAdmin: isAdmin);
  }

  Future<void> cargarArchivos({bool isAdmin = false}) async {
    if (!_mounted) {
      return; // Verificar si el controlador sigue montado
    }

    _isLoading = true;
    _errorMessage = '';
    notifyListeners();

    try {
      // Limpiar la lista antes de cargar nuevos archivos
      _archivosPdf.clear();

      // Cargar archivos CSV locales (siempre se cargan independientemente del rol)
      await _cargarArchivosCsvLocales();

      // Cargar guías del backend según el rol de usuario
      if (isAdmin) {
        // Administrador: cargar todas las guías
        await _guiaProvider.loadGuias();
      } else {
        // Usuario normal: cargar solo sus guías
        final userId = _authProvider.userId;
        if (userId != null) {
          await _guiaProvider.loadGuiasByUsuario(userId);
        }
      }

      if (!_mounted) {
        return; // Verificar nuevamente después de operaciones asíncronas
      }

      // Convertir las guías del backend en objetos GuideFile y agregarlos
      _archivosPdf.addAll(
          _guiaProvider.guias.map((guia) => GuideFile.fromGuia(guia)).toList());

      // Ordenar por fecha de creación (más reciente primero)
      _archivosPdf.sort((a, b) => b.creationDate.compareTo(a.creationDate));
    } catch (e) {
      if (!_mounted) {
        return; // Verificar antes de actualizar el estado de error
      }
      _errorMessage = 'Error al cargar las guías: ${e.toString()}';
      LoggerService.error('Error al cargar guías: $e');
    } finally {
      if (_mounted) {
        // Solo notificar si seguimos montados
        _isLoading = false;
        notifyListeners();
      }
    }
  }

  // Método para cargar los archivos CSV locales (mantenemos esta funcionalidad)
  Future<void> _cargarArchivosCsvLocales() async {
    try {
      final Directory directory =
          Directory('/storage/emulated/0/Download/Guias');

      if (!await directory.exists()) {
        _archivosCsv = [];
        return;
      }

      final List<GuideFile> tempCsv = [];

      await for (final FileSystemEntity entity in directory.list()) {
        try {
          final GuideFile archivo = GuideFile.fromFile(entity);
          if (archivo.isCsv) {
            tempCsv.add(archivo);
          }
        } catch (e) {
          LoggerService.error(
              'Error al procesar archivo CSV ${entity.path}: $e');
        }
      }

      // Ordenar por fecha de creación (más reciente primero)
      tempCsv.sort((a, b) => b.creationDate.compareTo(a.creationDate));
      _archivosCsv = tempCsv;
    } catch (e) {
      LoggerService.error('Error al cargar archivos CSV locales: $e');
      _archivosCsv = [];
    }
  }

  Future<bool> abrirArchivo(GuideFile archivo) async {
    try {
      // Si es un archivo local (tiene ruta completa)
      if (archivo.fullPath.isNotEmpty) {
        final result = await OpenFile.open(archivo.fullPath);
        LoggerService.info(
            'Resultado al abrir archivo local: ${result.message}');
        return result.type == ResultType.done;
      }
      // Si es un archivo del backend (no tiene ruta completa)
      else {
        LoggerService.info(
            'Intentando abrir archivo del backend: ${archivo.fileName}');

        // Buscar la guía correspondiente en el provider
        Guia? guiaEncontrada;
        try {
          // Intentamos buscar primero por nombre exacto
          guiaEncontrada = _guiaProvider.guias.firstWhere(
            (guia) => guia.nombre == archivo.fileName,
            orElse: () => throw Exception('Nombre exacto no encontrado'),
          );
        } catch (e) {
          // Si no encontramos por nombre exacto, buscamos por nombre parcial
          LoggerService.info(
              'Nombre exacto no encontrado, buscando por coincidencia parcial');
          for (var guia in _guiaProvider.guias) {
            if (archivo.fileName.contains(guia.nombre) ||
                guia.nombre.contains(archivo.fileName)) {
              guiaEncontrada = guia;
              LoggerService.info(
                  'Coincidencia parcial encontrada: ${guia.nombre}');
              break;
            }
          }

          // Si aún no encontramos, usamos el primer elemento como fallback
          if (guiaEncontrada == null && _guiaProvider.guias.isNotEmpty) {
            LoggerService.warning(
                'Usando primera guía disponible como fallback');
            guiaEncontrada = _guiaProvider.guias.first;
          }
        }

        if (guiaEncontrada == null) {
          _errorMessage = 'No se encontró la guía en el servidor';
          notifyListeners();
          LoggerService.error(
              'Guía no encontrada en el backend: ${archivo.fileName}');
          return false;
        }

        LoggerService.info('Descargando guía con ID: ${guiaEncontrada.id}');

        // Descargar el archivo
        final bytes = await _guiaProvider.downloadGuia(guiaEncontrada.id);
        if (bytes == null) {
          _errorMessage = 'No se pudo descargar la guía';
          notifyListeners();
          LoggerService.error(
              'Error al descargar bytes de la guía: ${guiaEncontrada.id}. Error: ${_guiaProvider.error}');
          return false;
        }

        LoggerService.info(
            'Guía descargada correctamente. Tamaño: ${bytes.length} bytes');

        try {
          // Guardar temporalmente y abrir
          final tempDir = Directory('/storage/emulated/0/Download/Guias/temp');
          if (!await tempDir.exists()) {
            await tempDir.create(recursive: true);
            LoggerService.info('Directorio temporal creado: ${tempDir.path}');
          }

          final tempFile = File('${tempDir.path}/${archivo.fileName}');
          await tempFile.writeAsBytes(bytes);
          LoggerService.info('Archivo temporal guardado: ${tempFile.path}');

          final result = await OpenFile.open(tempFile.path);
          LoggerService.info(
              'Resultado al abrir archivo descargado: ${result.message} (${result.type})');
          return result.type == ResultType.done;
        } catch (fileError) {
          LoggerService.error(
              'Error al guardar o abrir el archivo temporal: $fileError');
          _errorMessage = 'Error al abrir el archivo descargado: $fileError';
          notifyListeners();
          return false;
        }
      }
    } catch (e) {
      LoggerService.error('Error al abrir archivo: $e');
      _errorMessage = 'No se pudo abrir el archivo: $e';
      notifyListeners();
      return false;
    }
  }

  Future<bool> eliminarArchivo(GuideFile archivo) async {
    try {
      // Si es un archivo local
      if (archivo.fullPath.isNotEmpty) {
        final file = File(archivo.fullPath);
        await file.delete();

        // Actualizar listas locales
        if (archivo.isPdf) {
          _archivosPdf.removeWhere((a) => a.fullPath == archivo.fullPath);
        } else if (archivo.isCsv) {
          _archivosCsv.removeWhere((a) => a.fullPath == archivo.fullPath);
        }

        notifyListeners();
        return true;
      }
      // Si es un archivo del backend
      else {
        // Implementar aquí la eliminación del backend cuando esté disponible
        // Por ahora solo actualizamos la lista local
        _archivosPdf.removeWhere((a) => a.fileName == archivo.fileName);
        notifyListeners();
        LoggerService.warning(
            'Eliminación de guías en el backend no implementada');
        return true;
      }
    } catch (e) {
      _errorMessage = 'No se pudo eliminar el archivo: $e';
      notifyListeners();
      return false;
    }
  }

  // Métodos para paginación
  void nextPage() {
    if (!_mounted) {
      return; // Verificar si el controlador sigue montado
    }
    if (!_isLoading) {
      _guiaProvider.nextPage();
      cargarArchivos(isAdmin: isAdmin);
    }
  }

  void previousPage() {
    if (!_mounted) {
      return; // Verificar si el controlador sigue montado
    }
    if (!_isLoading) {
      _guiaProvider.previousPage();
      cargarArchivos(isAdmin: isAdmin);
    }
  }

  Future<void> goToPage(int page) async {
    await _guiaProvider.goToPage(page);
    await cargarArchivos();
  }
}
