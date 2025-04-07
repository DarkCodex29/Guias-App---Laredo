import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'dart:io';
import 'package:app_guias/models/vista.cuartel.dart';
import 'package:app_guias/core/constants/api.endpoints.dart';

class CuartelService {
  final Dio _dio;
  final String baseUrl;

  CuartelService({required this.baseUrl})
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

  Future<Map<String, dynamic>> getAllCuarteles({
    int page = 1,
    int pageSize = 50,
    bool all = true,
  }) async {
    try {
      final response = await _dio.get(
        ApiEndpoints.cuarteles,
        queryParameters: {
          'page': page,
          'pageSize': pageSize,
          'all': all,
        },
      );

      if (response.statusCode == 200 && response.data != null) {
        return {
          'success': true,
          'data': response.data['data'] ?? [],
          'total': response.data['total'] ?? 0,
          'page': response.data['page'] ?? page,
          'pageSize': response.data['pageSize'] ?? pageSize,
        };
      }

      return {
        'success': false,
        'message': response.data?['message'] ?? 'Error al obtener cuarteles',
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
        'message': 'Error inesperado al obtener cuarteles',
      };
    }
  }

  Future<Map<String, dynamic>> getCuartelByCodigo(String cuartel) async {
    try {
      final endpoint =
          ApiEndpoints.cuartelById.replaceAll('{cuartel}', cuartel);
      final response = await _dio.get(endpoint);

      if (response.statusCode == 200 && response.data != null) {
        return {
          'success': true,
          'data': response.data['data'] ?? response.data,
        };
      }

      return {
        'success': false,
        'message': response.data?['message'] ?? 'Cuartel no encontrado',
      };
    } on DioException catch (e) {
      return {
        'success': false,
        'message': e.response?.data?['message'] ?? 'Error al obtener cuartel',
      };
    } catch (e) {
      return {
        'success': false,
        'message': 'Error inesperado al obtener cuartel',
      };
    }
  }

  Future<Map<String, dynamic>> getCuartelesByCampo(
    String campo, {
    int page = 1,
    int pageSize = 50,
    bool all = true,
  }) async {
    try {
      final endpoint =
          ApiEndpoints.cuartelesByCampo.replaceAll('{campo}', campo.trim());
      final response = await _dio.get(
        endpoint,
        queryParameters: {
          'page': page,
          'pageSize': pageSize,
          'all': all,
        },
      );

      if (response.statusCode == 200 && response.data != null) {
        final data = response.data['data'] as List;

        return {
          'success': true,
          'data': data,
          'total': response.data['totalCount'] ?? 0,
          'page': response.data['page'] ?? page,
          'pageSize': response.data['pageSize'] ?? pageSize,
          'totalPages': response.data['totalPages'] ?? 1,
          'hasNext': response.data['hasNext'] ?? false,
          'hasPrevious': response.data['hasPrevious'] ?? false,
        };
      }

      return {
        'success': false,
        'message':
            response.data?['message'] ?? 'Error al obtener cuarteles del campo',
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
        'message': 'Error inesperado al obtener cuarteles del campo',
      };
    }
  }

  String formatCuartelDisplay(VistaCuartel cuartel) {
    final formatted = cuartel.cuartel.trim();
    return formatted;
  }

  String? extractCuartelCode(String displayText) {
    try {
      final code = displayText.split(' - ')[0].trim();
      return code;
    } catch (e) {
      return null;
    }
  }

  String? extractCuartelDescripcion(String displayText) {
    try {
      final desc = displayText.split(' - ')[1].trim();
      return desc;
    } catch (e) {
      return null;
    }
  }
}
