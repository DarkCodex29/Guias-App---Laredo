import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'dart:io';
import 'package:app_guias/core/constants/api.endpoints.dart';

class EquipoService {
  final Dio _dio;
  final String baseUrl;

  EquipoService({required this.baseUrl})
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

  Future<Map<String, dynamic>> getAllEquipos(
      {int page = 1, int pageSize = 50}) async {
    try {
      final response = await _dio.get(
        ApiEndpoints.equipos,
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
        'message': response.data?['message'] ?? 'Error al obtener equipos',
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
        'message': 'Error inesperado al obtener equipos',
      };
    }
  }

  Future<Map<String, dynamic>> getEquipoByCodigo(String codigo) async {
    try {
      final endpoint =
          ApiEndpoints.equipoById.replaceAll('{codEquipo}', codigo);

      final response = await _dio.get(endpoint);

      if (response.statusCode == 200 && response.data != null) {
        return {
          'success': true,
          'data': response.data['data'] ?? response.data,
        };
      }
      return {
        'success': false,
        'message': response.data?['message'] ?? 'Equipo no encontrado',
      };
    } on DioException catch (e) {
      return {
        'success': false,
        'message': e.response?.data?['message'] ?? 'Error al obtener equipo',
      };
    } catch (e) {
      return {
        'success': false,
        'message': 'Error inesperado al obtener equipo',
      };
    }
  }

  Future<Map<String, dynamic>> getEquipoByPlaca(String placa) async {
    try {
      final placaLimpia = placa.trim().toUpperCase();
      final endpoint =
          ApiEndpoints.equipoByPlaca.replaceAll('{placa}', placaLimpia);

      final response = await _dio.get(endpoint);

      if (response.statusCode == 200 && response.data != null) {
        return {
          'success': true,
          'data': response.data,
        };
      }
      return {
        'success': false,
        'message': response.data?['message'] ?? 'Equipo no encontrado',
      };
    } on DioException catch (e) {
      return {
        'success': false,
        'message': e.response?.data?['message'] ?? 'Error al obtener equipo',
      };
    } catch (e) {
      return {
        'success': false,
        'message': 'Error inesperado al obtener equipo',
      };
    }
  }

  Future<Map<String, dynamic>> getEquiposByTransportista(
      String codTransp) async {
    try {
      final endpoint = ApiEndpoints.equiposByTransportista
          .replaceAll('{codTransp}', codTransp);

      final response = await _dio.get(endpoint);

      if (response.statusCode == 200 && response.data != null) {
        return {
          'success': true,
          'data': response.data['data'] ?? response.data,
        };
      }
      return {
        'success': false,
        'message': response.data?['message'] ?? 'No se encontraron equipos',
      };
    } on DioException catch (e) {
      return {
        'success': false,
        'message': e.response?.data?['message'] ?? 'Error al obtener equipos',
      };
    } catch (e) {
      return {
        'success': false,
        'message': 'Error inesperado al obtener equipos',
      };
    }
  }
}
