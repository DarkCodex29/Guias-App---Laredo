import 'package:flutter/material.dart';
import 'package:app_guias/services/empleado.service.dart';
import 'package:app_guias/models/vista.empleado.dart';

class EmpleadoProvider extends ChangeNotifier {
  final EmpleadoService _empleadoService;
  List<VistaEmpleado> _empleados = [];
  bool _isLoading = false;
  String? _error;
  int _currentPage = 1;
  int _pageSize = 50;
  int _totalPages = 1;
  int _totalCount = 0;

  EmpleadoProvider({required String baseUrl, required String token})
      : _empleadoService = EmpleadoService(baseUrl: baseUrl) {
    _empleadoService.setToken(token);
  }

  List<VistaEmpleado> get empleados => _empleados;
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

  Future<void> loadEmpleados({int? page, int? pageSize}) async {
    if (_isLoading) return;

    _setLoading(true);
    _setError(null);

    try {
      final response = await _empleadoService.getAllEmpleados(
        page: page ?? _currentPage,
        pageSize: pageSize ?? _pageSize,
      );

      if (response['success']) {
        _empleados = (response['data'] as List)
            .map((json) => VistaEmpleado.fromJson(json))
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

  Future<VistaEmpleado?> getEmpleadoById(String codEmpleado) async {
    if (_isLoading) return null;

    _setLoading(true);
    _setError(null);

    try {
      final response =
          await _empleadoService.getEmpleadoByEmpleado(codEmpleado);

      if (response['success']) {
        return VistaEmpleado.fromJson(response['data']);
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

  Future<VistaEmpleado?> getEmpleadoByDni(String dni) async {
    if (_isLoading) return null;

    _setLoading(true);
    _setError(null);

    try {
      final response = await _empleadoService.getEmpleadoByDni(dni);

      if (response['success']) {
        return VistaEmpleado.fromJson(response['data']);
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

  Future<Map<String, dynamic>?> verificarEmpleado(String codigo) async {
    if (_isLoading) return null;

    _setLoading(true);
    _setError(null);

    try {
      final response = await _empleadoService.empleadoExiste(codigo);

      if (response['success']) {
        return response;
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
      loadEmpleados(page: _currentPage + 1);
    }
  }

  void previousPage() {
    if (!_isLoading && hasPrevious) {
      loadEmpleados(page: _currentPage - 1);
    }
  }

  void goToPage(int page) {
    if (!_isLoading && page >= 1 && page <= _totalPages) {
      loadEmpleados(page: page);
    }
  }
}
