import 'package:flutter/material.dart';
import 'package:app_guias/providers/empleado.provider.dart';
import 'package:app_guias/providers/equipo.provider.dart';
import 'package:app_guias/presentation/controllers/guide/guide.flow.controller.dart';

class TransporteController extends ChangeNotifier {
  GuideFlowController? _flowController;
  bool _isInitialized = false;

  bool get isInitialized => _isInitialized;
  GuideFlowController get flowController => _flowController!;

  final dni = TextEditingController();
  final licenciaConducir = TextEditingController();
  final placaController = TextEditingController();
  final nombresController = TextEditingController();
  final apellidosController = TextEditingController();
  bool? isM1orL;
  bool isLoadingDni = false;
  bool isLoadingPlaca = false;
  String? errorMessage;
  String? errorMessagePlaca;

  // Datos del equipo obtenido por placa
  Map<String, dynamic>? equipoData;

  final Map<String, String?> _errors = {};
  final Set<String> _touchedFields = {};

  TransporteController(
      {GuideFlowController? flowController, bool clearFields = false}) {
    _flowController = flowController;

    if (clearFields) {
      clear();
    }

    _setupListeners();
  }

  void setFlowController(GuideFlowController controller) {
    _flowController = controller;
  }

  void _setupListeners() {
    dni.addListener(() => _onFieldChanged('dni'));
    licenciaConducir.addListener(() => _onFieldChanged('licenciaConducir'));
    placaController.addListener(() => _onFieldChanged('placa'));
    nombresController.addListener(() => _onFieldChanged('nombres'));
    apellidosController.addListener(() => _onFieldChanged('apellidos'));
  }

  void _onFieldChanged(String field) {
    _touchedFields.add(field);
    _validateField(field);
    _updateFieldProgress();
    notifyListeners();
  }

  String? getError(String field) {
    // Solo retornar error si el campo ha sido tocado
    return _touchedFields.contains(field) ? _errors[field] : null;
  }

  void _validateField(String field) {
    String value = '';
    switch (field) {
      case 'dni':
        value = dni.text;
        _errors[field] = _validateDni(value);
        break;
      case 'licenciaConducir':
        value = licenciaConducir.text;
        _errors[field] = _validateBrevete(value);
        break;
      case 'placa':
        value = placaController.text;
        _errors[field] = _validatePlaca(value);
        break;
    }
  }

  void _validateAllFields() {
    _validateField('dni');
    _validateField('licenciaConducir');
    _validateField('placa');
  }

  String? _validateDni(String value) {
    if (value.isEmpty) {
      return 'El DNI es requerido';
    }
    // Validar que sea un número de 8 dígitos
    if (!RegExp(r'^\d{8}$').hasMatch(value)) {
      return 'El DNI debe tener 8 dígitos numéricos';
    }
    return null;
  }

  String? _validateBrevete(String value) {
    if (value.isEmpty) {
      return 'El brevete es requerido';
    }
    return null;
  }

  String? _validatePlaca(String? value) {
    if (value == null || value.isEmpty) {
      return 'La placa es requerida';
    }

    // Eliminar el guión para validar
    final placaSinGuion = value.replaceAll('-', '');

    // Validar que solo contenga letras y números (sin espacios ni caracteres especiales)
    if (!RegExp(r'^[a-zA-Z0-9]+$').hasMatch(placaSinGuion)) {
      return 'La placa solo debe contener letras y números';
    }

    // Validar que no sea solo ceros
    if (RegExp(r'^0+$').hasMatch(placaSinGuion)) {
      return 'La placa no puede contener solo ceros';
    }

    return null;
  }

  void setM1orL(bool? value) {
    isM1orL = value;
    _touchedFields.add('isM1orL'); // Marcar el campo como tocado
    notifyListeners();
    _updateFieldProgress();
  }

  Future<void> buscarEmpleado(String dni, EmpleadoProvider empleadoProvider,
      EquipoProvider equipoProvider) async {
    if (dni.length != 8) return;

    isLoadingDni = true;
    errorMessage = null;
    notifyListeners();

    try {
      final empleado = await empleadoProvider.getEmpleadoByDni(dni);

      if (empleado != null) {
        final nombreCompleto = empleado.empleado.trim();
        final partes = nombreCompleto.split(' ');

        if (partes.length >= 3) {
          apellidosController.text = partes.sublist(0, 2).join(' ');
          nombresController.text = partes.sublist(2).join(' ');
        } else if (partes.length == 2) {
          apellidosController.text = partes[0];
          nombresController.text = partes[1];
        } else {
          nombresController.text = nombreCompleto;
          apellidosController.text = '';
        }
      } else {
        errorMessage = 'No se encontró el empleado';
        limpiarDatosEmpleado();
      }
    } catch (e) {
      errorMessage = 'Error al buscar empleado: ${e.toString()}';
      limpiarDatosEmpleado();
    } finally {
      isLoadingDni = false;
      notifyListeners();
      _updateFieldProgress();
    }
  }

  void limpiarDatosEmpleado() {
    nombresController.clear();
    apellidosController.clear();
  }

  bool isFormValid() {
    _validateAllFields();

    if (_errors.values.any((error) => error != null)) {
      return false;
    }

    if (nombresController.text.isEmpty) {
      errorMessage = 'No se ha seleccionado un empleado válido';
      return false;
    }

    return true;
  }

  void _updateFieldProgress() {
    if (_flowController == null) return;

    int completedFields = 0;
    const totalFields = 5;

    if (dni.text.isNotEmpty) completedFields++;
    if (licenciaConducir.text.isNotEmpty) completedFields++;
    if (placaController.text.isNotEmpty) completedFields++;
    if (nombresController.text.isNotEmpty) completedFields++;
    if (apellidosController.text.isNotEmpty) completedFields++;

    _flowController!
        .updateStepProgress(GuideStep.transporte, completedFields, totalFields);
  }

  Future<void> init() async {
    if (_isInitialized) return;

    // Solo actualizar el progreso inicial
    _updateFieldProgress();

    _isInitialized = true;
    notifyListeners();
  }

  @override
  void dispose() {
    dni.dispose();
    licenciaConducir.dispose();
    placaController.dispose();
    nombresController.dispose();
    apellidosController.dispose();
    super.dispose();
  }

  void clear() {
    dni.clear();
    licenciaConducir.clear();
    placaController.clear();
    nombresController.clear();
    apellidosController.clear();
    limpiarDatosEmpleado();
    isM1orL = null;
    equipoData = null;
    _errors.clear();
    _touchedFields.clear();
    errorMessage = null;
    errorMessagePlaca = null;

    // Limpiar también el campo en UsoInternoController si está disponible
    if (_flowController != null &&
        _flowController!.usoInternoController.isInitialized) {
      _flowController!.usoInternoController.codigoCamion.clear();
      _flowController!.usoInternoController.validateField('codigoCamion', "");
    }

    notifyListeners();
    _updateFieldProgress();
  }

  Map<String, dynamic> toJson() {
    // Eliminar el guion de la placa y convertir a mayúsculas
    String placa =
        placaController.text.trim().replaceAll('-', '').toUpperCase();

    return {
      'indicadorM1L': isM1orL == true ? 'SI' : '',
      'fechaTraslado':
          DateTime.now().toIso8601String().split('T')[0], // YYYY-MM-DD
      'conductor': {
        'numeroDocumento': dni.text.replaceAll('-', ''), // DNI sin guión
        'tipoDocumento': '1', // 1 - DNI
        'nombres':
            nombresController.text.toUpperCase(), // Convertir a mayúsculas
        'apellidos':
            apellidosController.text.toUpperCase(), // Convertir a mayúsculas
        'licencia':
            licenciaConducir.text.toUpperCase(), // Convertir a mayúsculas
      },
      'vehiculo': {
        'placa': placa.isEmpty
            ? null
            : placa, // Enviar null si está vacío para que el servicio lo detecte
      },
    };
  }

  // Método para buscar equipo por placa
  Future<void> buscarEquipoPorPlaca(EquipoProvider equipoProvider) async {
    if (placaController.text.isEmpty) return;

    // Limpiar datos previos
    equipoData = null;
    errorMessagePlaca = null;
    isLoadingPlaca = true;
    notifyListeners();

    try {
      final placa = placaController.text.trim().toUpperCase();
      final equipo = await equipoProvider.getEquipoByPlaca(placa);

      if (_flowController != null &&
          _flowController!.usoInternoController.isInitialized) {
        if (equipo != null) {
          equipoData = {
            'codigo': equipo.codEquipo,
            'tipoEquipo': equipo.tipEquipo,
            'codTransp': equipo.codTransp,
            'placa': equipo.placa
          };

          // Actualizar directamente el campo si UsoInternoController está inicializado
          final codigo = equipo.codEquipo.toString();
          _flowController!.usoInternoController.codigoCamion.text = codigo;

          // Validar el campo para actualizar el progreso
          _flowController!.usoInternoController
              .validateField('codigoCamion', codigo);
        } else {
          errorMessagePlaca =
              'No se encontró equipo con la placa: $placa. Recuerde que deberá ingresar manualmente el código de camión en la sección "Uso Interno".';

          // Limpiar el campo en UsoInternoController cuando no se encuentra un equipo
          _flowController!.usoInternoController.codigoCamion.clear();
          _flowController!.usoInternoController
              .validateField('codigoCamion', "");
        }

        // Si no está inicializado, actualizará cuando se inicialice
        if (!_flowController!.usoInternoController.isInitialized) {
          WidgetsBinding.instance.addPostFrameCallback((_) {});
        }
      } else if (equipo != null) {
        equipoData = {
          'codigo': equipo.codEquipo,
          'tipoEquipo': equipo.tipEquipo,
          'codTransp': equipo.codTransp,
          'placa': equipo.placa
        };
      } else {
        errorMessagePlaca =
            'No se encontró equipo con la placa: $placa. Recuerde que deberá ingresar manualmente el código de camión en la sección "Uso Interno".';
      }
    } catch (e) {
      errorMessagePlaca =
          'Error al buscar equipo: ${e.toString()}. Recuerde que deberá ingresar manualmente el código de camión en la sección "Uso Interno".';

      if (_flowController != null &&
          _flowController!.usoInternoController.isInitialized) {
        _flowController!.usoInternoController.codigoCamion.clear();
        _flowController!.usoInternoController.validateField('codigoCamion', "");
      }
    } finally {
      isLoadingPlaca = false;
      notifyListeners();
    }
  }
}
