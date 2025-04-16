import 'package:flutter/material.dart';
import 'package:app_guias/models/ubigeo.dart';
import 'package:app_guias/presentation/controllers/ubigeo_controller.dart';
import 'package:app_guias/presentation/controllers/guide/guide.flow.controller.dart';

class LlegadaController extends ChangeNotifier {
  final UbigeoController ubigeo;
  GuideFlowController? _flowController;
  bool _isInitialized = false;

  bool get isInitialized => _isInitialized;
  GuideFlowController get flowController => _flowController!;

  // Valores por defecto fijos
  static const String direccionDefault =
      'AV. LOS CHALETS N° 103 - ZONA INDUSTRIAL - LAREDO';
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

  // Set para rastrear campos tocados
  final Set<String> _touchedFields = {};

  LlegadaController(this.ubigeo, {GuideFlowController? flowController}) {
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

  // Getters para habilitar/deshabilitar campos
  bool get canSelectProvincia => selectedDepartamento != null;
  bool get canSelectDistrito => selectedProvincia != null;

  void _setupListeners() {
    direccionController.addListener(() => _onFieldChanged('direccion'));
    departamentoController.addListener(() => _onFieldChanged('departamento'));
    provinciaController.addListener(() => _onFieldChanged('provincia'));
    distritoController.addListener(() => _onFieldChanged('distrito'));
  }

  void _onFieldChanged(String field) {
    _touchedFields.add(field);
    _validateFields();
    _updateProgress();
    notifyListeners();
  }

  void _validateFields() {
    validateField('direccion', direccion.isEmpty, 'La dirección es requerida');
    validateField('departamento', selectedDepartamento == null,
        'Seleccione un departamento');
    validateField(
        'provincia', selectedProvincia == null, 'Seleccione una provincia');
    validateField(
        'distrito', selectedDistrito == null, 'Seleccione un distrito');
  }

  void _updateProgress() {
    if (_flowController == null) return;

    int completedFields = 0;
    const totalFields = 4;

    if (direccion.isNotEmpty) completedFields++;
    if (selectedDepartamento != null) completedFields++;
    if (selectedProvincia != null) completedFields++;
    if (selectedDistrito != null) completedFields++;

    _flowController!
        .updateStepProgress(GuideStep.llegada, completedFields, totalFields);
  }

  // Métodos para sugerencias
  List<String> getDepartamentoSuggestions(String query) {
    return departamentos
        .where((d) => d.nombre.toLowerCase().contains(query.toLowerCase()))
        .map((d) => d.nombre)
        .toList();
  }

  List<String> getProvinciaSuggestions(String query) {
    if (!canSelectProvincia) return [];
    return provincias
        .where((p) => p.nombre.toLowerCase().contains(query.toLowerCase()))
        .map((p) => p.nombre)
        .toList();
  }

  List<String> getDistritoSuggestions(String query) {
    if (!canSelectDistrito) return [];
    return distritos
        .where((d) => d.nombre.toLowerCase().contains(query.toLowerCase()))
        .map((d) => d.nombre)
        .toList();
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

    _validateFields();
    _updateProgress();
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
    _validateFields();
    _updateProgress();
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
    _validateFields();
    _updateProgress();
    notifyListeners();
  }

  Future<void> selectDistrito(DistritoModel distrito) async {
    if (_selectedDistrito?.codigo == distrito.codigo) return;

    _selectedDistrito = distrito;
    distritoController.text = distrito.nombre;
    _touchedFields.add('distrito');
    _validateFields();
    _updateProgress();
    notifyListeners();
  }

  void validateField(String field, bool hasError, String errorMessage) {
    _errors[field] = hasError ? errorMessage : null;
  }

  bool isFormValid() {
    _validateFields();
    return !_errors.values.any((error) => error != null);
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
    _validateFields();
    _updateProgress();
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
      'urbanizacion': '', // No tenemos este campo, lo dejamos vacío
    };
  }
}
