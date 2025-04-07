import 'package:flutter/material.dart';
import 'package:app_guias/models/ubigeo.dart';
import 'package:app_guias/domain/repositories/ubigeo.repository.dart';
import 'package:app_guias/core/utils/loading_state.dart';

class UbigeoController extends ChangeNotifier {
  final UbigeoRepository _repository;

  UbigeoController(this._repository);

  // Estados de carga
  LoadingStateData<List<DepartamentoModel>> _departamentosState =
      LoadingStateData.initial();
  LoadingStateData<List<ProvinciaModel>> _provinciasState =
      LoadingStateData.initial();
  LoadingStateData<List<DistritoModel>> _distritosState =
      LoadingStateData.initial();

  // Selecciones actuales
  DepartamentoModel? _selectedDepartamento;
  ProvinciaModel? _selectedProvincia;
  DistritoModel? _selectedDistrito;

  // Getters para estados
  LoadingStateData<List<DepartamentoModel>> get departamentosState =>
      _departamentosState;
  LoadingStateData<List<ProvinciaModel>> get provinciasState =>
      _provinciasState;
  LoadingStateData<List<DistritoModel>> get distritosState => _distritosState;

  // Getters para selecciones
  DepartamentoModel? get selectedDepartamento => _selectedDepartamento;
  ProvinciaModel? get selectedProvincia => _selectedProvincia;
  DistritoModel? get selectedDistrito => _selectedDistrito;

  // Getters para estados de carga
  bool get isLoadingDepartamentos => _departamentosState.isLoading;
  bool get isLoadingProvincias => _provinciasState.isLoading;
  bool get isLoadingDistritos => _distritosState.isLoading;

  // Cargar departamentos
  Future<void> loadDepartamentos() async {
    try {
      if (_departamentosState.isSuccess &&
          (_departamentosState.data?.isNotEmpty ?? false)) {
        return;
      }

      _departamentosState = LoadingStateData.loading();
      notifyListeners();

      final departamentos = await _repository.getDepartamentos();
      _departamentosState = LoadingStateData.success(departamentos);
      notifyListeners();
    } catch (e) {
      _departamentosState = LoadingStateData.error(e.toString());
      notifyListeners();
    }
  }

  // Cargar provincias
  Future<void> loadProvincias(String departamentoId) async {
    try {
      _provinciasState = LoadingStateData.loading();
      notifyListeners();

      final provincias = await _repository.getProvincias(departamentoId);
      _provinciasState = LoadingStateData.success(provincias);
      notifyListeners();
    } catch (e) {
      _provinciasState = LoadingStateData.error(e.toString());
      notifyListeners();
    }
  }

  // Cargar distritos
  Future<void> loadDistritos(String provinciaId) async {
    try {
      _distritosState = LoadingStateData.loading();
      notifyListeners();

      final distritos = await _repository.getDistritos(provinciaId);
      _distritosState = LoadingStateData.success(distritos);
      notifyListeners();
    } catch (e) {
      _distritosState = LoadingStateData.error(e.toString());
      notifyListeners();
    }
  }

  // Seleccionar departamento
  Future<void> selectDepartamento(DepartamentoModel? departamento) async {
    if (_selectedDepartamento?.codigo == departamento?.codigo) return;
    _selectedDepartamento = departamento;
    _selectedProvincia = null;
    _selectedDistrito = null;

    if (departamento != null) {
      await loadProvincias(departamento.codigo);
    } else {
      _provinciasState = LoadingStateData.initial();
      _distritosState = LoadingStateData.initial();
    }

    notifyListeners();
  }

  // Seleccionar provincia
  Future<void> selectProvincia(ProvinciaModel? provincia) async {
    if (_selectedProvincia?.codigo == provincia?.codigo) return;
    _selectedProvincia = provincia;
    _selectedDistrito = null;

    if (provincia != null) {
      await loadDistritos(provincia.codigo);
    } else {
      _distritosState = LoadingStateData.initial();
    }

    notifyListeners();
  }

  // Seleccionar distrito
  void selectDistrito(DistritoModel? distrito) {
    if (_selectedDistrito?.codigo == distrito?.codigo) return;
    _selectedDistrito = distrito;
    notifyListeners();
  }

  // Limpiar selección
  void clearSelection() {
    _selectedDepartamento = null;
    _selectedProvincia = null;
    _selectedDistrito = null;
    _provinciasState = LoadingStateData.initial();
    _distritosState = LoadingStateData.initial();
    notifyListeners();
  }
}
