import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:app_guias/core/constants/api.endpoints.dart';
import 'package:app_guias/models/usuario.dart';
import 'package:app_guias/services/log/logger.service.dart';
import 'dart:io';

class UsuarioService {
  final Dio _dio;
  final String baseUrl;

  UsuarioService({required this.baseUrl})
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

  Future<Map<String, dynamic>> getAllUsuarios({
    int page = 1,
    int pageSize = 10,
    bool all = false,
  }) async {
    try {
      final response = await _dio.get(
        ApiEndpoints.usuarios,
        queryParameters: {
          'page': page,
          'pageSize': pageSize,
          'all': all,
        },
      );

      if (response.statusCode == 200) {
        return {
          'usuarios': (response.data['data'] as List)
              .map((json) => Usuario.fromJson(json))
              .toList(),
          'page': response.data['page'],
          'pageSize': response.data['pageSize'],
          'totalCount': response.data['totalCount'],
          'totalPages': response.data['totalPages'],
          'hasPrevious': response.data['hasPrevious'],
          'hasNext': response.data['hasNext'],
        };
      }

      throw Exception('Error al obtener usuarios: ${response.statusCode}');
    } catch (e) {
      LoggerService.error('Error al obtener usuarios: $e');
      throw Exception('Error al obtener usuarios: $e');
    }
  }

  Future<Usuario> getUsuarioById(int id) async {
    try {
      final response = await _dio.get(
        ApiEndpoints.usuarioById.replaceAll('{id}', id.toString()),
      );

      if (response.statusCode == 200) {
        return Usuario.fromJson(response.data['data']);
      }

      throw Exception('Error al obtener usuario: ${response.statusCode}');
    } catch (e) {
      LoggerService.error('Error al obtener usuario: $e');
      throw Exception('Error al obtener usuario: $e');
    }
  }

  Future<bool> update(int id, Map<String, dynamic> data) async {
    try {
      final response = await _dio.put(
        '${ApiEndpoints.usuarios}/$id',
        data: data,
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return true;
      }

      throw Exception(
          'Error al actualizar usuario: ${response.statusCode} - ${response.data}');
    } catch (e) {
      throw Exception('Error al actualizar usuario: $e');
    }
  }

  Future<bool> deleteUsuario(int id) async {
    try {
      LoggerService.info('Iniciando petición DELETE para usuario ID: $id');

      final response = await _dio.delete(
        ApiEndpoints.usuarioById.replaceAll('{id}', id.toString()),
      );

      LoggerService.info(
          'Respuesta del servidor - Status: ${response.statusCode}, Data: ${response.data}');

      // 204 significa éxito sin contenido
      if (response.statusCode == 200 || response.statusCode == 204) {
        LoggerService.info('Usuario eliminado correctamente');
        return true;
      }

      LoggerService.error(
          'Error al eliminar usuario: Status ${response.statusCode}');
      throw Exception('Error al eliminar usuario: ${response.statusCode}');
    } catch (e) {
      LoggerService.error('Error al eliminar usuario: $e');
      throw Exception('Error al eliminar usuario: $e');
    }
  }

  Future<Map<String, dynamic>?> register(Map<String, dynamic> data) async {
    try {
      LoggerService.info('Iniciando petición POST para registro de usuario');
      LoggerService.info('Datos a enviar: $data');

      final response = await _dio.post(
        ApiEndpoints.registroUsuario,
        data: data,
      );

      LoggerService.info(
          'Respuesta del servidor - Status: ${response.statusCode}, Data: ${response.data}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        LoggerService.info('Usuario registrado correctamente');
        return response.data;
      }

      LoggerService.error(
          'Error al registrar usuario: Status ${response.statusCode}');
      throw Exception(
          'Error al registrar usuario: ${response.statusCode} - ${response.data}');
    } catch (e) {
      LoggerService.error('Error al registrar usuario: $e');
      throw Exception('Error al registrar usuario: $e');
    }
  }

  Future<bool> uploadUsuariosExcel(File file) async {
    try {
      String fileName = file.path.split('/').last;
      final formData = FormData.fromMap({
        "file": await MultipartFile.fromFile(file.path, filename: fileName),
      });

      final response = await _dio.post(
        '${ApiEndpoints.registroUsuario}/carga-masiva',
        data: formData,
        options: Options(
          contentType: 'multipart/form-data',
        ),
      );

      if (response.statusCode == 200) {
        return response.data['success'] ?? false;
      }

      throw Exception('Error al cargar usuarios: ${response.statusCode}');
    } catch (e) {
      LoggerService.error('Error al cargar usuarios: $e');
      throw Exception('Error al cargar usuarios: $e');
    }
  }
}
