import 'package:flutter/material.dart';
import 'package:app_guias/services/equipo.service.dart';
import 'package:app_guias/models/vista.equipo.dart';

class EquipoProvider extends ChangeNotifier {
  final EquipoService _equipoService;
  List<VistaEquipo> _equipos = [];
  bool _isLoading = false;
  String? _error;

  EquipoProvider({required String baseUrl, required String token})
      : _equipoService = EquipoService(baseUrl: baseUrl) {
    _equipoService.setToken(token);
  }

  List<VistaEquipo> get equipos => _equipos;
  bool get isLoading => _isLoading;
  String? get error => _error;

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

  Future<void> loadEquipos() async {
    _setLoading(true);
    _setError(null);

    try {
      final response = await _equipoService.getAllEquipos();

      if (response['success']) {
        _equipos = (response['data'] as List)
            .map((json) => VistaEquipo.fromJson(json))
            .toList();
      } else {
        _setError(response['message']);
      }
    } catch (e) {
      _setError(e.toString());
    } finally {
      _setLoading(false);
    }
  }

  Future<VistaEquipo?> getEquipoByCodigo(int codEquipo) async {
    _setLoading(true);
    _setError(null);

    try {
      final response =
          await _equipoService.getEquipoByCodigo(codEquipo.toString());

      if (response['success']) {
        return VistaEquipo.fromJson(response['data']);
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

  Future<VistaEquipo?> getEquipoByPlaca(String placa) async {
    _setLoading(true);
    _setError(null);

    try {
      final response = await _equipoService.getEquipoByPlaca(placa);

      if (response['success']) {
        return VistaEquipo.fromJson(response['data']);
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

  Future<List<VistaEquipo>> getEquiposByTransportista(String codTransp) async {
    _setLoading(true);
    _setError(null);

    try {
      final response =
          await _equipoService.getEquiposByTransportista(codTransp);

      if (response['success']) {
        final data = response['data'];
        if (data is List) {
          return data.map((json) => VistaEquipo.fromJson(json)).toList();
        } else {
          _setError('Formato de respuesta inesperado');
          return [];
        }
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
}
