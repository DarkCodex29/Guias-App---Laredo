import 'package:flutter/material.dart';
import 'package:app_guias/services/cuartel.service.dart';
import 'package:app_guias/models/vista.cuartel.dart';

class CuartelProvider extends ChangeNotifier {
  final CuartelService _cuartelService;
  List<VistaCuartel> _cuarteles = [];
  bool _isLoading = false;
  String? _error;
  int _currentPage = 1;
  int _pageSize = 50;
  int _totalPages = 1;
  int _totalCount = 0;

  CuartelProvider({required String baseUrl, required String token})
      : _cuartelService = CuartelService(baseUrl: baseUrl) {
    _cuartelService.setToken(token);
  }

  List<VistaCuartel> get cuarteles => _cuarteles;
  bool get isLoading => _isLoading;
  String? get error => _error;
  int get currentPage => _currentPage;
  int get pageSize => _pageSize;
  int get totalPages => _totalPages;
  int get totalCount => _totalCount;
  bool get hasNext => _currentPage < _totalPages;
  bool get hasPrevious => _currentPage > 1;

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

  Future<void> loadCuarteles({
    int? page,
    int? pageSize,
    bool all = true,
  }) async {
    if (_isLoading) return;

    _setLoading(true);
    _setError(null);

    try {
      final response = await _cuartelService.getAllCuarteles(
        page: page ?? _currentPage,
        pageSize: pageSize ?? _pageSize,
        all: all,
      );

      if (response['success']) {
        _cuarteles = (response['data'] as List)
            .map((json) => VistaCuartel.fromJson(json))
            .toList();
        _currentPage = response['page'] ?? 1;
        _pageSize = response['pageSize'] ?? 50;
        _totalCount = response['total'] ?? 0;
        _totalPages = (_totalCount / _pageSize).ceil();
      } else {
        _setError(response['message']);
      }
    } catch (e) {
      _setError(e.toString());
    } finally {
      _setLoading(false);
    }
  }

  Future<VistaCuartel?> getCuartelById(String cuartel) async {
    if (_isLoading) return null;

    _setLoading(true);
    _setError(null);

    try {
      final response = await _cuartelService.getCuartelByCodigo(cuartel);

      if (response['success']) {
        return VistaCuartel.fromJson(response['data']);
      } else {
        _setError(response['message']);
        return null;
      }
    } catch (e) {
      _setError(e.toString());
      return null;
    } finally {
      _setLoading(false);
    }
  }

  Future<List<VistaCuartel>> getCuartelesByCampo(
    String campo, {
    int? page,
    int? pageSize,
    bool all = true,
  }) async {
    if (_isLoading) return [];

    _setLoading(true);
    _setError(null);

    try {
      final response = await _cuartelService.getCuartelesByCampo(
        campo,
        page: page ?? _currentPage,
        pageSize: pageSize ?? _pageSize,
        all: all,
      );

      if (response['success']) {
        final cuarteles = (response['data'] as List)
            .map((json) => VistaCuartel.fromJson(json))
            .toList();
        _currentPage = response['page'] ?? 1;
        _pageSize = response['pageSize'] ?? 50;
        _totalCount = response['total'] ?? 0;
        _totalPages = (_totalCount / _pageSize).ceil();

        return cuarteles;
      } else {
        _setError(response['message']);
        return [];
      }
    } catch (e) {
      _setError(e.toString());
      return [];
    } finally {
      _setLoading(false);
    }
  }

  void nextPage() {
    if (!_isLoading && hasNext) {
      loadCuarteles(page: _currentPage + 1);
    }
  }

  void previousPage() {
    if (!_isLoading && hasPrevious) {
      loadCuarteles(page: _currentPage - 1);
    }
  }

  void goToPage(int page) {
    if (!_isLoading && page >= 1 && page <= _totalPages) {
      loadCuarteles(page: page);
    }
  }

  String formatCuartelDisplay(VistaCuartel cuartel) {
    return _cuartelService.formatCuartelDisplay(cuartel);
  }

  String? getCuartelCode(String displayText) {
    return _cuartelService.extractCuartelCode(displayText);
  }

  String? getCuartelDescripcion(String displayText) {
    return _cuartelService.extractCuartelDescripcion(displayText);
  }
}
