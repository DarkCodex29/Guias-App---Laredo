import 'package:flutter/material.dart';
import '../services/auth.service.dart';
import '../services/storage/storage.service.dart';

class AuthProvider extends ChangeNotifier {
  final AuthService _authService;
  String? _token;
  String? _role;
  String? _userId;
  String? _username;
  bool _isAuthenticated = false;
  bool _isInitialized = false;

  AuthProvider({required String baseUrl})
      : _authService = AuthService(baseUrl: baseUrl) {
    _loadStoredAuth();
  }

  String? get token => _token;
  String? get role => _role;
  String? get userId => _userId;
  String? get username => _username;
  bool get isAuthenticated => _isAuthenticated;
  bool get isInitialized => _isInitialized;

  Future<void> _loadStoredAuth() async {
    try {
      final authData = await StorageService.getAuthData();

      if (authData['token'] != null) {
        _token = authData['token'];
        _role = authData['role'];
        _userId = authData['userId'];
        _username = authData['username'];

        // Validar el token almacenado
        final isValid = await validateToken();
        _isAuthenticated = isValid;
        if (!isValid) {
          await StorageService.clearAuthData();
          _token = null;
          _role = null;
          _userId = null;
          _username = null;
        }
      } else {
        _isAuthenticated = false;
      }
    } catch (e) {
      _isAuthenticated = false;
      // Asegurarse de limpiar por si acaso hubo un error parcial
      try {
        await StorageService.clearAuthData();
      } catch (_) {}
      _token = null;
      _role = null;
      _userId = null;
      _username = null;
    } finally {
      _isInitialized = true;
      notifyListeners();
    }
  }

  Future<Map<String, dynamic>> login(String username, String password) async {
    try {
      final response = await _authService.login(username, password);

      if (response['success']) {
        _token = response['token'];
        _role = response['role'];
        _userId = response['userId'].toString();
        _username = response['username'];
        _isAuthenticated = true;

        await StorageService.clearAuthData();

        // Guardar datos de autenticación
        await StorageService.saveAuthData(
          token: _token!,
          role: _role!,
          userId: _userId!,
          username: _username!,
        );

        notifyListeners();
      } else {
        _isAuthenticated = false;
      }

      return response;
    } catch (e) {
      _isAuthenticated = false;
      notifyListeners();
      return {'success': false, 'message': e.toString()};
    }
  }

  Future<bool> validateToken() async {
    if (_token == null) {
      return false;
    }
    try {
      final isValid = await _authService.validateToken(_token!);
      return isValid;
    } catch (e) {
      return false;
    }
  }

  Future<bool> logout() async {
    try {
      if (_token != null) {
        await _authService.logout(_token!);
        await StorageService.clearAuthData();

        // Limpiar estado
        _token = null;
        _role = null;
        _userId = null;
        _username = null;
        _isAuthenticated = false;
        notifyListeners();

        return true;
      } else {
        // Asegurarse de que esté limpio por si acaso
        _isAuthenticated = false;
        notifyListeners();
        return true;
      }
    } catch (e) {
      // Intentar limpiar estado de todas formas
      _token = null;
      _role = null;
      _userId = null;
      _username = null;
      _isAuthenticated = false;
      notifyListeners();
      return false;
    }
  }
}
