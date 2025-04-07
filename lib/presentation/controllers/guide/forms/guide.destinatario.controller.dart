import 'package:flutter/material.dart';
import 'package:app_guias/presentation/controllers/guide/guide.flow.controller.dart';

class DestinatarioController extends ChangeNotifier {
  GuideFlowController? _flowController;
  bool _isInitialized = false;

  bool get isInitialized => _isInitialized;
  GuideFlowController get flowController => _flowController!;

  final razonSocial = TextEditingController(text: 'AGROINDUSTRIAL LAREDO SAA');
  final ruc = TextEditingController(text: '20132377783');

  final Map<String, String?> _errors = {
    'razonSocial': null,
    'ruc': null,
  };

  // Set para rastrear campos tocados
  final Set<String> _touchedFields = {};

  // Constructor que acepta el flowController
  DestinatarioController(
      {GuideFlowController? flowController, bool clearFields = false}) {
    _flowController = flowController;

    if (clearFields) {
      razonSocial.clear();
      ruc.clear();
    }

    // Configurar listeners para actualizar el progreso cuando cambie el texto
    razonSocial.addListener(() => _onFieldChanged('razonSocial'));
    ruc.addListener(() => _onFieldChanged('ruc'));
  }

  void setFlowController(GuideFlowController controller) {
    _flowController = controller;
  }

  String? getError(String field) =>
      _touchedFields.contains(field) ? _errors[field] : null;

  void validateField(String field, String value) {
    _touchedFields.add(field);
    switch (field) {
      case 'razonSocial':
        _errors[field] = _validateRazonSocial(value);
        break;
      case 'ruc':
        _errors[field] = _validateRuc(value);
        break;
    }
    notifyListeners();
    _updateFieldProgress();
  }

  // Validar todos los campos y contar los completados
  void _validateAllFields() {
    if (_touchedFields.contains('razonSocial')) {
      _errors['razonSocial'] = _validateRazonSocial(razonSocial.text);
    }
    if (_touchedFields.contains('ruc')) {
      _errors['ruc'] = _validateRuc(ruc.text);
    }
  }

  // Actualizar el progreso en el GuideFlowController
  void _updateFieldProgress() {
    if (_flowController == null) return;

    int completedFields = 0;
    const totalFields = 2;

    if (razonSocial.text.isNotEmpty) completedFields++;
    if (ruc.text.isNotEmpty) completedFields++;

    _flowController!.updateStepProgress(
        GuideStep.destinatario, completedFields, totalFields);
  }

  String? _validateRazonSocial(String value) {
    if (value.isEmpty) {
      return 'La razón social es requerida';
    }
    if (value.length < 3) {
      return 'La razón social debe tener al menos 3 caracteres';
    }
    return null;
  }

  String? _validateRuc(String value) {
    if (value.isEmpty) {
      return 'El RUC es requerido';
    }
    if (value.length != 11) {
      return 'El RUC debe tener 11 dígitos';
    }
    return null;
  }

  bool isFormValid() {
    _validateAllFields();
    return !_errors.values.any((error) => error != null);
  }

  @override
  void dispose() {
    razonSocial.dispose();
    ruc.dispose();
    super.dispose();
  }

  void clear() {
    razonSocial.clear();
    ruc.clear();
    _errors.forEach((key, _) => _errors[key] = null);
    _touchedFields.clear();
    _updateFieldProgress();
    notifyListeners();
  }

  void resetToDefault() {
    razonSocial.text = 'AGROINDUSTRIAL LAREDO SAA';
    ruc.text = '20132377783';
    _errors.forEach((key, _) => _errors[key] = null);
    _touchedFields.clear();
    _updateFieldProgress();
    notifyListeners();
  }

  void _onFieldChanged(String field) {
    _touchedFields.add(field);
    _validateField(field);
    _updateFieldProgress();
    notifyListeners();
  }

  void _validateField(String field) {
    switch (field) {
      case 'razonSocial':
        _errors['razonSocial'] = _validateRazonSocial(razonSocial.text);
        break;
      case 'ruc':
        _errors['ruc'] = _validateRuc(ruc.text);
        break;
    }
  }

  Future<void> init() async {
    if (_isInitialized) return;

    // Solo validar campos si tienen valores por defecto
    if (razonSocial.text.isNotEmpty) {
      _touchedFields.add('razonSocial');
    }
    if (ruc.text.isNotEmpty) {
      _touchedFields.add('ruc');
    }

    _validateField('razonSocial');
    _validateField('ruc');
    _updateFieldProgress();

    _isInitialized = true;
    notifyListeners();
  }

  Map<String, dynamic> toJson() {
    return {
      'razonSocial': razonSocial.text.toUpperCase(),
      'tipoDocumento': '6',
      'numeroDocumento': ruc.text.trim(),
    };
  }
}
