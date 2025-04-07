import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'dart:io';
import '../core/constants/api.endpoints.dart';

class TransportistaService {
  final Dio _dio;
  final String baseUrl;

  TransportistaService({required this.baseUrl})
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

  Future<Map<String, dynamic>> getTransportistas(
      {int page = 1, int pageSize = 50}) async {
    try {
      final response = await _dio.get(
        ApiEndpoints.transportistas,
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
        'message':
            response.data?['message'] ?? 'Error al obtener transportistas',
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
        'message': 'Error inesperado al obtener transportistas',
      };
    }
  }

  Future<Map<String, dynamic>> getTransportistaByCodigo(String codigo) async {
    try {
      final endpoint =
          ApiEndpoints.transportistaByCodigo.replaceAll('{codTransp}', codigo);
      final response = await _dio.get(endpoint);

      if (response.statusCode == 200 && response.data != null) {
        if (response.data == null ||
            (response.data is Map && response.data.isEmpty) ||
            (response.data is String && response.data.isEmpty)) {
          return {
            'success': true,
            'data': null,
          };
        }

        return {
          'success': true,
          'data': response.data['data'] ?? response.data,
        };
      }

      return {
        'success': false,
        'message': response.data?['message'] ?? 'Transportista no encontrado',
      };
    } on DioException catch (e) {
      return {
        'success': false,
        'message':
            e.response?.data?['message'] ?? 'Error al obtener transportista',
      };
    } catch (e) {
      return {
        'success': false,
        'message': 'Error inesperado al obtener transportista',
      };
    }
  }

  Future<Map<String, dynamic>> getTransportistaByRuc(String ruc) async {
    try {
      final endpoint = ApiEndpoints.transportistaByRuc.replaceAll('{ruc}', ruc);
      final response = await _dio.get(endpoint);

      if (response.statusCode == 200 && response.data != null) {
        if (response.data == null ||
            (response.data is Map && response.data.isEmpty) ||
            (response.data is String && response.data.isEmpty)) {
          return {
            'success': true,
            'data': null,
          };
        }

        return {
          'success': true,
          'data': response.data['data'] ?? response.data,
        };
      }

      return {
        'success': false,
        'message': response.data?['message'] ?? 'Transportista no encontrado',
      };
    } on DioException catch (e) {
      return {
        'success': false,
        'message':
            e.response?.data?['message'] ?? 'Error al obtener transportista',
      };
    } catch (e) {
      return {
        'success': false,
        'message': 'Error inesperado al obtener transportista',
      };
    }
  }
}
