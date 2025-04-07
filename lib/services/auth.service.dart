import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'dart:io';
import '../core/constants/api.endpoints.dart';

class AuthService {
  final Dio _dio;
  final String baseUrl;

  AuthService({required this.baseUrl})
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

  Future<Map<String, dynamic>> login(String username, String password) async {
    try {
      final response = await _dio.post(
        ApiEndpoints.login,
        data: {
          'username': username,
          'password': password,
        },
      );

      if (response.statusCode == 200 && response.data != null) {
        return {
          'success': true,
          'token': response.data['token'],
          'role': response.data['role'],
          'userId': response.data['userId'],
          'username': response.data['username'],
        };
      }

      return {
        'success': false,
        'message': response.data?['message'] ??
            'Error al iniciar sesión (${response.statusCode})',
      };
    } on DioException catch (e) {
      String errorMessage;
      if (e.type == DioExceptionType.connectionTimeout) {
        errorMessage = 'Tiempo de espera agotado';
      } else if (e.type == DioExceptionType.connectionError) {
        errorMessage =
            'No se pudo conectar al servidor. Verifica tu conexión a internet y que la URL sea correcta';
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
        'message': 'Error inesperado al iniciar sesión',
      };
    }
  }

  Future<bool> validateToken(String token) async {
    try {
      final response = await _dio.get(
        ApiEndpoints.validate,
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );

      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }

  Future<bool> logout(String token) async {
    try {
      final response = await _dio.post(
        ApiEndpoints.logout,
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
        data: '',
      );

      if (response.statusCode == 200) {
        final message = response.data['message'];
        return message == 'Sesión cerrada exitosamente';
      }

      return false;
    } catch (e) {
      return false;
    }
  }
}
