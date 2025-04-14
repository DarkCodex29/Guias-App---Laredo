import 'dart:convert';
import 'dart:io';
import 'package:app_guias/core/constants/efact.endpoints.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:dio/dio.dart';
import 'package:app_guias/services/log/logger.service.dart';

class TokenResponse {
  final String accessToken;
  final String tokenType;
  final int expiresIn;
  final String scope;
  final String jti;

  TokenResponse({
    required this.accessToken,
    required this.tokenType,
    required this.expiresIn,
    required this.scope,
    required this.jti,
  });

  factory TokenResponse.fromJson(Map<String, dynamic> json) {
    return TokenResponse(
      accessToken: json['access_token'] as String,
      tokenType: json['token_type'] as String,
      expiresIn: json['expires_in'] as int,
      scope: json['scope'] as String,
      jti: json['jti'] as String,
    );
  }
}

class EfactService {
  final Dio _dio = Dio();
  TokenResponse? _tokenResponse;
  final String _baseUrl;

  // CREDENCIALES PARA EFACT
  String get _clientId => dotenv.env['EFACT_CLIENT_USERNAME'] ?? '';
  String get _clientSecret => dotenv.env['EFACT_CLIENT_PASSWORD'] ?? '';
  String get _basicAuth =>
      'Basic ${base64Encode(utf8.encode('$_clientId:$_clientSecret'))}';

  EfactService() : _baseUrl = dotenv.env['EFACT_BASE_URL'] ?? '';

  // Obtener token de autorización
  Future<TokenResponse?> getToken() async {
    try {
      final username = dotenv.env['EFACT_USERNAME'];
      final password = dotenv.env['EFACT_PASSWORD'];

      final formData = {
        'username': username,
        'password': password,
        'grant_type': 'password',
      };

      final response = await _dio.post(
        '$_baseUrl${EfactEndpoints.token}',
        data: formData,
        options: Options(
          headers: {
            'Content-Type': 'application/x-www-form-urlencoded',
            'Authorization': _basicAuth,
          },
          contentType: Headers.formUrlEncodedContentType,
          validateStatus: (status) => true,
        ),
      );

      LoggerService.info('RESPUESTA TOKEN: ${response.data}');

      if (response.statusCode == 200 && response.data != null) {
        _tokenResponse = TokenResponse.fromJson(response.data);
        return _tokenResponse;
      } else if (response.data != null &&
          response.data is Map &&
          response.data.containsKey('error')) {
        final errorCode = response.data['error'] ?? 'unknown_error';
        final errorMessage =
            response.data['error_description'] ?? response.data['error'];
        LoggerService.error('Error de autenticación EFACT: $errorMessage');
        throw Exception('$errorMessage [Código: $errorCode]');
      } else {
        LoggerService.error(
            'Error de respuesta EFACT: ${response.statusCode} - ${response.data}');
        throw Exception(
            'Error en el servicio de facturación [Código: ${response.statusCode}]');
      }
    } catch (e) {
      if (e is Exception && e.toString().contains('[Código:')) {
        rethrow;
      }
      LoggerService.error('Error al obtener token EFACT: $e');
      throw Exception(
          'No se pudo conectar con el servicio de facturación [Código: connection_error]');
    }
  }

  // Proceso completo de envío de guía de manera secuencial
  Future<Map<String, dynamic>> processGuide(String filePath) async {
    String generatedPdfPath = '';
    try {
      LoggerService.info('INICIANDO PROCESAMIENTO DE GUÍA: $filePath');

      try {
        _tokenResponse = await getToken();
        if (_tokenResponse == null) {
          return {
            'success': false,
            'code': 'token_error',
            'message': 'Error de autenticación con el servicio de facturación',
            'pdfPath': generatedPdfPath,
          };
        }
      } catch (authError) {
        String errorMessage =
            authError.toString().replaceAll('Exception: ', '');
        String errorCode = 'unknown_error';

        final codeRegex = RegExp(r'\[Código: (.*?)\]');
        final codeMatch = codeRegex.firstMatch(errorMessage);
        if (codeMatch != null) {
          errorCode = codeMatch.group(1) ?? 'unknown_error';
          errorMessage =
              errorMessage.replaceAll(codeMatch.group(0) ?? '', '').trim();
        }

        return {
          'success': false,
          'code': errorCode,
          'message': errorMessage,
          'pdfPath': generatedPdfPath,
        };
      }

      final ticket = await sendDocument(filePath);

      if (ticket.isEmpty) {
        LoggerService.error('NO SE OBTUVO TICKET DE ENVÍO. PROCESO CANCELADO.');
        return {
          'success': false,
          'code': 'document_error',
          'message': 'No se obtuvo ticket de envío',
          'pdfPath': generatedPdfPath,
        };
      }

      final cdrResponse = await getCdr(ticket);

      if (!cdrResponse['success']) {
        final errorCode = cdrResponse['code'];
        final errorMessage = cdrResponse['message'];
        LoggerService.error(
            'CDR NO DISPONIBLE O CON ERROR: [Código: $errorCode] $errorMessage');

        return {
          'success': false,
          'code': errorCode,
          'message': errorMessage,
          'pdfPath': generatedPdfPath,
        };
      }

      LoggerService.info('CDR VERIFICADO CORRECTAMENTE. OBTENIENDO PDF...');
      await Future.delayed(const Duration(seconds: 2));

      final String nombreBaseArchivo = filePath.endsWith('.csv')
          ? filePath.substring(0, filePath.length - 4)
          : filePath;

      generatedPdfPath = await getPdf(ticket, nombreBaseArchivo);

      if (generatedPdfPath.isEmpty) {
        LoggerService.error('NO SE PUDO GENERAR EL PDF.');
        return {
          'success': false,
          'code': 'pdf_error',
          'message': 'No se pudo generar el PDF',
          'pdfPath': generatedPdfPath,
        };
      }

      LoggerService.info(
          'PROCESO FINALIZADO EXITOSAMENTE. PDF GENERADO: $generatedPdfPath');
      return {
        'success': true,
        'code': '0',
        'message': 'Guía procesada correctamente',
        'pdfPath': generatedPdfPath,
      };
    } catch (e) {
      LoggerService.error('ERROR EN PROCESAMIENTO DE GUÍA: $e');
      return {
        'success': false,
        'code': 'process_error',
        'message': 'Error en procesamiento de guía: $e',
        'pdfPath': generatedPdfPath,
      };
    }
  }

  // Enviar documento CSV
  Future<String> sendDocument(String filePath) async {
    try {
      final filePathWithExtension =
          filePath.endsWith('.csv') ? filePath : '$filePath.csv';
      final fileObj = File(filePathWithExtension);

      if (!await fileObj.exists()) {
        LoggerService.error(
            'ERROR: EL ARCHIVO NO EXISTE: $filePathWithExtension');
        return '';
      }

      // Crear el nombre del archivo según especificaciones SUNAT
      final String fileName = filePathWithExtension.split('/').last;

      LoggerService.info('ENVIANDO ARCHIVO: $fileName');

      final formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(
          fileObj.path,
          filename: fileName,
        ),
      });

      final response = await _dio.post(
        '$_baseUrl${EfactEndpoints.document}',
        data: formData,
        options: Options(
          headers: {
            'Authorization': 'Bearer ${_tokenResponse!.accessToken}',
          },
          validateStatus: (status) => true,
        ),
      );

      LoggerService.info('RESPUESTA DOCUMENTO: ${response.data}');

      if (response.statusCode == 200 && response.data != null) {
        final responseCode = response.data['code'];
        final responseDesc = response.data['description'];

        if (responseCode != null) {
          LoggerService.info('CÓDIGO DE RESPUESTA: $responseCode');

          if (responseCode != 0 && responseCode != '0') {
            LoggerService.error(
                'ERROR EN EL ENVÍO DEL DOCUMENTO: [Código: $responseCode] $responseDesc');
            return '';
          }
        }
        return responseDesc ?? '';
      }

      return '';
    } catch (e) {
      LoggerService.error('ERROR AL ENVIAR DOCUMENTO: $e');
      return '';
    }
  }

  // Obtener CDR
  Future<Map<String, dynamic>> getCdr(String ticket) async {
    try {
      if (ticket.isEmpty) {
        LoggerService.error('ERROR: TICKET VACÍO EN LA SOLICITUD DE CDR');
        return {
          'success': false,
          'code': 'empty_ticket',
          'message': 'Ticket vacío en la solicitud'
        };
      }

      // Implementar reintentos para el código 202 (En proceso)
      final int maxIntentos = 30;
      final Duration tiempoEspera = const Duration(seconds: 6);

      for (int intento = 1; intento <= maxIntentos; intento++) {
        LoggerService.info(
            'CONSULTANDO CDR PARA TICKET: $ticket (Intento $intento de $maxIntentos)');

        final response = await _dio.get(
          '$_baseUrl${EfactEndpoints.cdr}/$ticket',
          options: Options(
            headers: {
              'Authorization': 'Bearer ${_tokenResponse!.accessToken}',
            },
            validateStatus: (status) => true,
          ),
        );

        LoggerService.info('RESPUESTA CDR: ${response.data}');
        LoggerService.info('CÓDIGO DE ESTADO CDR: ${response.statusCode}');

        // Verificar si la respuesta es exitosa
        if (response.statusCode == 200) {
          LoggerService.info('CDR OBTENIDO EXITOSAMENTE');
          return {
            'success': true,
            'code': '0',
            'message': 'CDR obtenido exitosamente'
          };
        }
        // Si el código es 202 o tenemos code -9998 (En proceso), esperamos y reintentamos
        else if (response.statusCode == 202 ||
            (response.data is Map &&
                response.data['code'] != null &&
                response.data['code'] == -9998)) {
          final mensaje = response.data is Map
              ? response.data['description'] ?? 'En proceso.'
              : 'En proceso.';
          LoggerService.info(
              'CDR EN PROCESO: $mensaje. Reintentando en ${tiempoEspera.inSeconds} segundos...');

          // Si no es el último intento, esperamos y continuamos
          if (intento < maxIntentos) {
            await Future.delayed(tiempoEspera);
            continue;
          }
        }
        // Si tenemos un error específico de validación u otro error conocido (no 202/En proceso)
        else if (response.data is Map && response.data['code'] != null) {
          final errorCode = response.data['code'];
          final errorDescription =
              response.data['description'] ?? 'Error sin descripción';

          LoggerService.error(
              'ERROR EN CDR: [Código: $errorCode] $errorDescription');
          return {
            'success': false,
            'code': errorCode.toString(),
            'message': errorDescription,
          };
        }

        // Si llegamos aquí en el último intento o con otro error, retornamos un error genérico
        if (intento == maxIntentos) {
          LoggerService.error(
              'CDR NO DISPONIBLE DESPUÉS DE $maxIntentos INTENTOS. CÓDIGO: ${response.statusCode}');
          return {
            'success': false,
            'code': 'cdr_timeout',
            'message': 'CDR no disponible después de $maxIntentos intentos'
          };
        } else {
          LoggerService.error(
              'ERROR AL OBTENER CDR. CÓDIGO: ${response.statusCode}');
          return {
            'success': false,
            'code': response.statusCode.toString(),
            'message': 'Error al obtener CDR'
          };
        }
      }

      // Nunca debería llegar aquí, pero por si acaso
      return {
        'success': false,
        'code': 'unexpected_error',
        'message': 'Error inesperado'
      };
    } catch (e) {
      LoggerService.error('EXCEPCIÓN AL OBTENER CDR: $e');
      return {
        'success': false,
        'code': 'cdr_exception',
        'message': 'Excepción: $e'
      };
    }
  }

  // Obtener PDF (solo si CDR es exitoso)
  Future<String> getPdf(String ticket, [String? nombreBaseArchivo]) async {
    try {
      // Implementar reintentos para el código 202 (En proceso)
      final int maxIntentos = 30;
      final Duration tiempoEspera = const Duration(seconds: 6);

      for (int intento = 1; intento <= maxIntentos; intento++) {
        LoggerService.info(
            'CONSULTANDO PDF PARA TICKET: $ticket (Intento $intento de $maxIntentos)');

        final response = await _dio.get(
          '$_baseUrl${EfactEndpoints.pdf}/$ticket',
          options: Options(
            headers: {
              'Authorization': 'Bearer ${_tokenResponse!.accessToken}',
            },
            responseType: ResponseType.bytes,
            validateStatus: (status) => true,
          ),
        );

        LoggerService.info(
            'RESPUESTA PDF - STATUS CODE: ${response.statusCode}');

        if (response.statusCode == 200) {
          final directory = Directory('/storage/emulated/0/Download/Guias');
          if (!await directory.exists()) {
            await directory.create(recursive: true);
          }

          String filePath;
          if (nombreBaseArchivo != null && nombreBaseArchivo.isNotEmpty) {
            // Usar el mismo nombre base que el CSV, solo cambiar la extensión
            final fileName = nombreBaseArchivo.split('/').last;
            filePath = '${directory.path}/$fileName.pdf';
            LoggerService.info(
                'GUARDANDO PDF CON EL MISMO NOMBRE QUE EL CSV: $fileName.pdf');
          } else {
            // Fallback al nombre anterior basado en ticket
            filePath = '${directory.path}/guia_$ticket.pdf';
            LoggerService.info(
                'GUARDANDO PDF CON NOMBRE BASADO EN TICKET: guia_$ticket.pdf');
          }

          final file = File(filePath);
          await file.writeAsBytes(response.data);
          return file.path;
        }
        // Si el código es 202, esperamos y reintentamos
        else if (response.statusCode == 202) {
          LoggerService.info(
              'PDF EN PROCESO. Reintentando en ${tiempoEspera.inSeconds} segundos... (Intento $intento de $maxIntentos)');

          // Si no es el último intento, esperamos y continuamos
          if (intento < maxIntentos) {
            await Future.delayed(tiempoEspera);
            continue;
          }
        }

        // Si llegamos al último intento sin éxito
        if (intento == maxIntentos) {
          LoggerService.error(
              'PDF NO DISPONIBLE DESPUÉS DE $maxIntentos INTENTOS. CÓDIGO: ${response.statusCode}');
          return '';
        }
      }

      return '';
    } catch (e) {
      LoggerService.error('ERROR AL GUARDAR PDF: $e');
      return '';
    }
  }

  // Obtener XML (opcional, por ahora no se usa)
  Future<String> getXml(String ticket) async {
    try {
      final response = await _dio.get(
        '$_baseUrl${EfactEndpoints.xml}/$ticket',
        options: Options(
          headers: {
            'Authorization': 'Bearer ${_tokenResponse!.accessToken}',
          },
          responseType: ResponseType.bytes,
        ),
      );

      if (response.statusCode == 200) {
        final directory = Directory('/storage/emulated/0/Download/Guias');
        if (!await directory.exists()) {
          await directory.create(recursive: true);
        }

        final file = File('${directory.path}/guia_$ticket.xml');
        await file.writeAsBytes(response.data);
        return file.path;
      }
      return '';
    } catch (e) {
      return '';
    }
  }
}
