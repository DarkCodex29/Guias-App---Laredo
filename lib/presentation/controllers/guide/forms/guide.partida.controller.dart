import 'package:flutter/material.dart';
import 'package:app_guias/models/ubigeo.dart';
import 'package:app_guias/presentation/controllers/ubigeo_controller.dart';
import 'package:app_guias/presentation/controllers/guide/guide.flow.controller.dart';

class PartidaController extends ChangeNotifier {
  final UbigeoController ubigeo;
  GuideFlowController? _flowController;
  bool _isInitialized = false;

  bool get isInitialized => _isInitialized;
  GuideFlowController get flowController => _flowController!;

  // Valores por defecto fijos
  static const String direccionDefault = '';
  static const String departamentoDefault = 'LA LIBERTAD';
  static const String provinciaDefault = 'TRUJILLO';
  static const String distritoDefault = 'LAREDO';

  final TextEditingController direccionController = TextEditingController();
  final TextEditingController departamentoController = TextEditingController();
  final TextEditingController provinciaController = TextEditingController();
  final TextEditingController distritoController = TextEditingController();

  // Estado seleccionado
  DepartamentoModel? _selectedDepartamento;
  ProvinciaModel? _selectedProvincia;
  DistritoModel? _selectedDistrito;

  final Map<String, String?> _errors = {
    'direccion': null,
    'departamento': null,
    'provincia': null,
    'distrito': null
  };

  final Set<String> _touchedFields = {};

  PartidaController(this.ubigeo, {GuideFlowController? flowController}) {
    _flowController = flowController;
    _setupListeners();
  }

  void setFlowController(GuideFlowController controller) {
    _flowController = controller;
  }

  String get direccion => direccionController.text;
  String get departamentoText => departamentoController.text;
  String get provinciaText => provinciaController.text;
  String get distritoText => distritoController.text;

  String? getError(String field) =>
      _touchedFields.contains(field) ? _errors[field] : null;

  List<DepartamentoModel> get departamentos =>
      ubigeo.departamentosState.data ?? [];
  List<ProvinciaModel> get provincias => ubigeo.provinciasState.data ?? [];
  List<DistritoModel> get distritos => ubigeo.distritosState.data ?? [];

  DepartamentoModel? get selectedDepartamento => _selectedDepartamento;
  ProvinciaModel? get selectedProvincia => _selectedProvincia;
  DistritoModel? get selectedDistrito => _selectedDistrito;

  bool get canSelectProvincia => selectedDepartamento != null;
  bool get canSelectDistrito => selectedProvincia != null;

  List<String> getDepartamentoSuggestions(String query) {
    return departamentos
        .where((d) => d.nombre.toLowerCase().contains(query.toLowerCase()))
        .map((d) => d.nombre)
        .toList();
  }

  List<String> getProvinciaSuggestions(String query) {
    return provincias
        .where((p) => p.nombre.toLowerCase().contains(query.toLowerCase()))
        .map((p) => p.nombre)
        .toList();
  }

  List<String> getDistritoSuggestions(String query) {
    return distritos
        .where((d) => d.nombre.toLowerCase().contains(query.toLowerCase()))
        .map((d) => d.nombre)
        .toList();
  }

  void _setupListeners() {
    direccionController.addListener(() => _onFieldChanged('direccion'));
    departamentoController.addListener(() => _onFieldChanged('departamento'));
    provinciaController.addListener(() => _onFieldChanged('provincia'));
    distritoController.addListener(() => _onFieldChanged('distrito'));
  }

  void _onFieldChanged(String field) {
    _touchedFields.add(field);
    _validateField(field);
    _updateFieldProgress();
    notifyListeners();
  }

  String? _validateDireccion(String value) {
    if (value.isEmpty) return 'La dirección es requerida';
    return null;
  }

  String? _validateDepartamento(String value) {
    if (value.isEmpty) return 'Seleccione un departamento';
    return null;
  }

  String? _validateProvincia(String value) {
    if (value.isEmpty) return 'Seleccione una provincia';
    return null;
  }

  String? _validateDistrito(String value) {
    if (value.isEmpty) return 'Seleccione un distrito';
    return null;
  }

  void _validateField(String field) {
    switch (field) {
      case 'direccion':
        _errors['direccion'] = _validateDireccion(direccionController.text);
        break;
      case 'departamento':
        _errors['departamento'] =
            _validateDepartamento(departamentoController.text);
        break;
      case 'provincia':
        _errors['provincia'] = _validateProvincia(provinciaController.text);
        break;
      case 'distrito':
        _errors['distrito'] = _validateDistrito(distritoController.text);
        break;
    }
  }

  bool isFormValid() {
    _validateField('direccion');
    _validateField('departamento');
    _validateField('provincia');
    _validateField('distrito');
    return _errors.values.every((error) => error == null);
  }

  void _updateFieldProgress() {
    if (_flowController == null) return;

    const totalFields = 4; // Total de campos requeridos
    int completedFields = 0;

    // Contar campos completos y sin errores
    if (direccionController.text.isNotEmpty && _errors['direccion'] == null) {
      completedFields++;
    }
    if (departamentoController.text.isNotEmpty &&
        _errors['departamento'] == null) {
      completedFields++;
    }
    if (provinciaController.text.isNotEmpty && _errors['provincia'] == null) {
      completedFields++;
    }
    if (distritoController.text.isNotEmpty && _errors['distrito'] == null) {
      completedFields++;
    }

    _flowController!
        .updateStepProgress(GuideStep.partida, completedFields, totalFields);
  }

  Future<void> init() async {
    if (_isInitialized) return;

    await ubigeo.loadDepartamentos();

    // Establecer valores por defecto
    direccionController.text = direccionDefault;

    // Seleccionar departamento por defecto
    final dep = departamentos.firstWhere(
      (d) => d.nombre.toUpperCase() == departamentoDefault.toUpperCase(),
      orElse: () => departamentos.first,
    );
    await selectDepartamento(dep);

    // Seleccionar provincia por defecto
    final prov = provincias.firstWhere(
      (p) => p.nombre.toUpperCase() == provinciaDefault.toUpperCase(),
      orElse: () => provincias.first,
    );
    await selectProvincia(prov);

    // Seleccionar distrito por defecto
    final dist = distritos.firstWhere(
      (d) => d.nombre.toUpperCase() == distritoDefault.toUpperCase(),
      orElse: () => distritos.first,
    );
    await selectDistrito(dist);

    // Validar todos los campos y actualizar progreso
    _validateField('direccion');
    _validateField('departamento');
    _validateField('provincia');
    _validateField('distrito');
    _updateFieldProgress();

    _isInitialized = true;
    notifyListeners();
  }

  Future<void> selectDepartamento(DepartamentoModel departamento) async {
    if (_selectedDepartamento?.codigo == departamento.codigo) return;

    _selectedDepartamento = departamento;
    _selectedProvincia = null;
    _selectedDistrito = null;
    departamentoController.text = departamento.nombre;
    provinciaController.clear();
    distritoController.clear();

    _touchedFields.add('departamento');
    await ubigeo.loadProvincias(departamento.codigo);
    _validateField('departamento');
    _updateFieldProgress();
    notifyListeners();
  }

  Future<void> selectProvincia(ProvinciaModel provincia) async {
    if (_selectedProvincia?.codigo == provincia.codigo) return;

    _selectedProvincia = provincia;
    _selectedDistrito = null;
    provinciaController.text = provincia.nombre;
    distritoController.clear();

    _touchedFields.add('provincia');
    await ubigeo.loadDistritos(provincia.codigo);
    _validateField('provincia');
    _updateFieldProgress();
    notifyListeners();
  }

  Future<void> selectDistrito(DistritoModel distrito) async {
    if (_selectedDistrito?.codigo == distrito.codigo) return;

    _selectedDistrito = distrito;
    distritoController.text = distrito.nombre;

    _touchedFields.add('distrito');
    _validateField('distrito');
    _updateFieldProgress();
    notifyListeners();
  }

  void validateField(String field, bool hasError, String errorMessage) {
    _errors[field] = hasError ? errorMessage : null;
  }

  Future<void> resetToDefault() async {
    // Establecer dirección
    direccionController.text = direccionDefault;

    // Seleccionar departamento por defecto
    final dep = departamentos.firstWhere(
      (d) => d.nombre.toUpperCase() == departamentoDefault.toUpperCase(),
      orElse: () => departamentos.first,
    );
    await selectDepartamento(dep);

    // Seleccionar provincia por defecto
    final prov = provincias.firstWhere(
      (p) => p.nombre.toUpperCase() == provinciaDefault.toUpperCase(),
      orElse: () => provincias.first,
    );
    await selectProvincia(prov);

    // Seleccionar distrito por defecto
    final dist = distritos.firstWhere(
      (d) => d.nombre.toUpperCase() == distritoDefault.toUpperCase(),
      orElse: () => distritos.first,
    );
    await selectDistrito(dist);

    _errors.forEach((key, _) => _errors[key] = null);
    _touchedFields.clear();
    _validateField('direccion');
    _validateField('departamento');
    _validateField('provincia');
    _validateField('distrito');
    _updateFieldProgress();
    notifyListeners();
  }

  @override
  void dispose() {
    direccionController.dispose();
    departamentoController.dispose();
    provinciaController.dispose();
    distritoController.dispose();
    super.dispose();
  }

  Map<String, dynamic> toJson() {
    return {
      'direccion': direccionController.text,
      'departamento': departamentoController.text,
      'provincia': provinciaController.text,
      'distrito': distritoController.text,
      'ubigeo': selectedDistrito?.codigo ?? '',
      'urbanizacion': '',
    };
  }
}
