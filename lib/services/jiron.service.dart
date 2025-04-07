import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'dart:io';
import 'package:app_guias/models/vista.jiron.dart';
import 'package:app_guias/core/constants/api.endpoints.dart';

class JironService {
  final Dio _dio;
  final String baseUrl;

  JironService({required this.baseUrl})
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

  Future<Map<String, dynamic>> getAllJirones({
    int page = 1,
    int pageSize = 50,
    bool all = true,
  }) async {
    try {
      final response = await _dio.get(
        ApiEndpoints.jirones,
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
        'message': response.data?['message'] ?? 'Error al obtener jirones',
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
        'message': 'Error inesperado al obtener jirones',
      };
    }
  }

  Future<Map<String, dynamic>> getJironByCodigo(String jiron) async {
    try {
      final endpoint = ApiEndpoints.jironById.replaceAll('{jiron}', jiron);
      final response = await _dio.get(endpoint);

      if (response.statusCode == 200 && response.data != null) {
        return {
          'success': true,
          'data': response.data['data'] ?? response.data,
        };
      }

      return {
        'success': false,
        'message': response.data?['message'] ?? 'Jirón no encontrado',
      };
    } on DioException catch (e) {
      return {
        'success': false,
        'message': e.response?.data?['message'] ?? 'Error al obtener jirón',
      };
    } catch (e) {
      return {
        'success': false,
        'message': 'Error inesperado al obtener jirón',
      };
    }
  }

  Future<Map<String, dynamic>> getJironesByCampo(
    String campo, {
    int page = 1,
    int pageSize = 50,
    bool all = true,
  }) async {
    try {
      final endpoint =
          ApiEndpoints.jironesByCampo.replaceAll('{campo}', campo.trim());
      final response = await _dio.get(
        endpoint,
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
        'message':
            response.data?['message'] ?? 'Error al obtener jirones del campo',
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
        'message': 'Error inesperado al obtener jirones del campo',
      };
    }
  }

  String formatJironDisplay(VistaJiron jiron) {
    return jiron.jiron.trim();
  }

  String? extractJironCode(String displayText) {
    try {
      return displayText.split(' - ')[0];
    } catch (e) {
      return null;
    }
  }

  String? extractJironDescripcion(String displayText) {
    try {
      return displayText.split(' - ')[1];
    } catch (e) {
      return null;
    }
  }
}
