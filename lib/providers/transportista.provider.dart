import 'package:flutter/material.dart';
import '../services/transportista.service.dart';
import '../models/vista.transportista.dart';

class TransportistaProvider extends ChangeNotifier {
  final TransportistaService _transportistaService;
  List<VistaTransportista> _transportistas = [];
  bool _isLoading = false;
  String? _error;
  int _currentPage = 1;
  int _pageSize = 50;
  int _totalPages = 1;
  int _totalCount = 0;

  TransportistaProvider({required String baseUrl, required String token})
      : _transportistaService = TransportistaService(
          baseUrl: baseUrl,
        ) {
    _transportistaService.setToken(token);
  }

  List<VistaTransportista> get transportistas => _transportistas;
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

  Future<void> loadTransportistas({int? page, int? pageSize}) async {
    if (_isLoading) return;

    _setLoading(true);
    _setError(null);

    try {
      final response = await _transportistaService.getTransportistas(
        page: page ?? _currentPage,
        pageSize: pageSize ?? _pageSize,
      );

      if (response['success']) {
        _transportistas = (response['data'] as List)
            .map((json) => VistaTransportista.fromJson(json))
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

  Future<VistaTransportista?> getTransportistaByCodigo(String codigo) async {
    if (_isLoading) return null;

    _setLoading(true);
    _setError(null);

    try {
      final response =
          await _transportistaService.getTransportistaByCodigo(codigo);

      if (response['success']) {
        if (response['data'] == null) {
          _setError('No se encontró el transportista con código: $codigo');
          return null;
        }
        return VistaTransportista.fromJson(response['data']);
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

  Future<VistaTransportista?> getTransportistaByRuc(String ruc) async {
    if (_isLoading) return null;

    _setLoading(true);
    _setError(null);

    try {
      final response = await _transportistaService.getTransportistaByRuc(ruc);

      if (response['success']) {
        if (response['data'] == null) {
          _setError('No se encontró el transportista con RUC: $ruc');
          return null;
        }
        return VistaTransportista.fromJson(response['data']);
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

  void nextPage() {
    if (!_isLoading && hasNext) {
      loadTransportistas(page: _currentPage + 1);
    }
  }

  void previousPage() {
    if (!_isLoading && hasPrevious) {
      loadTransportistas(page: _currentPage - 1);
    }
  }

  void goToPage(int page) {
    if (!_isLoading && page >= 1 && page <= _totalPages) {
      loadTransportistas(page: page);
    }
  }
}
