import 'dart:convert';
import 'dart:io';
import 'package:app_guias/services/log/logger.service.dart';
import 'package:flutter/foundation.dart';

class CsvService {
  static const String tipoDocumento = '09'; // Guía de remisión remitente

  /// Formatea un número según las especificaciones UBL 2.1
  /// [valor] - El número a formatear
  /// [enteros] - Cantidad máxima de dígitos enteros permitidos
  /// [decimales] - Cantidad máxima de decimales permitidos

  Future<String> generateCsv({
    required String rucEmisor,
    required String serieCorrelativo,
    required Map<String, dynamic> data,
  }) async {
    final List<List<String>> rows = [];

    // Obtener el RUC exacto sin manipulación adicional
    final String rucRemitente = rucEmisor.trim();

    // Analizar la modalidad de traslado para aplicar reglas correctas
    final envioData = data['envio'] ?? {};
    // Modo transporte: modalidadTraslado 01 = Transporte público, 02 = Transporte privado
    final isPrivado = envioData['modalidadTraslado'] == '02';

    // Contador de ítems (usado en la primera fila)
    final itemsCount = (data['items'] as List<dynamic>?)?.length ?? 0;

    // FILA 1 - DATOS DEL DOCUMENTO (Formato exacto solicitado)
    rows.add([
      data['fechaEmision'], // Fecha de emisión YYYY-MM-DD
      serieCorrelativo, // Serie y correlativo T###-#########
      tipoDocumento, // Tipo de documento (09)
      itemsCount.toString(), // Cantidad de ítems sin padding
      '', // Cantidad de guías de referencia
      '', // Cantidad documentos relacionados
      isPrivado ? '1' : '', // Cantidad conductores relacionados
      isPrivado ? '1' : '', // Cantidad números de placas relacionados
      '', // Cantidad contenedores y precintos relacionados
      data['horaEmision'],
    ]);
    LoggerService.info('FILA 1: ${rows.last}');

    // FILA 2 - GUIA DE REMISION DE REFERENCIA
    rows.add(['', '', '', '', '']);
    LoggerService.info('FILA 2: ${rows.last}');

    // FILA 3 - DOCUMENTOS RELACIONADOS
    rows.add(['', '', '', '', '', '']);
    LoggerService.info('FILA 3: ${rows.last}');

    // FILA 4 - DATOS DEL CONDUCTOR
    // Según especificación: Si modalidad es privada (02) - datos del conductor obligatorios
    // Si modalidad es pública (01) - no ingresar datos del conductor
    final conductorData = data['conductor'] ?? {};
    if (isPrivado) {
      rows.add([
        conductorData['numeroDocumento'] ?? '',
        '1', // Tipo documento siempre es 1 para DNI
        conductorData['nombres'] ?? '',
        conductorData['apellidos'] ?? '',
        conductorData['licencia'] ?? '',
        'ATTACH_DOC'
      ]);
    } else {
      // Si es transporte público, dejamos datos del conductor vacíos
      rows.add(['', '', '', '', '', 'ATTACH_DOC']);
    }
    LoggerService.info('FILA 4: ${rows.last}');

    // FILA 5 - DATOS DE VEHÍCULOS
    // Según especificación: Si modalidad es privada (02) - datos del vehículo obligatorios
    // Si modalidad es pública (01) - no ingresar datos del vehículo
    final vehiculoData = data['vehiculo'] ?? {};
    if (isPrivado) {
      // Log para depuración
      LoggerService.info('DATOS VEHÍCULO: ${vehiculoData.toString()}');

      // Validar que la placa no esté vacía para transporte privado
      final placa = vehiculoData['placa'] ?? '';
      if (placa.isEmpty) {
        LoggerService.error(
            'ERROR: La placa del vehículo es obligatoria para transporte privado');
        throw Exception(
            'La placa del vehículo es obligatoria para transporte privado');
      }

      rows.add([placa, '', '', '', 'ATTACH_DOC']);
    } else {
      rows.add(['', '', '', '', 'ATTACH_DOC']);
    }
    LoggerService.info('FILA 5: ${rows.last}');

    // FILA 6 - DATOS DE CONTENEDORES
    rows.add([
      data['contenedor']?['numero'] ?? '',
      data['contenedor']?['precinto'] ?? '',
      '',
      '',
    ]);
    LoggerService.info('FILA 6: ${rows.last}');
    // FILA 7 - DATOS DEL REMITENTE
    final remitenteData = data['remitente'] ?? {};
    rows.add([
      remitenteData['razonSocial'] ?? '', // M, an..250
      remitenteData['tipoDocumento'] ?? '', // M, n1
      rucRemitente, // M, an11 - Usar el RUC exacto sin normalizar
      remitenteData['ubigeo'] ?? '', // C, n6
      remitenteData['direccion'] ?? '', // C, an..100
      remitenteData['urbanizacion'] ?? '', // C, an..25
      remitenteData['provincia'] ?? '', // C, an..30
      remitenteData['departamento'] ?? '', // C, an..30
      remitenteData['distrito'] ?? '', // C, an..30
      'PE', // C, an2
      '',
      '',
    ]);
    LoggerService.info('FILA 7: ${rows.last}');
    // FILA 8 - DATOS DEL DESTINATARIO
    final destinatarioData = data['destinatario'] ?? {};
    rows.add([
      destinatarioData['razonSocial'] ?? '', // M, an..250
      destinatarioData['tipoDocumento'] ?? '', // M, n1
      destinatarioData['numeroDocumento'] ?? '', // M, an..15
      destinatarioData['ubigeo'] ?? '', // C, n6
      destinatarioData['direccion'] ?? '', // C, an..100
      destinatarioData['urbanizacion'] ?? '', // C, an..25
      destinatarioData['provincia'] ?? '', // C, an..30
      destinatarioData['departamento'] ?? '', // C, an..30
      destinatarioData['distrito'] ?? '', // C, an..30
      'PE', // C, an2
      '',
    ]);
    LoggerService.info('FILA 8: ${rows.last}');
    // FILA 9 - DATOS DEL PROVEEDOR
    final proveedorData = data['proveedor'] ?? {};
    rows.add([
      proveedorData['razonSocial'] ?? '',
      proveedorData['tipoDocumento'] ?? '',
      proveedorData['numeroDocumento'] ?? '',
      proveedorData['ubigeo'] ?? '',
      proveedorData['direccion'] ?? '',
      proveedorData['urbanizacion'] ?? '',
      proveedorData['provincia'] ?? '',
      proveedorData['departamento'] ?? '',
      proveedorData['distrito'] ?? '',
      '',
      '',
    ]);
    LoggerService.info('FILA 9: ${rows.last}');
    // FILA 10 - DATOS DEL ENVÍO
    // Para transporte público (01): incluir datos del transportista
    // Para transporte privado (02): los datos del transportista NO DEBEN ser enviados
    final transportistaData = data['envio']?['transportista'] ?? {};

    // Datos del transporte
    final motivoTraslado = envioData['motivoTraslado'] ?? '';
    final modalidadTraslado = envioData['modalidadTraslado'] ?? '';
    final pesoBruto = envioData['pesoBruto']?.toString() ??
        '0'; // Convertir a string sin formato
    final unidadMedida =
        envioData['unidadMedida'] ?? ''; // No usar valor predeterminado
    final fechaInicioTraslado = envioData['fechaInicioTraslado'] ?? '';
    //final indicadorM1L = data['transporteData']?['indicadorM1L'] ??
    //  'NO'; // Obtener el indicador real

    // Datos del transportista (solo para modalidad pública - 01)
    final razonSocialTransportista =
        isPrivado ? '' : transportistaData['razonSocial'] ?? '';
    final tipoDocTransportista = isPrivado ? '' : '6'; // 6 - RUC
    final rucTransportista = isPrivado ? '' : transportistaData['ruc'] ?? '';

    // Datos de partida y llegada
    final puntoPartida = data['envio']?['puntoPartida'] ?? {};
    final puntoLlegada = data['envio']?['puntoLlegada'] ?? {};

    rows.add([
      motivoTraslado, // M, an2
      '', // Descripción motivo ya no se usa
      data['indicadorM1L'] == 'SI'
          ? 'SUNAT_Envio_IndicadorTrasladoVehiculoM1L'
          : '', // C, an..50
      pesoBruto, // M, n(12,3)
      unidadMedida, // M, an4
      modalidadTraslado, // M, n2
      fechaInicioTraslado, // C, an10
      razonSocialTransportista, // C, an..250 - Solo si es transporte público
      tipoDocTransportista, // C, n1 - Solo si es transporte público
      rucTransportista, // C, n11 - Solo si es transporte público
      puntoPartida['ubigeo'] ?? '',
      puntoPartida['direccion'] ?? '',
      puntoPartida['urbanizacion'] ?? '',
      puntoPartida['provincia'] ?? '',
      puntoPartida['departamento'] ?? '',
      puntoPartida['distrito'] ?? '',
      puntoLlegada['ubigeo'] ?? '',
      puntoLlegada['direccion'] ?? '',
      puntoLlegada['urbanizacion'] ?? '',
      puntoLlegada['provincia'] ?? '',
      puntoLlegada['departamento'] ?? '',
      puntoLlegada['distrito'] ?? '',
    ]);
    LoggerService.info('FILA 10: ${rows.last}');
    // FILA 11 - OBSERVACIONES
    // Obtener la información de campo, jirón y cuartel de los detalles de carga
    String infoDetalleCarga = '';
    if (data['items'] != null && (data['items'] as List).isNotEmpty) {
      final campos = <String>{};
      final jirones = <String>{};
      final cuarteles = <String>{};
      final variedades = <String>{};

      for (final item in data['items']) {
        // Log para depurar cada item
        LoggerService.info('ITEM: ${item.toString()}');

        if (item['campo'] != null && item['campo'].toString().isNotEmpty) {
          campos.add(item['campo'].toString());
        }
        if (item['jiron'] != null && item['jiron'].toString().isNotEmpty) {
          jirones.add(item['jiron'].toString());
        }
        if (item['cuartel'] != null && item['cuartel'].toString().isNotEmpty) {
          cuarteles.add(item['cuartel'].toString());
        }
        if (item['variedad'] != null &&
            item['variedad'].toString().isNotEmpty) {
          variedades.add(item['variedad'].toString());
        }
      }

      if (campos.isNotEmpty || jirones.isNotEmpty || cuarteles.isNotEmpty) {
        final partes = <String>[];
        if (campos.isNotEmpty) {
          partes.add('Campo: ${campos.join(', ')}');
        }
        if (jirones.isNotEmpty) {
          partes.add('Jiron: ${jirones.join(', ')}');
        }
        if (cuarteles.isNotEmpty) {
          partes.add('Cuartel: ${cuarteles.join(', ')}');
        }
        if (variedades.isNotEmpty) {
          partes.add('Variedad: ${variedades.join(', ')}');
        }
        infoDetalleCarga = partes.join(' | ');
      }
    }

    // Crear observaciones combinadas
    final observacionesPrincipales = data['observaciones'] ?? '';
    String observacionesCombinadas = observacionesPrincipales;

    // Añadir información de detalle carga si existe
    if (infoDetalleCarga.isNotEmpty) {
      if (observacionesCombinadas.isNotEmpty) {
        observacionesCombinadas += ' | ';
      }
      observacionesCombinadas += infoDetalleCarga;
    }

    // Añadir una sola fila con toda la información
    rows.add([
      observacionesCombinadas, // Columna A: Combina observaciones principales y detalle carga
      ''
    ]);
    LoggerService.info('FILA 11 (Observaciones): ${rows.last}');

    // FILA 12 - DATOS DE LOS BIENES
    for (final item in (data['items'] ?? [])) {
      rows.add([
        (item['numero']?.toString() ?? ''), // M, n..4
        item['unidadMedida'] ?? '', // M, an..3
        item['descripcionUnidad'] ?? '', // M, an..15
        item['cantidad']?.toString() ??
            '', // M, n(12,10) - Ahora usamos toString() sin formateo específico
        item['descripcion'] ?? '', // C, an..250
        item['codigo'] ?? '', // C, an..30
        item['codigoSunat'] ?? '', // C, an..8
      ]);
    }
    LoggerService.info('FILA 12: ${rows.last}');

    // FILA 13 - SEPARADOR FINAL (Obligatorio)
    rows.add(['FF00FF']); // M, an6

    // Generar CSV y guardar
    final csvContent = rows.map((row) => row.join(',')).join('\n');

    // Crear nombre de archivo según formato SUNAT: <RucEmisor>-<CodigoTipoDocumento>-<SerieYcorrelativo>.csv
    final nombreArchivo = '$rucRemitente-$tipoDocumento-$serieCorrelativo';
    final nombreArchivoConExtension = '$nombreArchivo.csv';

    // Obtener el directorio de descargas
    final directory = Directory('/storage/emulated/0/Download');

    if (!await directory.exists()) {
      throw Exception('NO SE PUDO ACCEDER AL DIRECTORIO DE DESCARGAS');
    }

    final guiasDirectory = Directory('${directory.path}/Guias');
    if (!await guiasDirectory.exists()) {
      await guiasDirectory.create(recursive: true);
    }

    // Verificar si el archivo existe y eliminarlo antes de crear uno nuevo
    final filePath = '${guiasDirectory.path}/$nombreArchivoConExtension';
    final file = File(filePath);

    try {
      if (await file.exists()) {
        await file.delete();
        // Esperar un momento para asegurar que el sistema de archivos se actualice
        await Future.delayed(const Duration(milliseconds: 100));
      }

      await file.writeAsString(csvContent,
          encoding: utf8, mode: FileMode.writeOnly);
      debugPrint('ARCHIVO CSV GENERADO EN: ${file.path}');
      return filePath; // Retornamos la ruta completa con extensión
    } catch (e) {
      throw Exception('ERROR AL GENERAR EL ARCHIVO CSV: $e');
    }
  }
}
