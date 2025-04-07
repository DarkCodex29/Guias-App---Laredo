import 'package:flutter/material.dart';
import 'package:app_guias/services/campo.service.dart';
import 'package:app_guias/models/vista.campo.dart';

class CampoProvider extends ChangeNotifier {
  final CampoService _campoService;
  List<VistaCampo> _campos = [];
  bool _isLoading = false;
  String? _error;
  int _currentPage = 1;
  int _pageSize = 50;
  int _totalPages = 1;
  int _totalCount = 0;

  CampoProvider({required String baseUrl, required String token})
      : _campoService = CampoService(baseUrl: baseUrl) {
    _campoService.setToken(token);
  }

  List<VistaCampo> get campos => _campos;
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

  Future<void> loadCampos({bool all = true}) async {
    if (_isLoading) return;

    _setLoading(true);
    _setError(null);

    try {
      final response = await _campoService.getAllCampos(
        page: _currentPage,
        pageSize: _pageSize,
        all: all,
      );

      if (response['success']) {
        _campos = response['data'];
        _currentPage = response['page'];
        _pageSize = response['pageSize'];
        _totalCount = response['total'];
        _totalPages = (_totalCount / _pageSize).ceil();
      } else {
        _setError(response['message']);
        _campos = [];
      }
    } catch (e) {
      _setError(e.toString());
      _campos = [];
    } finally {
      _setLoading(false);
    }
  }

  Future<VistaCampo?> getCampoById(String campo) async {
    if (_isLoading) return null;

    _setLoading(true);
    _setError(null);

    try {
      final response = await _campoService.getCampoById(campo);

      if (response['success']) {
        return response['data'];
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

  String? getCampoCode(String displayText) {
    return _campoService.extractCampoCode(displayText);
  }

  String? getCampoDescripcion(String displayText) {
    return _campoService.extractCampoDescripcion(displayText);
  }

  String formatCampoDisplay(VistaCampo campo) {
    return _campoService.formatCampoDisplay(campo);
  }

  void nextPage() {
    if (!_isLoading && hasNext) {
      _currentPage++;
      loadCampos();
    }
  }

  void previousPage() {
    if (!_isLoading && hasPrevious) {
      _currentPage--;
      loadCampos();
    }
  }

  void goToPage(int page) {
    if (!_isLoading && page >= 1 && page <= _totalPages) {
      _currentPage = page;
      loadCampos();
    }
  }

  void reset() {
    _currentPage = 1;
    _campos = [];
    _error = null;
    notifyListeners();
  }
}
