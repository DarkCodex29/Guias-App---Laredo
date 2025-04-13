import 'package:flutter/foundation.dart';
import 'package:app_guias/services/guia.service.dart';
import 'package:app_guias/models/guia.dart';
import 'package:app_guias/services/log/logger.service.dart';

class GuiaProvider extends ChangeNotifier {
  final GuiaService _guiaService;
  List<Guia> _guias = [];
  bool _isLoading = false;
  String? _error;
  int _currentPagePDF = 1;
  int _totalPagesPDF = 1;
  int _currentPageCSV = 1;
  int _totalPagesCSV = 1;
  final int _pageSize = 10;
  String? _idUsuario;

  GuiaProvider({required String baseUrl, required String token})
      : _guiaService = GuiaService(baseUrl: baseUrl) {
    _guiaService.setToken(token);
  }

  List<Guia> get guias => _guias;
  bool get isLoading => _isLoading;
  String? get error => _error;
  int get currentPage => _currentPagePDF;
  int get totalPages => _totalPagesPDF;
  int get pageSize => _pageSize;
  int get currentPagePDF => _currentPagePDF;
  int get totalPagesPDF => _totalPagesPDF;
  int get currentPageCSV => _currentPageCSV;
  int get totalPagesCSV => _totalPagesCSV;

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

  // Obtener todas las guías
  Future<void> loadGuias({bool all = false}) async {
    if (_isLoading) return;

    _setLoading(true);
    _setError(null);

    try {
      final response = await _guiaService.getAllGuias(all: all);

      if (_validateResponse(response)) {
        final List<dynamic> data = response['data'] ?? [];
        _guias = data.map((json) => Guia.fromJson(json)).toList();
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
  Future<void> loadGuiasByUsuario(String idUsuario, {bool all = false}) async {
    if (_isLoading) return;
    _idUsuario = idUsuario;

    _setLoading(true);
    _setError(null);

    try {
      final response = await _guiaService.getGuiasByUsuario(
        idUsuario: idUsuario,
        all: all,
      );

      if (_validateResponse(response)) {
        final List<dynamic> data = response['data'] ?? [];
        _guias = data.map((json) => Guia.fromJson(json)).toList();
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
  Future<void> nextPagePDF() async {
    if (_currentPagePDF < _totalPagesPDF) {
      _currentPagePDF++;
      notifyListeners();
    }
  }

  Future<void> previousPagePDF() async {
    if (_currentPagePDF > 1) {
      _currentPagePDF--;
      notifyListeners();
    }
  }

  Future<void> goToPagePDF(int page) async {
    if (page >= 1 && page <= _totalPagesPDF && page != _currentPagePDF) {
      _currentPagePDF = page;
      notifyListeners();
    }
  }

  Future<void> nextPageCSV() async {
    if (_currentPageCSV < _totalPagesCSV) {
      _currentPageCSV++;
      notifyListeners();
    }
  }

  Future<void> previousPageCSV() async {
    if (_currentPageCSV > 1) {
      _currentPageCSV--;
      notifyListeners();
    }
  }

  Future<void> goToPageCSV(int page) async {
    if (page >= 1 && page <= _totalPagesCSV && page != _currentPageCSV) {
      _currentPageCSV = page;
      notifyListeners();
    }
  }

  Future<void> nextPage() async => await nextPagePDF();
  Future<void> previousPage() async => await previousPagePDF();
  Future<void> goToPage(int page) async => await goToPagePDF(page);

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

  // Obtener el correlativo directamente del servicio
  Future<String?> getCorrelativoFromService() async {
    if (_isLoading) return null;

    _setLoading(true);
    _setError(null);

    try {
      LoggerService.info('Provider: Obteniendo correlativo del servicio');
      final response = await _guiaService.getCorrelativo();

      if (_validateResponse(response)) {
        final data = response['data'];
        if (data != null && data.containsKey('correlativo')) {
          final String correlativo = data['correlativo'];
          LoggerService.info('Provider: Correlativo obtenido: $correlativo');
          return correlativo;
        } else {
          LoggerService.error(
              'Provider: No se encontró el correlativo en los datos');
          _setError('Error al obtener el correlativo: formato incorrecto');
          return null;
        }
      } else {
        final errorMsg =
            response['message'] ?? 'Error al obtener el correlativo';
        LoggerService.error(
            'Provider: Error al obtener correlativo: $errorMsg');
        _setError(errorMsg);
        return null;
      }
    } catch (e) {
      LoggerService.error(
          'Provider: Excepción al obtener correlativo: ${e.toString()}');
      _setError('Error de conexión: ${e.toString()}');
      return null;
    } finally {
      _setLoading(false);
    }
  }

  void setTotalPagesPDF(int total) {
    _totalPagesPDF = total;
    notifyListeners();
  }

  void setTotalPagesCSV(int total) {
    _totalPagesCSV = total;
    notifyListeners();
  }
}
