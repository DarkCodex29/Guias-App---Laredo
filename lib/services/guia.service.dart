import 'dart:convert';
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'dart:io';
import 'package:app_guias/core/constants/api.endpoints.dart';
import 'package:app_guias/services/log/logger.service.dart';
import 'package:http_parser/http_parser.dart';

class GuiaService {
  final Dio _dio;
  final String baseUrl;

  GuiaService({required this.baseUrl})
      : _dio = Dio(
          BaseOptions(
            baseUrl: baseUrl,
            contentType: 'application/json',
            responseType: ResponseType.json,
            validateStatus: (status) => true,
            headers: {
              'accept': 'application/json',
              'Content-Type': 'application/json',
            },
          ),
        ) {
    (_dio.httpClientAdapter as IOHttpClientAdapter).createHttpClient = () {
      final client = HttpClient();
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    };
  }

  void setToken(String token) {
    _dio.options.headers['Authorization'] = 'Bearer $token';
  }

  String _blobToBase64(Uint8List blob) {
    return base64Encode(blob);
  }

  Uint8List _base64ToBlob(String base64String) {
    return base64Decode(base64String);
  }

  Future<Map<String, dynamic>> uploadGuia(
      String nombre, Uint8List archivo, String idUsuario) async {
    try {
      // Crear FormData para enviar como multipart/form-data
      final formData = FormData.fromMap({
        'Archivo': MultipartFile.fromBytes(
          archivo,
          filename: nombre,
          contentType: MediaType('application', 'pdf'),
        ),
        'Nombre': nombre,
        'IdUsuario': int.parse(idUsuario),
      });

      final response = await _dio.post(
        ApiEndpoints.guias,
        data: formData,
        options: Options(
          contentType: 'multipart/form-data',
        ),
      );

      if (response.statusCode == 200 && response.data != null) {
        return {
          'success': true,
          'data': response.data['data'],
        };
      }

      return {
        'success': false,
        'message': response.data?['message'] ?? 'Error al subir la guía',
      };
    } on DioException catch (e) {
      String errorMessage;
      if (e.type == DioExceptionType.connectionTimeout) {
        errorMessage = 'Tiempo de espera agotado';
      } else if (e.type == DioExceptionType.connectionError) {
        errorMessage = 'No se pudo conectar al servidor';
      } else {
        errorMessage =
            e.response?.data?['message'] ?? 'Error de conexión: ${e.message}';
      }

      return {
        'success': false,
        'message': errorMessage,
      };
    } catch (e) {
      return {
        'success': false,
        'message': 'Error inesperado al subir la guía',
      };
    }
  }

  Future<Map<String, dynamic>> downloadGuia(int id) async {
    try {
      LoggerService.info('Iniciando descarga de guía con ID: $id');
      final endpoint = ApiEndpoints.guiaById.replaceAll('{id}', id.toString());
      LoggerService.info('Endpoint: $endpoint');

      final response = await _dio.get(endpoint);
      LoggerService.info(
          'Respuesta recibida - Status code: ${response.statusCode}');
      LoggerService.info('Respuesta body: ${response.data}');

      if (response.statusCode == 200 && response.data != null) {
        // Si la respuesta contiene directamente los datos de la guía (sin array)
        if (response.data is Map &&
            response.data.containsKey('id') &&
            response.data.containsKey('nombre') &&
            response.data.containsKey('archivo')) {
          LoggerService.info('La respuesta contiene directamente la guía');
          final guia = response.data;

          if (guia['archivo'] == null || guia['archivo'].toString().isEmpty) {
            LoggerService.error(
                'El archivo no existe o está vacío en la respuesta del servidor');
            return {
              'success': false,
              'message': 'El archivo no existe o está vacío',
            };
          }

          try {
            final bytes = _base64ToBlob(guia['archivo']);
            LoggerService.info(
                'Archivo decodificado correctamente. Tamaño: ${bytes.length} bytes');
            return {
              'success': true,
              'data': bytes,
            };
          } catch (decodeError) {
            LoggerService.error(
                'Error al decodificar el archivo base64: $decodeError');
            return {
              'success': false,
              'message': 'Error al decodificar el archivo: $decodeError',
            };
          }
        }

        // Si la respuesta contiene un objeto data que es un array
        if (response.data is Map && response.data.containsKey('data')) {
          final dataList = response.data['data'];

          if (dataList == null) {
            LoggerService.error(
                'Campo data es nulo en la respuesta del servidor');
            return {
              'success': false,
              'message': 'Estructura de respuesta inválida (data es nulo)'
            };
          }

          if (dataList is List) {
            LoggerService.info(
                'La respuesta contiene una lista de guías. Buscando guía con ID: $id');

            // Buscar la guía con el ID solicitado
            Map<String, dynamic>? guia;
            for (var item in dataList) {
              if (item is Map && item['id'] == id) {
                guia = Map<String, dynamic>.from(item);
                break;
              }
            }

            if (guia == null) {
              LoggerService.error(
                  'No se encontró la guía con ID $id en la respuesta');
              return {
                'success': false,
                'message': 'No se encontró la guía solicitada',
              };
            }

            LoggerService.info('Guía encontrada: ${guia['nombre']}');

            if (guia['archivo'] == null || guia['archivo'].toString().isEmpty) {
              LoggerService.error(
                  'El archivo no existe o está vacío en la guía');
              return {
                'success': false,
                'message': 'El archivo no existe o está vacío',
              };
            }

            try {
              final bytes = _base64ToBlob(guia['archivo']);
              LoggerService.info(
                  'Archivo decodificado correctamente. Tamaño: ${bytes.length} bytes');
              return {
                'success': true,
                'data': bytes,
              };
            } catch (decodeError) {
              LoggerService.error(
                  'Error al decodificar el archivo base64: $decodeError');
              return {
                'success': false,
                'message': 'Error al decodificar el archivo: $decodeError',
              };
            }
          } else if (dataList is Map) {
            // Si data es un solo objeto, no un array
            final guia = dataList;

            LoggerService.info(
                'Datos de guía recibidos: ${guia['nombre'] ?? 'Nombre no disponible'}');

            if (guia['archivo'] == null || guia['archivo'].toString().isEmpty) {
              LoggerService.error(
                  'El archivo no existe o está vacío en la guía');
              return {
                'success': false,
                'message': 'El archivo no existe o está vacío',
              };
            }

            try {
              final bytes = _base64ToBlob(guia['archivo']);
              LoggerService.info(
                  'Archivo decodificado correctamente. Tamaño: ${bytes.length} bytes');
              return {
                'success': true,
                'data': bytes,
              };
            } catch (decodeError) {
              LoggerService.error(
                  'Error al decodificar el archivo base64: $decodeError');
              return {
                'success': false,
                'message': 'Error al decodificar el archivo: $decodeError',
              };
            }
          }
        }

        // Si llegamos aquí, la estructura de la respuesta no es la esperada
        LoggerService.error(
            'Estructura de respuesta inesperada: ${response.data}');
        return {
          'success': false,
          'message': 'Estructura de respuesta inesperada',
        };
      }

      LoggerService.error(
          'Error en la respuesta: ${response.statusCode} - ${response.data}');
      return {
        'success': false,
        'message': response.data?['message'] ??
            'Error al descargar la guía (Status: ${response.statusCode})',
      };
    } on DioException catch (e) {
      String errorDetail = '';
      if (e.response != null) {
        errorDetail =
            'Status: ${e.response?.statusCode}, Data: ${e.response?.data}';
      } else {
        errorDetail = e.message ?? 'Error desconocido';
      }

      LoggerService.error('Error DioException al descargar guía: $errorDetail');
      return {
        'success': false,
        'message': e.response?.data?['message'] ??
            'Error al descargar la guía: $errorDetail',
      };
    } catch (e) {
      LoggerService.error('Error inesperado al descargar guía: $e');
      return {
        'success': false,
        'message': 'Error inesperado al descargar la guía: $e',
      };
    }
  }

  Future<Map<String, dynamic>> getGuiasByUsuario({
    required String idUsuario,
    bool all = false,
  }) async {
    try {
      final String endpoint =
          ApiEndpoints.guiasByUsuario.replaceAll('{idUsuario}', idUsuario);

      final response = await _dio.get(
        endpoint,
        queryParameters: {
          'all': all,
        },
      );

      if (response.statusCode == 200 && response.data != null) {
        return {
          'success': true,
          'data': response.data,
        };
      }

      return {
        'success': false,
        'message': response.data?['message'] ?? 'Error al obtener las guías',
      };
    } on DioException catch (e) {
      return {
        'success': false,
        'message': e.response?.data?['message'] ?? 'Error al obtener las guías',
      };
    } catch (e) {
      return {
        'success': false,
        'message': 'Error inesperado al obtener las guías',
      };
    }
  }

  Future<Map<String, dynamic>> getGuiaById(int id) async {
    try {
      final endpoint = ApiEndpoints.guiaById.replaceAll('{id}', id.toString());
      final response = await _dio.get(endpoint);

      if (response.statusCode == 200 && response.data != null) {
        return {
          'success': true,
          'data': response.data['data'],
        };
      }

      return {
        'success': false,
        'message': response.data?['message'] ?? 'Error al obtener la guía',
      };
    } on DioException catch (e) {
      String errorMessage;
      if (e.type == DioExceptionType.connectionTimeout) {
        errorMessage = 'Tiempo de espera agotado';
      } else if (e.type == DioExceptionType.connectionError) {
        errorMessage = 'No se pudo conectar al servidor';
      } else {
        errorMessage =
            e.response?.data?['message'] ?? 'Error de conexión: ${e.message}';
      }

      return {
        'success': false,
        'message': errorMessage,
      };
    } catch (e) {
      return {
        'success': false,
        'message': 'Error inesperado al obtener la guía',
      };
    }
  }

  // Obtener todas las guías
  Future<Map<String, dynamic>> getAllGuias({bool all = false}) async {
    try {
      final response = await _dio.get(
        ApiEndpoints.guias,
        queryParameters: {
          'all': all,
        },
      );

      if (response.statusCode == 200 && response.data != null) {
        LoggerService.info(
            'Respuesta completa de getAllGuias: \\${response.data}');
        return {
          'success': true,
          'data': response.data['data'] ?? [],
          'total': response.data['totalCount'] ?? 0,
          'totalPages': response.data['totalPages'] ?? 1,
        };
      }

      return {
        'success': false,
        'message': response.data?['message'] ?? 'Error al obtener las guías',
      };
    } on DioException catch (e) {
      return {
        'success': false,
        'message': e.response?.data?['message'] ?? 'Error al obtener las guías',
      };
    } catch (e) {
      return {
        'success': false,
        'message': 'Error inesperado al obtener las guías',
      };
    }
  }

  // POST /api/guias - Crear nueva guía
  Future<Map<String, dynamic>> createGuia(
      String nombre, Uint8List archivo, String idUsuario) async {
    try {
      final base64Archivo = _blobToBase64(archivo);
      final response = await _dio.post(
        ApiEndpoints.guias,
        data: {
          'nombre': nombre,
          'archivo': base64Archivo,
          'idUsuario': idUsuario,
        },
      );

      if (response.statusCode == 200 && response.data != null) {
        return {
          'success': true,
          'data': response.data['data'],
        };
      }

      return {
        'success': false,
        'message': response.data?['message'] ?? 'Error al crear la guía',
      };
    } on DioException catch (e) {
      String errorMessage;
      if (e.type == DioExceptionType.connectionTimeout) {
        errorMessage = 'Tiempo de espera agotado';
      } else if (e.type == DioExceptionType.connectionError) {
        errorMessage = 'No se pudo conectar al servidor';
      } else {
        errorMessage =
            e.response?.data?['message'] ?? 'Error de conexión: ${e.message}';
      }

      return {
        'success': false,
        'message': errorMessage,
      };
    } catch (e) {
      return {
        'success': false,
        'message': 'Error inesperado al crear la guía',
      };
    }
  }

  // Obtener última guía para extraer el correlativo
  Future<Map<String, dynamic>> getLastGuia() async {
    try {
      LoggerService.info(
          '-------- INICIO: Consultando última guía para obtener correlativo --------');

      // Verificar token antes de consultar
      if (_dio.options.headers['Authorization'] == null ||
          (_dio.options.headers['Authorization'] as String).isEmpty) {
        LoggerService.error('No hay token de autorización configurado');
        return {
          'success': false,
          'message': 'Error de autenticación: No hay token configurado',
        };
      }

      // Realizar petición exactamente como se muestra en el ejemplo curl
      LoggerService.info(
          'Enviando petición GET a: ${ApiEndpoints.guias} con parámetros: page=1, pageSize=1, all=false');
      final response = await _dio.get(
        ApiEndpoints.guias,
        queryParameters: {
          'page': 1,
          'pageSize': 1,
          'all': false,
        },
      );

      LoggerService.info('Respuesta status: ${response.statusCode}');
      LoggerService.info('Respuesta headers: ${response.headers}');
      LoggerService.info('Respuesta data: ${response.data}');

      // Verificar respuesta según el formato del ejemplo
      if (response.statusCode == 200 && response.data != null) {
        // Verificar que tenemos el campo data
        if (!response.data.containsKey('data')) {
          LoggerService.warning(
              'Respuesta no contiene el campo data: ${response.data}');
          return {
            'success': false,
            'message': 'Formato de respuesta inválido',
          };
        }

        // Verificar que data es un array con al menos un elemento
        final List<dynamic> data = response.data['data'] ?? [];
        if (data.isEmpty) {
          LoggerService.warning('No se encontraron guías en el servidor');
          return {
            'success': false,
            'message': 'No se encontraron guías en el servidor',
          };
        }

        // Obtener la primera guía (la más reciente según el orden)
        final Map<String, dynamic> lastGuia = data[0];
        LoggerService.info('Primera guía en la respuesta: $lastGuia');

        // Verificar que tiene el campo nombre
        if (!lastGuia.containsKey('nombre') || lastGuia['nombre'] == null) {
          LoggerService.warning('La guía no tiene nombre: $lastGuia');
          return {
            'success': false,
            'message': 'La guía no tiene un nombre válido',
          };
        }

        // Obtener el nombre y extraer el correlativo
        final String nombreGuia = lastGuia['nombre'].toString();
        LoggerService.info('Última guía obtenida - Nombre: $nombreGuia');

        // Primero intentamos con el patrón completo como en el ejemplo: 20132377783-09-T002-00000695.pdf
        final RegExp fullRegExp = RegExp(r'\d+-\d+-([A-Z]\d{3})-(\d{8})');
        final fullMatch = fullRegExp.firstMatch(nombreGuia);
        LoggerService.info(
            'Intentando extraer con patrón completo: $fullRegExp');

        if (fullMatch != null && fullMatch.groupCount >= 2) {
          final serie = fullMatch.group(1) ?? '';
          final correlativoStr = fullMatch.group(2) ?? '';
          final correlativoNum = int.tryParse(correlativoStr) ?? 0;

          LoggerService.info(
              'ÉXITO! Correlativo extraído del nombre completo: $correlativoStr (Serie: $serie, Valor numérico: $correlativoNum)');
          LoggerService.info(
              '-------- FIN: Correlativo obtenido con éxito --------');

          return {
            'success': true,
            'data': {
              'nombre': nombreGuia,
              'serie': serie,
              'correlativo': correlativoStr,
              'correlativoNum': correlativoNum,
              'guiaCompleta': lastGuia,
            },
          };
        }

        // Si el anterior no funciona, intentamos con un patrón más simple
        LoggerService.info(
            'Patrón completo falló, intentando con patrón simple...');
        final RegExp regExp = RegExp(r'([A-Z]\d{3})-(\d{8})');
        final match = regExp.firstMatch(nombreGuia);
        LoggerService.info('Intentando extraer con patrón simple: $regExp');

        if (match != null && match.groupCount >= 2) {
          final serie = match.group(1) ?? '';
          final correlativoStr = match.group(2) ?? '';
          final correlativoNum = int.tryParse(correlativoStr) ?? 0;

          LoggerService.info(
              'ÉXITO! Correlativo extraído del patrón simple: $correlativoStr (Serie: $serie, Valor numérico: $correlativoNum)');
          LoggerService.info(
              '-------- FIN: Correlativo obtenido con éxito --------');

          return {
            'success': true,
            'data': {
              'nombre': nombreGuia,
              'serie': serie,
              'correlativo': correlativoStr,
              'correlativoNum': correlativoNum,
              'guiaCompleta': lastGuia,
            },
          };
        }

        // Si no se pudo extraer con ninguno de los patrones, registramos el error
        LoggerService.warning(
            'FALLO! No se pudo extraer el correlativo del nombre: $nombreGuia');
        LoggerService.info(
            '-------- FIN: No se pudo extraer el correlativo --------');
        return {
          'success': false,
          'message':
              'No se pudo extraer el correlativo del nombre: $nombreGuia',
        };
      }

      // Si la respuesta no es 200 o no tiene el formato esperado
      LoggerService.warning(
          'Respuesta no válida del servidor: ${response.statusCode} - ${response.data}');
      LoggerService.info('-------- FIN: Respuesta no válida --------');
      return {
        'success': false,
        'message': response.data?['message'] ??
            'Error al obtener la última guía (${response.statusCode})',
      };
    } on DioException catch (e) {
      String errorMessage;
      if (e.type == DioExceptionType.connectionTimeout) {
        errorMessage = 'Tiempo de espera agotado';
      } else if (e.type == DioExceptionType.connectionError) {
        errorMessage = 'No se pudo conectar al servidor';
      } else {
        errorMessage = 'Error de conexión: ${e.message}';
        if (e.response != null) {
          errorMessage += ' (Status: ${e.response?.statusCode})';
        }
      }

      LoggerService.error('Error Dio al obtener última guía: $errorMessage');
      LoggerService.error('Detalles de la excepción: $e');
      LoggerService.info('-------- FIN: Error de red --------');
      return {
        'success': false,
        'message': errorMessage,
      };
    } catch (e) {
      LoggerService.error('Error inesperado al obtener última guía: $e');
      LoggerService.info('-------- FIN: Error inesperado --------');
      return {
        'success': false,
        'message': 'Error inesperado al obtener la última guía: $e',
      };
    }
  }
}
