import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app_guias/providers/usuario.provider.dart';

class RegistroUsuarioController extends ChangeNotifier {
  final formKey = GlobalKey<FormState>();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final emailController = TextEditingController();
  final nombresController = TextEditingController();
  final apellidosController = TextEditingController();
  final roleController = TextEditingController();

  bool _isLoading = false;
  String? _error;
  dynamic _usuario;
  UsuarioProvider? _usuarioProvider;

  bool get isLoading => _isLoading;
  String? get error => _error;

  RegistroUsuarioController({dynamic usuario}) {
    _usuario = usuario;
    if (usuario != null) {
      usernameController.text = usuario.username;
      emailController.text = usuario.email;
      nombresController.text = usuario.nombres;
      apellidosController.text = usuario.apellidos;
      roleController.text =
          usuario.rol == 'ADMINISTRADOR' ? 'Administrador' : 'Usuario';
    }
  }

  // Método para preparar los providers antes de operaciones asíncronas
  void prepareProviders(BuildContext context) {
    _usuarioProvider = Provider.of<UsuarioProvider>(context, listen: false);
  }

  String? validateRequired(String? value) {
    if (value == null || value.isEmpty) {
      return 'Este campo es requerido';
    }
    return null;
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'El email es requerido';
    }
    if (!value.contains('@')) {
      return 'Ingrese un email válido';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'La contraseña es requerida';
    }
    if (value.length < 6) {
      return 'La contraseña debe tener al menos 6 caracteres';
    }
    return null;
  }

  void setRole(String role) {
    roleController.text = role == 'USUARIO' ? 'Usuario' : 'Administrador';
    notifyListeners();
  }

  Future<bool> register() async {
    if (_usuarioProvider == null) {
      throw Exception(
          'Provider no inicializado. Llame a prepareProviders primero.');
    }
    return _processForm(isUpdate: false);
  }

  Future<bool> update() async {
    if (_usuarioProvider == null) {
      throw Exception(
          'Provider no inicializado. Llame a prepareProviders primero.');
    }
    return _processForm(isUpdate: true);
  }

  Future<bool> _processForm({required bool isUpdate}) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final userData = {
        'username': usernameController.text.trim(),
        'password': passwordController.text,
        'email': emailController.text.trim(),
        'nombres': nombresController.text.trim(),
        'apellidos': apellidosController.text.trim(),
        'rol': roleController.text == 'Usuario' ? 'USUARIO' : 'ADMINISTRADOR',
      };

      if (isUpdate) {
        final usuarioActualizado =
            await _usuarioProvider!.updateUsuario(_usuario.id, userData);
        if (usuarioActualizado != null) {
          return true;
        } else {
          _error = _usuarioProvider!.error ?? 'Error al actualizar el usuario';
          return false;
        }
      } else {
        final nuevoUsuario = await _usuarioProvider!.createUsuario(userData);
        if (nuevoUsuario != null) {
          return true;
        } else {
          _error = _usuarioProvider!.error ?? 'Error al crear el usuario';
          return false;
        }
      }
    } catch (e) {
      _error = e.toString();
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    emailController.dispose();
    nombresController.dispose();
    apellidosController.dispose();
    roleController.dispose();
    super.dispose();
  }
}
