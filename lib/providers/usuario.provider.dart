import 'package:flutter/material.dart';
import 'package:app_guias/services/usuario.service.dart';
import 'package:app_guias/models/usuario.dart';
import 'package:app_guias/services/log/logger.service.dart';
import 'dart:io';

class UsuarioProvider extends ChangeNotifier {
  final UsuarioService _usuarioService;
  List<Usuario> _usuarios = [];
  bool _isLoading = false;
  String? _error;
  bool _mounted = true;

  // Estado de paginación
  int _currentPage = 1;
  int _pageSize = 10;
  int _totalPages = 0;
  int _totalCount = 0;
  bool _hasNext = false;
  bool _hasPrevious = false;

  UsuarioProvider({required String baseUrl, required String token})
      : _usuarioService = UsuarioService(
          baseUrl: baseUrl,
        ) {
    _usuarioService.setToken(token);
  }

  List<Usuario> get usuarios => _usuarios;
  bool get isLoading => _isLoading;
  String? get error => _error;
  bool get mounted => _mounted;

  // Getters para paginación
  int get currentPage => _currentPage;
  int get pageSize => _pageSize;
  int get totalPages => _totalPages;
  int get totalCount => _totalCount;
  bool get hasNext => _hasNext;
  bool get hasPrevious => _hasPrevious;

  Future<void> loadUsuarios() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final response = await _usuarioService.getAllUsuarios();
      _usuarios = response['usuarios'] as List<Usuario>;
      _updatePaginationState(response);
    } catch (e) {
      _error = e.toString();
      LoggerService.error('Error al cargar usuarios: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void _updatePaginationState(Map<String, dynamic> response) {
    _currentPage = response['page'] ?? 1;
    _pageSize = response['pageSize'] ?? 10;
    _totalCount = response['totalCount'] ?? 0;
    _totalPages = response['totalPages'] ?? 1;
    _hasNext = response['hasNext'] ?? false;
    _hasPrevious = response['hasPrevious'] ?? false;
  }

  Future<Usuario?> getUsuarioById(int id) async {
    try {
      return await _usuarioService.getUsuarioById(id);
    } catch (e) {
      _error = e.toString();
      LoggerService.error('Error al obtener usuario: $e');
      notifyListeners();
      return null;
    }
  }

  Future<Usuario?> createUsuario(Map<String, dynamic> usuario) async {
    try {
      final response = await _usuarioService.register(usuario);
      if (response != null) {
        return Usuario.fromJson(response);
      }
      return null;
    } catch (e) {
      _error = e.toString();
      LoggerService.error('Error al crear usuario: $e');
      return null;
    }
  }

  Future<Usuario?> updateUsuario(int id, Map<String, dynamic> usuario) async {
    try {
      final success = await _usuarioService.update(id, usuario);
      if (success) {
        return Usuario.fromJson(usuario);
      }
      return null;
    } catch (e) {
      _error = e.toString();
      return null;
    }
  }

  Future<bool> deleteUsuario(int id) async {
    try {
      final success = await _usuarioService.deleteUsuario(id);
      if (success) {
        await loadUsuarios();
        return true;
      }
      return false;
    } catch (e) {
      _error = e.toString();
      LoggerService.error('Error al eliminar usuario: $e');
      notifyListeners();
      return false;
    }
  }

  Future<Map<String, dynamic>> uploadUsuariosExcel(File file) async {
    try {
      final response = await _usuarioService.uploadUsuariosExcel(file);
      await loadUsuarios();
      return response;
    } catch (e) {
      _error = e.toString();
      LoggerService.error('Error al cargar usuarios: $e');
      notifyListeners();
      return {
        'success': false,
        'errores': [_error ?? 'Error desconocido']
      };
    }
  }

  Future<Map<String, dynamic>> getUsuariosPaginados({
    int page = 1,
    int pageSize = 10,
  }) async {
    try {
      final response = await _usuarioService.getAllUsuarios(
        page: page,
        pageSize: pageSize,
        all: true,
      );
      _usuarios = response['usuarios'] as List<Usuario>;
      _updatePaginationState(response);
      notifyListeners();
      return response;
    } catch (e) {
      _error = e.toString();
      LoggerService.error('Error al cargar usuarios: $e');
      notifyListeners();
      return {
        'usuarios': [],
        'totalCount': 0,
        'totalPages': 0,
        'hasNext': false,
        'hasPrevious': false,
      };
    }
  }

  void clearError() {
    _error = null;
    notifyListeners();
  }

  @override
  void dispose() {
    _mounted = false;
    super.dispose();
  }
}
