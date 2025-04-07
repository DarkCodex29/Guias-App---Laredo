import 'package:flutter/material.dart';
import 'package:app_guias/providers/transportista.provider.dart';
import 'package:app_guias/presentation/controllers/guide/guide.flow.controller.dart';
import 'package:app_guias/services/log/logger.service.dart';

class TransportistaController extends ChangeNotifier {
  GuideFlowController? _flowController;
  bool _isInitialized = false;
  bool _isLoading = false;
  String? _errorMessage;
  int? _codTransp;

  final Map<String, String?> _errors = {
    'ruc': null,
    'nombre': null,
  };

  // Set para rastrear campos tocados
  final Set<String> _touchedFields = {};

  final rucController = TextEditingController();
  final nombreController = TextEditingController();

  // Valores por defecto para transporte privado
  static const String rucEmpresaDefault = '20132377783';
  static const String nombreEmpresaDefault = 'AGROINDUSTRIAL LAREDO SAA';

  TransportistaController({
    GuideFlowController? flowController,
    bool clearFields = false,
  }) {
    _flowController = flowController;

    // Iniciar siempre con campos vacíos
    clear();

    // Solo configurar los listeners
    _setupListeners();
  }

  Future<void> init() async {
    if (_isInitialized) return;

    // No establecer valores por defecto al inicializar
    // Solo actualizar el estado
    _validateAllFields();
    _updateFieldProgress();
    _isInitialized = true;
    notifyListeners();
  }

  bool get isInitialized => _isInitialized;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  int? get codTransp => _codTransp;
  GuideFlowController get flowController => _flowController!;

  void _setLoading(bool value) {
    if (_isLoading != value) {
      _isLoading = value;
      notifyListeners();
    }
  }

  void _setError(String? message) {
    if (_errorMessage != message) {
      _errorMessage = message;
      notifyListeners();
    }
  }

  void setFlowController(GuideFlowController controller) {
    _flowController = controller;
    _setupListeners();
  }

  void _setupListeners() {
    rucController.addListener(() => _onFieldChanged('ruc'));
    nombreController.addListener(() => _onFieldChanged('nombre'));

    // Escuchar cambios en la modalidad de traslado
    _flowController?.motivoTrasladoController.modalidadTraslado
        .addListener(_onModalidadChanged);
  }

  void _onModalidadChanged() {
    // Si no hay flowController, no podemos obtener la modalidad
    if (_flowController == null) return;

    final modalidadTexto =
        _flowController!.motivoTrasladoController.modalidadTraslado.text;
    if (modalidadTexto.isEmpty) {
      return; // Si aún no hay modalidad seleccionada, salir
    }

    // Obtener el código de modalidad basado en el texto seleccionado
    String? codigoModalidad;
    _flowController!.motivoTrasladoController.modalidades
        .forEach((codigo, texto) {
      if (texto == modalidadTexto) {
        codigoModalidad = codigo;
      }
    });

    // Limpiar todos los campos
    clear();

    // Si es PÚBLICO (01), los campos ya están limpios por la llamada a clear()
    // Si es PRIVADO (02), los campos ya están limpios por la llamada a clear()
    LoggerService.info(
        'Modalidad cambiada a ${codigoModalidad == '01' ? 'PÚBLICA' : 'PRIVADA'} - Campos de transportista limpios');

    _updateFieldProgress();
    notifyListeners();
  }

  void _onFieldChanged(String field) {
    _touchedFields.add(field);
    _validateAllFields();
    _updateFieldProgress();
    notifyListeners();
  }

  String? getError(String field) =>
      _touchedFields.contains(field) ? _errors[field] : null;

  void _validateAllFields() {
    if (_touchedFields.contains('ruc')) {
      _errors['ruc'] = _validateRuc(rucController.text);
    }
    if (_touchedFields.contains('nombre')) {
      _errors['nombre'] = _validateNombre(nombreController.text);
    }
  }

  String? _validateRuc(String value) {
    if (value.isEmpty) return 'El RUC es requerido';
    if (value.length != 11) return 'El RUC debe tener 11 dígitos';
    return null;
  }

  String? _validateNombre(String value) {
    if (value.isEmpty) return 'El nombre es requerido';
    return null;
  }

  void _updateFieldProgress() {
    if (_flowController == null) return;

    int completedFields = 0;
    const totalFields = 2;

    if (rucController.text.isNotEmpty) completedFields++;
    if (nombreController.text.isNotEmpty) completedFields++;

    _flowController!.updateStepProgress(
        GuideStep.transportista, completedFields, totalFields);
  }

  Future<void> buscarTransportista(
      String ruc, TransportistaProvider provider) async {
    _setLoading(true);
    _setError(null);

    try {
      final transportista = await provider.getTransportistaByRuc(ruc);
      if (transportista != null) {
        nombreController.text = transportista.transportista;
        _codTransp = transportista.codTransp;
        _touchedFields.add('nombre');
        _validateAllFields();
        _updateFieldProgress();
      }
    } catch (e) {
      _setError(e.toString());
    } finally {
      _setLoading(false);
    }
  }

  void clear() {
    // Reiniciar los controladores
    rucController.clear();
    nombreController.clear();

    // Limpiar errores y campos tocados
    _errors.forEach((key, _) => _errors[key] = null);
    _touchedFields.clear();

    // Reiniciar otros estados
    _codTransp = null;
    _errorMessage = null;

    // Actualizar progreso
    _updateFieldProgress();
    notifyListeners();
  }

  @override
  void dispose() {
    rucController.dispose();
    nombreController.dispose();
    _flowController?.motivoTrasladoController.modalidadTraslado
        .removeListener(_onModalidadChanged);
    super.dispose();
  }

  Map<String, dynamic> toJson() {
    return {
      'razonSocial': nombreController.text,
      'ruc': rucController.text,
      'conductorDocumento': '',
      'conductorTipoDoc': '1', // DNI
      'conductorNombres': '',
      'conductorApellidos': '',
      'conductorLicencia': '',
      'vehiculoPlaca': '',
    };
  }

  bool isFormValid() {
    // Validar todos los campos
    _validateAllFields();

    // Verificar si hay errores
    if (_errors.values.any((error) => error != null)) {
      return false;
    }

    // Verificar si los campos están vacíos
    if (rucController.text.isEmpty || nombreController.text.isEmpty) {
      return false;
    }

    // Verificar si el transportista fue encontrado
    if (_codTransp == null) {
      _setError('No se encontró el transportista');
      return false;
    }

    return true;
  }
}
