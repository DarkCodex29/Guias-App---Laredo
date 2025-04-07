import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:app_guias/services/log/logger.service.dart';

class ApiService {
  final String baseUrl;
  final String? token;
  late final Dio _dio;

  ApiService({
    required this.baseUrl,
    this.token,
  }) {
    // Log solo la inicialización del servicio
    LoggerService.info('ApiService inicializado: $baseUrl');

    _dio = Dio(BaseOptions(
      baseUrl: baseUrl,
      headers: {
        'Content-Type': 'application/json',
        'accept': 'application/json',
      },
      validateStatus: (status) => status! < 500,
    ));

    // Configurar Dio para aceptar certificados SSL autofirmados
    (_dio.httpClientAdapter as IOHttpClientAdapter).createHttpClient = () {
      final client = HttpClient();
      client.badCertificateCallback = (cert, host, port) => true;
      return client;
    };
  }

  Future<Map<String, String>> get _headers async {
    final headers = {
      'Content-Type': 'application/json',
      'accept': 'application/json',
    };

    if (token != null) {
      headers['Authorization'] = 'Bearer $token';
    }

    return headers;
  }

  Future<dynamic> get(String endpoint,
      {Map<String, dynamic>? queryParameters}) async {
    try {
      final response = await _dio.get(
        endpoint,
        queryParameters: queryParameters,
        options: Options(headers: await _headers),
      );

      if (response.statusCode == 200) {
        return response.data;
      } else {
        // Log solo errores
        LoggerService.error(
            'Error GET: ${response.statusCode} - ${response.data}');
        throw Exception(
            'Error en la petición GET: ${response.statusCode}\n${response.data}');
      }
    } on DioException catch (e) {
      LoggerService.error('Error Dio (GET): ${e.message}', e.stackTrace);
      throw Exception('Error de conexión: ${e.message}\n${e.response?.data}');
    } catch (e) {
      LoggerService.error('Error general (GET): $e');
      throw Exception('Error de conexión: $e');
    }
  }

  Future<dynamic> post(String endpoint, dynamic data,
      {Options? options}) async {
    try {
      final response = await _dio.post(
        endpoint,
        data: data,
        options: options ?? Options(headers: await _headers),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.data;
      } else {
        LoggerService.error(
            'Error POST: ${response.statusCode} - ${response.data}');
        throw Exception(
            'Error en la petición POST: ${response.statusCode}\n${response.data}');
      }
    } on DioException catch (e) {
      LoggerService.error('Error Dio (POST): ${e.message}', e.stackTrace);
      throw Exception('Error de conexión: ${e.message}\n${e.response?.data}');
    } catch (e) {
      LoggerService.error('Error general (POST): $e');
      throw Exception('Error de conexión: $e');
    }
  }

  Future<dynamic> put(String endpoint, Map<String, dynamic> body) async {
    try {
      final response = await _dio.put(
        endpoint,
        data: body,
        options: Options(headers: await _headers),
      );

      if (response.statusCode == 200) {
        return response.data;
      } else {
        LoggerService.error(
            'Error PUT: ${response.statusCode} - ${response.data}');
        throw Exception(
            'Error en la petición PUT: ${response.statusCode}\n${response.data}');
      }
    } on DioException catch (e) {
      LoggerService.error('Error Dio (PUT): ${e.message}', e.stackTrace);
      throw Exception('Error de conexión: ${e.message}\n${e.response?.data}');
    } catch (e) {
      LoggerService.error('Error general (PUT): $e');
      throw Exception('Error de conexión: $e');
    }
  }

  Future<void> delete(String endpoint) async {
    try {
      final response = await _dio.delete(
        endpoint,
        options: Options(headers: await _headers),
      );

      if (response.statusCode != 200 && response.statusCode != 204) {
        LoggerService.error(
            'Error DELETE: ${response.statusCode} - ${response.data}');
        throw Exception(
            'Error en la petición DELETE: ${response.statusCode}\n${response.data}');
      }
    } on DioException catch (e) {
      LoggerService.error('Error Dio (DELETE): ${e.message}', e.stackTrace);
      throw Exception('Error de conexión: ${e.message}\n${e.response?.data}');
    } catch (e) {
      LoggerService.error('Error general (DELETE): $e');
      throw Exception('Error de conexión: $e');
    }
  }

  void dispose() {
    _dio.close();
  }
}
