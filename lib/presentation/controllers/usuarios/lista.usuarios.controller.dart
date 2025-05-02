import 'dart:io';
import 'package:flutter/material.dart';
import '../../../models/usuario.dart';
import '../../../providers/auth.provider.dart';
import '../../../providers/usuario.provider.dart';
import 'package:file_picker/file_picker.dart';
import '../../../services/log/logger.service.dart';

class ListaUsuariosController extends ChangeNotifier {
  final AuthProvider _authProvider;
  final UsuarioProvider _usuarioProvider;
  bool _isLoading = false;
  String? _errorMessage;
  List<Usuario> _usuariosFiltrados = [];
  String _filtro = '';

  ListaUsuariosController(this._authProvider, this._usuarioProvider);

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  bool get isAdmin => _authProvider.role == 'ADMINISTRADOR';

  // Getters para paginación
  int get currentPage => _usuarioProvider.currentPage;
  int get pageSize => _usuarioProvider.pageSize;
  int get totalPages => _usuarioProvider.totalPages;
  int get totalCount => _usuarioProvider.totalCount;
  bool get hasNext => _usuarioProvider.hasNext;
  bool get hasPrevious => _usuarioProvider.hasPrevious;
  List<Usuario> get usuarios =>
      _filtro.isEmpty ? _usuarioProvider.usuarios : _usuariosFiltrados;

  void _setLoading(bool value) {
    if (_isLoading != value) {
      _isLoading = value;
      notifyListeners();
    }
  }

  void _setError(String? message) {
    if (_errorMessage != message) {
      _errorMessage = message;
      notifyListeners();
    }
  }

  void filtrarUsuarios(String query) {
    _filtro = query.toLowerCase();
    if (_filtro.isEmpty) {
      _usuariosFiltrados = [];
    } else {
      _usuariosFiltrados = _usuarioProvider.usuarios.where((usuario) {
        final username = usuario.username.toLowerCase();
        final nombres = usuario.nombres.toLowerCase();
        final apellidos = usuario.apellidos.toLowerCase();
        final email = usuario.email?.toLowerCase() ?? '';
        final fechaCreacion = usuario.fechaCreacion.toString().toLowerCase();

        return username.contains(_filtro) ||
            nombres.contains(_filtro) ||
            apellidos.contains(_filtro) ||
            email.contains(_filtro) ||
            fechaCreacion.contains(_filtro);
      }).toList();
    }
    notifyListeners();
  }

  Future<void> cargarUsuarios() async {
    if (!_usuarioProvider.mounted) return;

    _setLoading(true);
    _setError(null);
    try {
      await _usuarioProvider.getUsuariosPaginados(
        page: currentPage,
        pageSize: pageSize,
      );
    } catch (e) {
      _setError('Error al cargar usuarios: ${e.toString()}');
    } finally {
      _setLoading(false);
    }
  }

  void nextPage() {
    if (!_isLoading && hasNext) {
      cargarUsuarios();
    }
  }

  void previousPage() {
    if (!_isLoading && hasPrevious) {
      cargarUsuarios();
    }
  }

  void goToPage(int page) {
    if (!_isLoading && page >= 1 && page <= totalPages) {
      cargarUsuarios();
    }
  }

  Future<bool> eliminarUsuario(Usuario usuario) async {
    if (_isLoading) return false;

    _setLoading(true);
    _setError(null);

    try {
      LoggerService.info(
          'Iniciando eliminación de usuario: ${usuario.username}');

      final success = await _usuarioProvider.deleteUsuario(usuario.id);

      LoggerService.info(
          'Respuesta del servidor - eliminación de usuario: $success');

      if (success) {
        LoggerService.info('Usuario eliminado correctamente');
        await cargarUsuarios();
        return true;
      }

      _setError('No se pudo eliminar el usuario');
      LoggerService.error('Error al eliminar usuario: No se pudo eliminar');
      return false;
    } catch (e) {
      LoggerService.error('Error al eliminar usuario: $e');
      _setError(e.toString());
      return false;
    } finally {
      _setLoading(false);
    }
  }

  Future<bool> registrarUsuario(Map<String, String> userData) async {
    try {
      LoggerService.info(
          'Iniciando registro de usuario con datos: ${userData.toString()}');
      _isLoading = true;
      _errorMessage = null;
      notifyListeners();

      final usuario = {
        "id": 0,
        "username": userData['username'] ?? '',
        "nombres": userData['names'] ?? '',
        "apellidos": userData['surnames'] ?? '',
        "contraseña": userData['password'] ?? '',
        "rol": userData['role'] ?? 'USUARIO',
        "email": '',
        "estado": "1",
        "fechA_CREACION": DateTime.now().toIso8601String(),
        "fechA_ACTUALIZACION": null,
        "guias": []
      };

      LoggerService.info('Llamando al servicio de registro...');
      final success = await _usuarioProvider.createUsuario(usuario);

      LoggerService.info('Respuesta del servicio de registro: $success');

      if (success != null) {
        LoggerService.info('Usuario registrado correctamente');
        await cargarUsuarios();
        return true;
      }

      _errorMessage =
          _usuarioProvider.error ?? 'No se pudo registrar el usuario';
      LoggerService.error('Error al registrar usuario: $_errorMessage');
      return false;
    } catch (e) {
      _errorMessage = e.toString();
      LoggerService.error('Error inesperado al registrar usuario: $e');
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> actualizarUsuario(Map<String, String> userData) async {
    try {
      _isLoading = true;
      _errorMessage = null;
      notifyListeners();

      final id = int.tryParse(userData['id'] ?? '0') ?? 0;

      final usuario = {
        "id": id,
        "username": userData['username'] ?? '',
        "nombres": userData['names'] ?? '',
        "apellidos": userData['surnames'] ?? '',
        "contraseña": userData['password'] ?? '',
        "rol": userData['role'] ?? 'USUARIO',
        "email": userData['email'] ?? '',
        "estado": "1",
        "fechA_CREACION":
            userData['fechaCreacion'] ?? DateTime.now().toIso8601String(),
        "fechA_ACTUALIZACION": DateTime.now().toIso8601String(),
        "guias": []
      };

      final success = await _usuarioProvider.updateUsuario(id, usuario);

      if (success != null) {
        await cargarUsuarios();
        return true;
      }

      _errorMessage =
          _usuarioProvider.error ?? 'No se pudo actualizar el usuario';
      return false;
    } catch (e) {
      _errorMessage = e.toString();
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<Map<String, dynamic>?> cargarMasivaUsuarios() async {
    if (_isLoading) return null;

    _setLoading(true);
    _setError(null);

    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['xlsx', 'xls', 'csv'],
      );

      if (result != null) {
        File file = File(result.files.single.path!);
        final response = await _usuarioProvider.uploadUsuariosExcel(file);

        // Mapeo de errores y mensajes
        if (response.containsKey('errores') &&
            response['errores'] != null &&
            (response['errores'] as List).isNotEmpty) {
          _setError((response['errores'] as List).join('\n'));
        } else if (response.containsKey('errors')) {
          // Errores de encabezado o archivo
          final errors = response['errors'];
          if (errors is Map && errors['file'] != null) {
            _setError((errors['file'] as List).join('\n'));
          } else {
            _setError('Error desconocido en el archivo.');
          }
        } else if (response['registrosExitosos'] ==
            response['totalRegistros']) {
          _setError(null);
        } else if (response['success'] == false) {
          _setError('No se pudo procesar el archivo.');
        }
        return response;
      } else {
        _setError('No se seleccionó ningún archivo');
        return null;
      }
    } catch (e) {
      _setError(e.toString());
      return null;
    } finally {
      _setLoading(false);
    }
  }
}
