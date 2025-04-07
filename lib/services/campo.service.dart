import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'dart:io';
import 'package:app_guias/core/constants/api.endpoints.dart';
import 'package:app_guias/models/vista.campo.dart';

class CampoService {
  final Dio _dio;
  final String baseUrl;

  CampoService({required this.baseUrl})
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

  Future<Map<String, dynamic>> getAllCampos(
      {int page = 1, int pageSize = 50, bool all = false}) async {
    try {
      final response = await _dio.get(
        ApiEndpoints.campos,
        queryParameters: {
          'page': page,
          'pageSize': all ? 1000 : pageSize,
          'all': all,
        },
      );

      if (response.statusCode == 200 && response.data != null) {
        final List<VistaCampo> campos = (response.data['data'] as List)
            .map((json) => VistaCampo.fromJson(json))
            .toList()
          ..sort((a, b) => a.descCampo.compareTo(b.descCampo));

        return {
          'success': true,
          'data': campos,
          'total': response.data['totalCount'] ?? 0,
          'page': response.data['page'] ?? 1,
          'pageSize': response.data['pageSize'] ?? pageSize,
        };
      }

      return {
        'success': false,
        'message': response.data?['message'] ?? 'Error al obtener campos',
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
        'message': 'Error inesperado al obtener campos',
      };
    }
  }

  Future<Map<String, dynamic>> getCampoById(String campo) async {
    try {
      final endpoint = ApiEndpoints.campoById.replaceAll('{campo}', campo);
      final response = await _dio.get(endpoint);

      if (response.statusCode == 200 && response.data != null) {
        return {
          'success': true,
          'data': VistaCampo.fromJson(response.data['data']),
        };
      }

      return {
        'success': false,
        'message': response.data?['message'] ?? 'Campo no encontrado',
      };
    } on DioException catch (e) {
      return {
        'success': false,
        'message': e.response?.data?['message'] ?? 'Error al obtener campo',
      };
    } catch (e) {
      return {
        'success': false,
        'message': 'Error inesperado al obtener campo',
      };
    }
  }

  String formatCampoDisplay(VistaCampo campo) {
    return '${campo.campo} - ${campo.descCampo}';
  }

  String? extractCampoCode(String displayText) {
    try {
      return displayText.split(' - ')[0];
    } catch (e) {
      return null;
    }
  }

  String? extractCampoDescripcion(String displayText) {
    try {
      return displayText.split(' - ')[1];
    } catch (e) {
      return null;
    }
  }
}
