import 'package:hive_flutter/hive_flutter.dart';
import 'package:app_guias/models/ubigeo.dart';

class UbigeoStorageService {
  static const String _departamentosBox = 'departamentos';
  static const String _provinciasBox = 'provincias';
  static const String _distritosBox = 'distritos';

  // Boxes
  late Box<DepartamentoModel> _departamentosBoxInstance;
  late Box<ProvinciaModel> _provinciasBoxInstance;
  late Box<DistritoModel> _distritosBoxInstance;

  // Inicializar boxes
  Future<void> init() async {
    _departamentosBoxInstance =
        await Hive.openBox<DepartamentoModel>(_departamentosBox);
    _provinciasBoxInstance = await Hive.openBox<ProvinciaModel>(_provinciasBox);
    _distritosBoxInstance = await Hive.openBox<DistritoModel>(_distritosBox);
  }

  // Guardar departamentos
  Future<void> saveDepartamentos(List<DepartamentoModel> departamentos) async {
    await _departamentosBoxInstance.clear();
    await _departamentosBoxInstance.addAll(departamentos);
  }

  // Guardar provincias
  Future<void> saveProvincias(List<ProvinciaModel> provincias) async {
    await _provinciasBoxInstance.clear();
    await _provinciasBoxInstance.addAll(provincias);
  }

  // Guardar distritos
  Future<void> saveDistritos(List<DistritoModel> distritos) async {
    await _distritosBoxInstance.clear();
    await _distritosBoxInstance.addAll(distritos);
  }

  // Obtener departamentos
  List<DepartamentoModel> getDepartamentos() {
    return _departamentosBoxInstance.values.toList();
  }

  // Obtener provincias
  List<ProvinciaModel> getProvincias() {
    return _provinciasBoxInstance.values.toList();
  }

  // Obtener distritos
  List<DistritoModel> getDistritos() {
    return _distritosBoxInstance.values.toList();
  }

  // Verificar si hay datos
  bool hasData() {
    return _departamentosBoxInstance.isNotEmpty &&
        _provinciasBoxInstance.isNotEmpty &&
        _distritosBoxInstance.isNotEmpty;
  }

  // Limpiar todos los datos
  Future<void> clearAll() async {
    await _departamentosBoxInstance.clear();
    await _provinciasBoxInstance.clear();
    await _distritosBoxInstance.clear();
  }
}
