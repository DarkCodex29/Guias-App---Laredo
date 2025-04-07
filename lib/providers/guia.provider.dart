import 'package:flutter/foundation.dart';
import 'package:app_guias/services/guia.service.dart';
import 'package:app_guias/models/guia.dart';
import 'package:app_guias/services/log/logger.service.dart';

class GuiaProvider extends ChangeNotifier {
  final GuiaService _guiaService;
  List<Guia> _guias = [];
  bool _isLoading = false;
  String? _error;
  int _currentPage = 1;
  int _totalPages = 1;
  int _pageSize = 10;
  String? _idUsuario;

  GuiaProvider({required String baseUrl, required String token})
      : _guiaService = GuiaService(baseUrl: baseUrl) {
    _guiaService.setToken(token);
  }

  List<Guia> get guias => _guias;
  bool get isLoading => _isLoading;
  String? get error => _error;
  int get currentPage => _currentPage;
  int get totalPages => _totalPages;
  int get pageSize => _pageSize;

  void _setLoading(bool value) {
    if (_isLoading != value) {
      _isLoading = value;
      notifyListeners();
    }
  }

  void _setError(String? message) {
    if (_error != message) {
      _error = message;
      notifyListeners();
    }
  }

  bool _validateResponse(Map<String, dynamic> response) {
    if (!response.containsKey('success')) {
      _setError('Respuesta inválida del servidor');
      return false;
    }
    return response['success'] as bool;
  }

  void _processPaginationResponse(Map<String, dynamic> response) {
    _currentPage = response['page'] ?? 1;
    _pageSize = response['pageSize'] ?? 10;
    _totalPages = (response['total'] / _pageSize).ceil();
  }

  // Obtener todas las guías
  Future<void> loadGuias({int? page, int? pageSize}) async {
    if (_isLoading) return;

    _setLoading(true);
    _setError(null);

    try {
      final response = await _guiaService.getAllGuias(
        page: page ?? _currentPage,
        pageSize: pageSize ?? _pageSize,
      );

      if (_validateResponse(response)) {
        final List<dynamic> data = response['data'] ?? [];
        _guias = data.map((json) => Guia.fromJson(json)).toList();
        _processPaginationResponse(response);
      } else {
        _setError(response['message'] ?? 'Error al cargar las guías');
      }
    } catch (e) {
      _setError('Error de conexión: ${e.toString()}');
      _guias = [];
    } finally {
      _setLoading(false);
    }
  }

  // Obtener guías por ID de usuario
  Future<void> loadGuiasByUsuario(String idUsuario,
      {int? page, int? pageSize}) async {
    if (_isLoading) return;
    _idUsuario = idUsuario;

    _setLoading(true);
    _setError(null);

    try {
      final response = await _guiaService.getGuiasByUsuario(
        idUsuario: idUsuario,
        page: page ?? _currentPage,
        pageSize: pageSize ?? _pageSize,
      );

      if (_validateResponse(response)) {
        final List<dynamic> data = response['data'] ?? [];
        _guias = data.map((json) => Guia.fromJson(json)).toList();
        _processPaginationResponse(response);
      } else {
        _setError(
            response['message'] ?? 'Error al cargar las guías del usuario');
      }
    } catch (e) {
      _setError('Error de conexión: ${e.toString()}');
      _guias = [];
    } finally {
      _setLoading(false);
    }
  }

  // Obtener una guía específica por ID
  Future<Guia?> getGuiaById(int id) async {
    if (_isLoading) return null;

    _setLoading(true);
    _setError(null);

    try {
      final response = await _guiaService.getGuiaById(id);

      if (_validateResponse(response)) {
        return Guia.fromJson(response['data']);
      } else {
        _setError(response['message'] ?? 'Error al obtener la guía');
        return null;
      }
    } catch (e) {
      _setError('Error de conexión: ${e.toString()}');
      return null;
    } finally {
      _setLoading(false);
    }
  }

  // Crear una nueva guía
  Future<Guia?> createGuia(
      String nombre, Uint8List archivo, String idUsuario) async {
    if (_isLoading) return null;

    _setLoading(true);
    _setError(null);

    try {
      if (nombre.isEmpty) {
        _setError('El nombre de la guía no puede estar vacío');
        return null;
      }

      final response =
          await _guiaService.createGuia(nombre, archivo, idUsuario);

      if (_validateResponse(response)) {
        final guia = Guia.fromJson(response['data']);
        _guias.insert(0, guia);
        notifyListeners();
        return guia;
      } else {
        _setError(response['message'] ?? 'Error al crear la guía');
        return null;
      }
    } catch (e) {
      _setError('Error de conexión: ${e.toString()}');
      return null;
    } finally {
      _setLoading(false);
    }
  }

  // Métodos de paginación
  Future<void> nextPage() async {
    if (!_isLoading && _currentPage < _totalPages) {
      if (_idUsuario != null) {
        await loadGuiasByUsuario(_idUsuario!, page: _currentPage + 1);
      } else {
        await loadGuias(page: _currentPage + 1);
      }
    }
  }

  Future<void> previousPage() async {
    if (!_isLoading && _currentPage > 1) {
      if (_idUsuario != null) {
        await loadGuiasByUsuario(_idUsuario!, page: _currentPage - 1);
      } else {
        await loadGuias(page: _currentPage - 1);
      }
    }
  }

  Future<void> goToPage(int page) async {
    if (!_isLoading && page >= 1 && page <= _totalPages) {
      if (_idUsuario != null) {
        await loadGuiasByUsuario(_idUsuario!, page: page);
      } else {
        await loadGuias(page: page);
      }
    }
  }

  Future<void> refresh() async {
    if (_idUsuario != null) {
      await loadGuiasByUsuario(_idUsuario!);
    } else {
      await loadGuias();
    }
  }

  // Subir una guía
  Future<Guia?> uploadGuia(
      String nombre, Uint8List archivo, String idUsuario) async {
    if (_isLoading) return null;

    _setLoading(true);
    _setError(null);

    try {
      if (nombre.isEmpty) {
        _setError('El nombre de la guía no puede estar vacío');
        return null;
      }

      final response =
          await _guiaService.uploadGuia(nombre, archivo, idUsuario);

      if (_validateResponse(response)) {
        final guia = Guia.fromJson(response['data']);
        _guias.insert(0, guia);
        notifyListeners();
        return guia;
      } else {
        _setError(response['message'] ?? 'Error al subir la guía');
        return null;
      }
    } catch (e) {
      _setError('Error de conexión: ${e.toString()}');
      return null;
    } finally {
      _setLoading(false);
    }
  }

  // Descargar una guía
  Future<Uint8List?> downloadGuia(int id) async {
    if (_isLoading) return null;

    _setLoading(true);
    _setError(null);

    try {
      final response = await _guiaService.downloadGuia(id);

      if (_validateResponse(response)) {
        return response['data'] as Uint8List;
      } else {
        _setError(response['message'] ?? 'Error al descargar la guía');
        return null;
      }
    } catch (e) {
      _setError('Error de conexión: ${e.toString()}');
      return null;
    } finally {
      _setLoading(false);
    }
  }

  // Obtener el último correlativo del servidor
  Future<int> getLastCorrelativo() async {
    if (_isLoading) return 0;

    _setLoading(true);
    _setError(null);

    try {
      LoggerService.info('Provider: Iniciando getLastCorrelativo()');
      final response = await _guiaService.getLastGuia();
      LoggerService.info(
          'Provider: Respuesta recibida de getLastGuia(): success=${response['success']}');

      if (_validateResponse(response)) {
        final data = response['data'];
        LoggerService.info('Provider: Datos obtenidos: $data');

        if (data != null && data.containsKey('correlativoNum')) {
          final int correlativoNum = data['correlativoNum'] ?? 0;
          LoggerService.info(
              'Provider: Correlativo numérico extraído: $correlativoNum');
          return correlativoNum;
        } else {
          LoggerService.error(
              'Provider: No se encontró el campo correlativoNum en los datos');
          _setError(
              'Error al obtener el último correlativo: formato incorrecto');
          // Si estamos obteniendo 0, usar 695 como valor predeterminado para desarrollo
          return 695; // ¡VALOR TEMPORAL SOLO PARA PRUEBAS!
        }
      } else {
        final errorMsg =
            response['message'] ?? 'Error al obtener el último correlativo';
        LoggerService.error('Provider: Error al validar respuesta: $errorMsg');
        _setError(errorMsg);
        // Si estamos obteniendo 0, usar 695 como valor predeterminado para desarrollo
        return 695; // ¡VALOR TEMPORAL SOLO PARA PRUEBAS!
      }
    } catch (e) {
      LoggerService.error(
          'Provider: Excepción en getLastCorrelativo(): ${e.toString()}');
      _setError('Error de conexión: ${e.toString()}');
      // Si estamos obteniendo 0, usar 695 como valor predeterminado para desarrollo
      return 695; // ¡VALOR TEMPORAL SOLO PARA PRUEBAS!
    } finally {
      _setLoading(false);
    }
  }

  // Obtener la información del último correlativo desde el servidor
  Future<Map<String, dynamic>?> getLastCorrelativoInfo() async {
    if (_isLoading) return null;

    _setLoading(true);
    _setError(null);

    try {
      LoggerService.info(
          'Obteniendo información del último correlativo del servidor');
      final response = await _guiaService.getLastGuia();

      if (_validateResponse(response)) {
        LoggerService.info(
            'Correlativo obtenido correctamente: ${response['data']}');
        return response['data'];
      } else {
        final errorMsg = response['message'] ??
            'Error al obtener información del último correlativo';
        LoggerService.error('Error al obtener correlativo: $errorMsg');
        _setError(errorMsg);
        return null;
      }
    } catch (e) {
      LoggerService.error('Excepción al obtener correlativo: ${e.toString()}');
      _setError('Error de conexión: ${e.toString()}');
      return null;
    } finally {
      _setLoading(false);
    }
  }
}
