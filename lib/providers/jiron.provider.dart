import 'package:flutter/material.dart';
import 'package:app_guias/services/jiron.service.dart';
import 'package:app_guias/models/vista.jiron.dart';

class JironProvider extends ChangeNotifier {
  final JironService _jironService;
  List<VistaJiron> _jirones = [];
  bool _isLoading = false;
  String? _error;
  int _currentPage = 1;
  int _pageSize = 50;
  int _totalPages = 1;
  int _totalCount = 0;

  JironProvider({required String baseUrl, required String token})
      : _jironService = JironService(baseUrl: baseUrl) {
    _jironService.setToken(token);
  }

  List<VistaJiron> get jirones => _jirones;
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

  Future<void> loadJirones({
    int? page,
    int? pageSize,
    bool all = true,
  }) async {
    if (_isLoading) return;

    _setLoading(true);
    _setError(null);

    try {
      final response = await _jironService.getAllJirones(
        page: page ?? _currentPage,
        pageSize: pageSize ?? _pageSize,
        all: all,
      );

      if (response['success']) {
        _jirones = (response['data'] as List)
            .map((json) => VistaJiron.fromJson(json))
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

  Future<VistaJiron?> getJironById(String jiron) async {
    if (_isLoading) return null;

    _setLoading(true);
    _setError(null);

    try {
      final response = await _jironService.getJironByCodigo(jiron);

      if (response['success']) {
        return VistaJiron.fromJson(response['data']);
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

  Future<List<VistaJiron>> getJironesByCampo(
    String campo, {
    int? page,
    int? pageSize,
    bool all = true,
  }) async {
    if (_isLoading) return [];

    _setLoading(true);
    _setError(null);

    try {
      final response = await _jironService.getJironesByCampo(
        campo,
        page: page ?? _currentPage,
        pageSize: pageSize ?? _pageSize,
        all: all,
      );

      if (response['success']) {
        final jirones = (response['data'] as List)
            .map((json) => VistaJiron.fromJson(json))
            .toList();
        _currentPage = response['page'] ?? 1;
        _pageSize = response['pageSize'] ?? 50;
        _totalCount = response['total'] ?? 0;
        _totalPages = (_totalCount / _pageSize).ceil();
        return jirones;
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
      loadJirones(page: _currentPage + 1);
    }
  }

  void previousPage() {
    if (!_isLoading && hasPrevious) {
      loadJirones(page: _currentPage - 1);
    }
  }

  void goToPage(int page) {
    if (!_isLoading && page >= 1 && page <= _totalPages) {
      loadJirones(page: page);
    }
  }

  String formatJironDisplay(VistaJiron jiron) {
    return _jironService.formatJironDisplay(jiron);
  }

  String? getJironCode(String displayText) {
    return _jironService.extractJironCode(displayText);
  }

  String? getJironDescripcion(String displayText) {
    return _jironService.extractJironDescripcion(displayText);
  }
}
