import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app_guias/providers/usuario.provider.dart';
import 'package:app_guias/services/log/logger.service.dart';

class RegistroUsuarioController extends ChangeNotifier {
  final formKey = GlobalKey<FormState>();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final nombresController = TextEditingController();
  final apellidosController = TextEditingController();
  final roleController = TextEditingController();
  bool isLoading = false;
  String? error;
  final dynamic usuario;
  UsuarioProvider? _usuarioProvider;

  RegistroUsuarioController({this.usuario}) {
    if (usuario != null) {
      usernameController.text = usuario.username;
      nombresController.text = usuario.nombres;
      apellidosController.text = usuario.apellidos;
      roleController.text =
          usuario.rol == 'ADMINISTRADOR' ? 'Administrador' : 'Usuario';
    }
  }

  void prepareProviders(BuildContext context) {
    _usuarioProvider = context.read<UsuarioProvider>();
  }

  void setRole(String role) {
    roleController.text = role == 'USUARIO' ? 'Usuario' : 'Administrador';
    notifyListeners();
  }

  String? validateRequired(String? value) {
    if (value == null || value.isEmpty) {
      return 'Este campo es requerido';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'La contraseña es requerida';
    }
    if (value.length < 8) {
      return 'La contraseña debe tener al menos 8 caracteres';
    }
    return null;
  }

  String? getFieldError(String field) {
    switch (field) {
      case 'username':
        return validateRequired(usernameController.text);
      case 'password':
        return usuario == null
            ? validatePassword(passwordController.text)
            : null;
      case 'names':
        return validateRequired(nombresController.text);
      case 'surnames':
        return validateRequired(apellidosController.text);
      case 'role':
        return validateRequired(roleController.text);
      default:
        return null;
    }
  }

  Map<String, dynamic> _processForm({bool isUpdate = false}) {
    final userData = {
      'username': usernameController.text.trim(),
      'password': passwordController.text.isEmpty && isUpdate
          ? usuario.contrasena
          : passwordController.text,
      'names': nombresController.text.trim(),
      'surnames': apellidosController.text.trim(),
      'role': roleController.text == 'Usuario' ? 'USUARIO' : 'ADMINISTRADOR',
      'email':
          'usuario.${usernameController.text.trim().toLowerCase()}@appguias.com',
    };

    if (isUpdate && usuario != null) {
      userData['id'] = usuario.id;
    }

    return userData;
  }

  Future<bool> register(Map<String, dynamic> userData) async {
    try {
      LoggerService.info('Iniciando registro de usuario con datos: $userData');

      if (_usuarioProvider == null) {
        LoggerService.error('UsuarioProvider no inicializado');
        error = 'Error interno: Proveedor no inicializado';
        return false;
      }

      final response = await _usuarioProvider!.createUsuario(userData);
      LoggerService.info('Respuesta del servidor: $response');

      if (response != null) {
        LoggerService.info('Usuario registrado exitosamente');
        error = null;
        return true;
      } else {
        final errorMsg =
            _usuarioProvider!.error ?? 'Error desconocido al registrar usuario';
        LoggerService.error('Error al registrar usuario: $errorMsg');
        error = errorMsg;
        return false;
      }
    } catch (e) {
      LoggerService.error('Error inesperado al registrar usuario: $e');
      error = e.toString();
      return false;
    }
  }

  Future<bool> update() async {
    if (_usuarioProvider == null) {
      throw Exception(
          'Provider no inicializado. Llame a prepareProviders primero.');
    }

    try {
      LoggerService.info('Iniciando actualización de usuario...');
      final userData = _processForm(isUpdate: true);
      LoggerService.info('Datos del formulario procesados: $userData');

      final response =
          await _usuarioProvider!.updateUsuario(usuario.id, userData);
      LoggerService.info('Respuesta de la actualización: $response');

      if (response != null) {
        LoggerService.info('Usuario actualizado exitosamente');
        return true;
      } else {
        final errorMessage = _usuarioProvider!.error ?? 'Error desconocido';
        LoggerService.error('Error al actualizar usuario: $errorMessage');
        error = errorMessage;
        return false;
      }
    } catch (e) {
      LoggerService.error('Error inesperado al actualizar usuario: $e');
      error = e.toString();
      return false;
    }
  }

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    nombresController.dispose();
    apellidosController.dispose();
    roleController.dispose();
    super.dispose();
  }
}
