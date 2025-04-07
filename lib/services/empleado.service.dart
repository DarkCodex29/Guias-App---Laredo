import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'dart:io';
import 'package:app_guias/core/constants/api.endpoints.dart';

class EmpleadoService {
  final Dio _dio;
  final String baseUrl;

  EmpleadoService({required this.baseUrl})
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

  Future<Map<String, dynamic>> getAllEmpleados(
      {int page = 1, int pageSize = 50}) async {
    try {
      final response = await _dio.get(
        ApiEndpoints.empleados,
        queryParameters: {'page': page, 'pageSize': pageSize},
      );

      if (response.statusCode == 200 && response.data != null) {
        return {
          'success': true,
          'data': response.data['data'] ?? [],
          'total': response.data['total'] ?? 0,
          'page': response.data['page'] ?? 1,
          'pageSize': response.data['pageSize'] ?? pageSize,
        };
      }

      return {
        'success': false,
        'message': response.data?['message'] ?? 'Error al obtener empleados',
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
        'message': 'Error inesperado al obtener empleados',
      };
    }
  }

  Future<Map<String, dynamic>> getEmpleadoByDni(String dni) async {
    try {
      final endpoint = ApiEndpoints.empleadoByDni.replaceAll('{dni}', dni);
      final response = await _dio.get(endpoint);

      if (response.statusCode == 200 && response.data != null) {
        return {
          'success': true,
          'data': response.data['data'] ?? response.data,
        };
      }

      return {
        'success': false,
        'message': response.data?['message'] ?? 'Empleado no encontrado',
      };
    } on DioException catch (e) {
      return {
        'success': false,
        'message': e.response?.data?['message'] ?? 'Error al obtener empleado',
      };
    } catch (e) {
      return {
        'success': false,
        'message': 'Error inesperado al obtener empleado',
      };
    }
  }

  Future<Map<String, dynamic>> getEmpleadoByEmpleado(String empleado) async {
    try {
      final endpoint =
          ApiEndpoints.empleadoByEmpleado.replaceAll('{empleado}', empleado);
      final response = await _dio.get(endpoint);

      if (response.statusCode == 200 && response.data != null) {
        return {
          'success': true,
          'data': response.data['data'] ?? response.data,
        };
      }

      return {
        'success': false,
        'message': response.data?['message'] ?? 'Empleado no encontrado',
      };
    } on DioException catch (e) {
      return {
        'success': false,
        'message': e.response?.data?['message'] ?? 'Error al obtener empleado',
      };
    } catch (e) {
      return {
        'success': false,
        'message': 'Error inesperado al obtener empleado',
      };
    }
  }

  Future<Map<String, dynamic>> empleadoExiste(String codigo) async {
    try {
      final endpoint =
          ApiEndpoints.empleadoExiste.replaceAll('{codigo}', codigo);
      final response = await _dio.get(endpoint);

      if (response.statusCode == 200) {
        return {
          'success': true,
          'empleado': response.data['empleado'],
          'codigo': response.data['codigo'],
          'dni': response.data['dni'],
          'cdTransp': response.data['cdTransp'],
        };
      }

      return {
        'success': false,
        'message': response.data?['message'] ?? 'Error al verificar empleado',
      };
    } on DioException catch (e) {
      return {
        'success': false,
        'message':
            e.response?.data?['message'] ?? 'Error al verificar empleado',
      };
    } catch (e) {
      return {
        'success': false,
        'message': 'Error inesperado al verificar empleado',
      };
    }
  }
}
