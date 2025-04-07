import 'package:flutter/material.dart';
import 'package:app_guias/providers/auth.provider.dart';
import 'package:app_guias/presentation/pages/menu/menu.page.dart';

class LoginController extends ChangeNotifier {
  final AuthProvider _authProvider;
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool _isLoading = false;
  String? _errorMessage;

  LoginController(this._authProvider);

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  void setLoading(bool value) {
    if (_isLoading != value) {
      _isLoading = value;
      notifyListeners();
    }
  }

  void setError(String? message) {
    if (_errorMessage != message) {
      _errorMessage = message;
      notifyListeners();
    }
  }

  String? validateUsername(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor ingrese su usuario';
    }
    if (value.length < 3) {
      return 'El usuario debe tener al menos 3 caracteres';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor ingrese su contraseña';
    }
    if (value.length < 6) {
      return 'La contraseña debe tener al menos 6 caracteres';
    }
    return null;
  }

  Future<bool> login(BuildContext context) async {
    if (!formKey.currentState!.validate()) {
      setError(null);
      return false;
    }

    setError(null);
    setLoading(true);

    try {
      final response = await _authProvider.login(
        usernameController.text.trim(),
        passwordController.text,
      );

      if (!context.mounted) return false;

      if (response['success']) {
        final isValid = await _authProvider.validateToken();

        if (!context.mounted) return false;

        if (isValid) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => const MenuPage(),
            ),
          );
          return true;
        } else {
          setError('Error de autenticación: Token inválido');
          return false;
        }
      } else {
        setError(response['message'] ?? 'Error al iniciar sesión');
        return false;
      }
    } catch (e) {
      setError('Error al iniciar sesión: ${e.toString()}');
      return false;
    } finally {
      if (context.mounted) {
        setLoading(false);
      }
    }
  }

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
