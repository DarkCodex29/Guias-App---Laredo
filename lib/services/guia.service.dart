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

  // Método para obtener el correlativo directamente desde el backend
  Future<Map<String, dynamic>> getCorrelativo() async {
    try {
      LoggerService.info('Obteniendo correlativo desde el servicio...');

      final response = await _dio.get(ApiEndpoints.guiaCorrelativo);

      if (response.statusCode == 200 && response.data != null) {
        final correlativo = response.data['correlativo'];
        LoggerService.info('Correlativo obtenido con éxito: $correlativo');

        // Extraer la serie y el número del correlativo
        final parts = correlativo.split('-');
        if (parts.length >= 2) {
          final serie = parts[0];
          final numero = parts[1];
          return {
            'success': true,
            'data': {
              'correlativo': correlativo,
              'serie': serie,
              'numero': numero
            }
          };
        } else {
          return {
            'success': true,
            'data': {'correlativo': correlativo}
          };
        }
      }

      return {
        'success': false,
        'message':
            response.data?['message'] ?? 'Error al obtener el correlativo'
      };
    } catch (e) {
      LoggerService.error('Error al obtener correlativo: ${e.toString()}');
      return {
        'success': false,
        'message':
            'Error de conexión al obtener el correlativo: ${e.toString()}'
      };
    }
  }
}
