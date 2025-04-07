import 'package:flutter/material.dart';
import 'package:app_guias/presentation/controllers/guide/guide.flow.controller.dart';
import 'package:app_guias/services/log/logger.service.dart';
import 'package:app_guias/providers/empleado.provider.dart';
import 'package:app_guias/providers/equipo.provider.dart';
import 'package:app_guias/providers/transportista.provider.dart';
import 'package:app_guias/models/vista.transportista.dart';

class UsoInternoController extends ChangeNotifier {
  GuideFlowController? _flowController;
  bool _isInitialized = false;

  bool get isInitialized => _isInitialized;
  GuideFlowController get flowController => _flowController!;

  // Getters para la información del equipo
  String? get tipoEquipo =>
      _flowController?.transporteController.equipoData?['tipoEquipo'];
  bool get tieneEquipo =>
      _flowController?.transporteController.equipoData != null;

  // Getter para obtener la información del equipo desde el TransporteController
  Map<String, dynamic>? get equipoData =>
      _flowController?.transporteController.equipoData;

  // Agregar variables para el tipo de equipo
  final bool _equipoValidado = false;

  // Getters para el tipo de equipo
  bool get equipoValidado => _equipoValidado;

  final numLiberacion = TextEditingController();
  final codigoCamion = TextEditingController();
  final codigoChoferCamion = TextEditingController();
  final codigoCarreta = TextEditingController();
  final codigoAlzadora = TextEditingController();
  final codigoOperador = TextEditingController();
  final codigoCortero = TextEditingController();

  // Variables para estado de chofer de camión
  bool isLoadingChoferCamion = false;
  String? errorMessageChoferCamion;
  String? nombreChoferCamion;

  // Variables para estado de chofer de alzadora
  bool isLoadingChoferAlzadora = false;
  String? errorMessageChoferAlzadora;
  String? nombreChoferAlzadora;

  // Variables para estado de cortero
  bool isLoadingCortero = false;
  String? errorMessageCortero;
  VistaTransportista? transportistaCortero;

  // Variables para estado de búsqueda de carreta
  bool isLoadingCarreta = false;
  String? errorMessageCarreta;
  String? tipoCarreta;

  // Variables para estado de búsqueda de alzadora
  bool isLoadingAlzadora = false;
  String? errorMessageAlzadora;
  String? tipoAlzadora;

  // Variables para estado de búsqueda de camión
  bool isLoadingCamion = false;
  String? errorMessageCamion;
  String? tipoCamion;
  VistaTransportista? transportistaCamion;

  final Map<String, String?> _errors = {
    'numLiberacion': null,
    'codigoCamion': null,
    'codigoChoferCamion': null,
    'codigoCarreta': null,
    'codigoAlzadora': null,
    'codigoChoferAlzadora': null,
    'codigoCortero': null,
  };

  // Set para rastrear campos tocados
  final Set<String> _touchedFields = {};

  UsoInternoController(
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
    numLiberacion.addListener(() => _onFieldChanged('numLiberacion'));
    codigoCamion.addListener(() => _onFieldChanged('codigoCamion'));
    codigoChoferCamion.addListener(() => _onFieldChanged('codigoChoferCamion'));
    codigoCarreta.addListener(() => _onFieldChanged('codigoCarreta'));
    codigoAlzadora.addListener(() => _onFieldChanged('codigoAlzadora'));
    codigoOperador.addListener(() => _onFieldChanged('codigoOperador'));
    codigoCortero.addListener(() => _onFieldChanged('codigoCortero'));
  }

  void _onFieldChanged(String field) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _touchedFields.add(field);
      _validateAllFields();
      _updateFieldProgress();
      notifyListeners();
    });
  }

  void _validateAllFields() {
    if (_touchedFields.contains('numLiberacion')) {
      _errors['numLiberacion'] = _validateNumeroLiberacion(numLiberacion.text);
    }
    if (_touchedFields.contains('codigoCamion')) {
      _errors['codigoCamion'] =
          _validateCodigoNumerico(codigoCamion.text, 'código de camión');
    }
    if (_touchedFields.contains('codigoChoferCamion')) {
      _errors['codigoChoferCamion'] = _validateCodigoNumerico(
          codigoChoferCamion.text, 'código de chofer de camión');
    }
    if (_touchedFields.contains('codigoCarreta')) {
      _errors['codigoCarreta'] =
          _validateCodigoNumerico(codigoCarreta.text, 'código de carreta');
    }
    if (_touchedFields.contains('codigoAlzadora')) {
      _errors['codigoAlzadora'] =
          _validateCodigoNumerico(codigoAlzadora.text, 'código de alzadora');
    }
    if (_touchedFields.contains('codigoChoferAlzadora')) {
      _errors['codigoChoferAlzadora'] = _validateCodigoNumerico(
          codigoOperador.text, 'código de chofer de alzadora');
    }
    if (_touchedFields.contains('codigoCortero')) {
      _errors['codigoCortero'] =
          _validateCodigoNumerico(codigoCortero.text, 'código cortero');
    }
  }

  String? getError(String field) =>
      _touchedFields.contains(field) ? _errors[field] : null;

  void validateField(String field, String value) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _touchedFields.add(field);
      switch (field) {
        case 'numLiberacion':
          _errors[field] = _validateNumeroLiberacion(value);
          break;
        case 'codigoCamion':
          _errors[field] = _validateCodigoNumerico(value, 'código de camión');
          break;
        case 'codigoChoferCamion':
          _errors[field] =
              _validateCodigoNumerico(value, 'código de chofer de camión');
          break;
        case 'codigoCarreta':
          _errors[field] = _validateCodigoNumerico(value, 'código de carreta');
          break;
        case 'codigoAlzadora':
          _errors[field] = _validateCodigoNumerico(value, 'código de alzadora');
          break;
        case 'codigoChoferAlzadora':
          _errors[field] =
              _validateCodigoNumerico(value, 'código de chofer de alzadora');
          break;
        case 'codigoCortero':
          _errors[field] = _validateCodigoNumerico(value, 'código cortero');
          break;
      }
      _updateFieldProgress();
      notifyListeners();
    });
  }

  String? _validateNumeroLiberacion(String value) {
    if (value.isEmpty) return 'El número de liberación es requerido';
    if (!RegExp(r'^\d+$').hasMatch(value)) {
      return 'El número de liberación debe contener solo números';
    }
    return null;
  }

  String? _validateCodigoNumerico(String value, String campo) {
    if (value.isEmpty) return null; // Ahora es opcional

    // Caso especial para código de camión, carreta y alzadora (debe tener máximo 6 dígitos)
    if (campo == 'código de camión' ||
        campo == 'código de carreta' ||
        campo == 'código de alzadora') {
      if (!RegExp(r'^\d{1,6}$').hasMatch(value)) {
        return 'El $campo debe contener solo números (máximo 6 dígitos)';
      }
      return null;
    }

    // Caso especial para códigos de chofer (debe tener exactamente 5 dígitos)
    if (campo == 'código de chofer de camión' ||
        campo == 'código de chofer de alzadora') {
      if (!RegExp(r'^\d{1,5}$').hasMatch(value)) {
        return 'El código de chofer debe contener solo números (máximo 5 dígitos)';
      }
      return null;
    }

    // Validación estándar para otros campos numéricos
    if (!RegExp(r'^\d+$').hasMatch(value)) {
      return 'El $campo debe contener solo números';
    }
    return null;
  }

  bool isFormValid() {
    _validateAllFields();
    // Solo validar que el número de liberación no tenga error
    return _errors['numLiberacion'] == null;
  }

  void _updateFieldProgress() {
    if (_flowController == null) return;

    int completedFields = 0;
    const totalFields = 1; // Solo consideramos el número de liberación

    // Solo contar el número de liberación como obligatorio
    if (numLiberacion.text.isNotEmpty && _errors['numLiberacion'] == null) {
      completedFields = 1;
    }

    _flowController!
        .updateStepProgress(GuideStep.usoInterno, completedFields, totalFields);
  }

  Future<void> init() async {
    if (_isInitialized) return;

    // Verificar si hay datos de equipo en el TransporteController
    if (_flowController != null &&
        _flowController!.transporteController.equipoData != null) {
      final equipoData = _flowController!.transporteController.equipoData!;

      if (equipoData['codigo'] != null) {
        final codigo = equipoData['codigo'].toString();
        final soloNumeros = codigo.replaceAll(RegExp(r'[^\d]'), '');
        LoggerService.info(
            'UsoInternoController: Estableciendo código de camión: $soloNumeros');

        codigoCamion.text = soloNumeros;
        _touchedFields.add('codigoCamion');
      }
    }

    // Solo validar campos si tienen valores por defecto
    if (numLiberacion.text.isNotEmpty) _touchedFields.add('numLiberacion');
    if (codigoChoferCamion.text.isNotEmpty) {
      _touchedFields.add('codigoChoferCamion');
    }
    if (codigoCarreta.text.isNotEmpty) _touchedFields.add('codigoCarreta');
    if (codigoAlzadora.text.isNotEmpty) _touchedFields.add('codigoAlzadora');
    if (codigoOperador.text.isNotEmpty) {
      _touchedFields.add('codigoChoferAlzadora');
    }
    if (codigoCortero.text.isNotEmpty) _touchedFields.add('codigoCortero');

    _validateAllFields();
    _updateFieldProgress();

    _isInitialized = true;
    notifyListeners();
  }

  void resetToDefault() {
    clear();
  }

  Future<void> verificarChofer(
      String codigo, EmpleadoProvider empleadoProvider, String tipo,
      {TransportistaProvider? transportistaProvider}) async {
    if (codigo.isEmpty) return;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (tipo == 'camion') {
        isLoadingChoferCamion = true;
        errorMessageChoferCamion = null;
        nombreChoferCamion = null;
      } else if (tipo == 'alzadora') {
        isLoadingChoferAlzadora = true;
        errorMessageChoferAlzadora = null;
        nombreChoferAlzadora = null;
      } else if (tipo == 'cortero') {
        isLoadingCortero = true;
        errorMessageCortero = null;
        transportistaCortero = null;
      }
      notifyListeners();
    });

    try {
      // Si es cortero y tenemos el provider de transportista, usamos ese
      if (tipo == 'cortero' && transportistaProvider != null) {
        await buscarTransportistaCortero(codigo, transportistaProvider);
        return;
      }

      // Para camión y alzadora, seguimos usando el empleadoProvider
      final response = await empleadoProvider.verificarEmpleado(codigo);

      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (response != null && response['success'] == true) {
          // Obtener el primer apellido del empleado
          final nombreCompleto = response['empleado']?.toString() ?? '';
          final apellidos = nombreCompleto.split(' ');
          final primerApellido = apellidos.isNotEmpty ? apellidos[0] : '';

          if (tipo == 'camion') {
            nombreChoferCamion = primerApellido;
          } else if (tipo == 'alzadora') {
            nombreChoferAlzadora = primerApellido;
          }
          // El caso de cortero lo maneja buscarTransportistaCortero
        } else {
          if (tipo == 'camion') {
            errorMessageChoferCamion = 'El código de chofer no existe';
          } else if (tipo == 'alzadora') {
            errorMessageChoferAlzadora = 'El código de chofer no existe';
          }
        }
        notifyListeners();
      });
    } catch (e) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (tipo == 'camion') {
          errorMessageChoferCamion =
              'Error al verificar el código de chofer: ${e.toString()}';
        } else if (tipo == 'alzadora') {
          errorMessageChoferAlzadora =
              'Error al verificar el código de chofer: ${e.toString()}';
        }
        notifyListeners();
      });
    } finally {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (tipo == 'camion') {
          isLoadingChoferCamion = false;
        } else if (tipo == 'alzadora') {
          isLoadingChoferAlzadora = false;
        }
        // El caso de cortero lo maneja buscarTransportistaCortero
        notifyListeners();
      });
    }
  }

  void clear() {
    numLiberacion.clear();
    codigoCamion.clear();
    codigoChoferCamion.clear();
    codigoCarreta.clear();
    codigoAlzadora.clear();
    codigoOperador.clear();
    codigoCortero.clear();
    _errors.clear();
    _touchedFields.clear();

    // Limpiar estados de chofer de camión
    isLoadingChoferCamion = false;
    errorMessageChoferCamion = null;
    nombreChoferCamion = null;

    // Limpiar estados de chofer de alzadora
    isLoadingChoferAlzadora = false;
    errorMessageChoferAlzadora = null;
    nombreChoferAlzadora = null;

    // Limpiar estados de cortero
    isLoadingCortero = false;
    errorMessageCortero = null;
    transportistaCortero = null;

    // Limpiar estados de carreta
    isLoadingCarreta = false;
    errorMessageCarreta = null;
    tipoCarreta = null;

    // Limpiar estados de alzadora
    isLoadingAlzadora = false;
    errorMessageAlzadora = null;
    tipoAlzadora = null;

    // Limpiar estados de camión
    isLoadingCamion = false;
    errorMessageCamion = null;
    tipoCamion = null;
    transportistaCamion = null;

    _updateFieldProgress();
    notifyListeners();
  }

  @override
  void dispose() {
    numLiberacion.dispose();
    codigoCamion.dispose();
    codigoChoferCamion.dispose();
    codigoCarreta.dispose();
    codigoAlzadora.dispose();
    codigoOperador.dispose();
    codigoCortero.dispose();
    super.dispose();
  }

  Map<String, dynamic> toJson() {
    final choferCamionNombre = nombreChoferCamion ?? '';
    final operAlzadoraNombre = nombreChoferAlzadora ?? '';
    final corteroNombre = transportistaCortero?.transportista ?? '';
    final transportistaCamionNombre = transportistaCamion?.transportista ?? '';

    return {
      'observaciones': [
        'Liberacion: ${numLiberacion.text}',
        'Camion: ${codigoCamion.text}',
        'Transp. Camion: $transportistaCamionNombre',
        'Chofer: ${codigoChoferCamion.text} $choferCamionNombre',
        'Carreta: ${codigoCarreta.text}',
        'Alzadora: ${codigoAlzadora.text}',
        'Oper. Alzadora: ${codigoOperador.text} $operAlzadoraNombre',
        'Cortero: ${codigoCortero.text} $corteroNombre',
      ].join(' | '),
    };
  }

  // Método para buscar equipo (carreta o alzadora)
  Future<void> buscarEquipo(
      String codigo, String tipo, EquipoProvider equipoProvider) async {
    if (codigo.isEmpty) return;

    // Establecer estados según el tipo
    if (tipo == 'carreta') {
      isLoadingCarreta = true;
      errorMessageCarreta = null;
      tipoCarreta = null;
    } else if (tipo == 'alzadora') {
      isLoadingAlzadora = true;
      errorMessageAlzadora = null;
      tipoAlzadora = null;
    }
    notifyListeners();

    try {
      final equipo = await equipoProvider.getEquipoByCodigo(int.parse(codigo));

      if (tipo == 'carreta') {
        if (equipo != null) {
          tipoCarreta = equipo.tipEquipo;
        } else {
          errorMessageCarreta =
              'No se encontró el equipo con el código: $codigo';
        }
      } else if (tipo == 'alzadora') {
        if (equipo != null) {
          tipoAlzadora = equipo.tipEquipo;
        } else {
          errorMessageAlzadora =
              'No se encontró el equipo con el código: $codigo';
        }
      }
    } catch (e) {
      if (tipo == 'carreta') {
        errorMessageCarreta = 'Error al buscar equipo: ${e.toString()}';
      } else if (tipo == 'alzadora') {
        errorMessageAlzadora = 'Error al buscar equipo: ${e.toString()}';
      }
    } finally {
      if (tipo == 'carreta') {
        isLoadingCarreta = false;
      } else if (tipo == 'alzadora') {
        isLoadingAlzadora = false;
      }
      notifyListeners();
    }
  }

  // Nuevo método para buscar cortero usando TransportistaProvider
  Future<void> buscarTransportistaCortero(
      String codigo, TransportistaProvider transportistaProvider) async {
    if (codigo.isEmpty) return;

    isLoadingCortero = true;
    errorMessageCortero = null;
    transportistaCortero = null;
    notifyListeners();

    try {
      final transportista =
          await transportistaProvider.getTransportistaByCodigo(codigo);

      if (transportista != null) {
        transportistaCortero = transportista;
      } else {
        errorMessageCortero = transportistaProvider.error ??
            'No se encontró el transportista con el código: $codigo';
      }
    } catch (e) {
      errorMessageCortero = 'Error al buscar transportista: ${e.toString()}';
    } finally {
      isLoadingCortero = false;
      notifyListeners();
    }
  }

  // Método para buscar el camión y su transportista asociado
  Future<void> buscarCamionYTransportista(
      String codigo,
      EquipoProvider equipoProvider,
      TransportistaProvider transportistaProvider) async {
    if (codigo.isEmpty) return;

    isLoadingCamion = true;
    errorMessageCamion = null;
    tipoCamion = null;
    transportistaCamion = null;
    notifyListeners();

    try {
      // Paso 1: Buscar el equipo por código
      final equipo = await equipoProvider.getEquipoByCodigo(int.parse(codigo));

      if (equipo != null) {
        tipoCamion = equipo.tipEquipo;

        // Obtener codTransp y verificar que no sea nulo
        final int codTransporte = equipo.codTransp;

        // Paso 2: Si codTransporte no es nulo, buscar transportista
        try {
          final transportista = await transportistaProvider
              .getTransportistaByCodigo(codTransporte.toString());

          if (transportista != null) {
            transportistaCamion = transportista;
          } else {
            errorMessageCamion = 'No se encontró información del transportista';
          }
        } catch (e) {
          errorMessageCamion = 'Error al buscar transportista: ${e.toString()}';
        }
      } else {
        errorMessageCamion = 'No se encontró el equipo con el código: $codigo';
      }
    } catch (e) {
      errorMessageCamion = 'Error al buscar equipo: ${e.toString()}';
    } finally {
      isLoadingCamion = false;
      notifyListeners();
    }
  }

  // Verificar si el código de camión está configurado automáticamente o debe ser ingresado manualmente
  bool get requiereBusquedaManualCamion {
    // Si no hay datos de equipo o el código está vacío, se requiere búsqueda manual
    return !tieneEquipo || equipoData?['codigo'] == null;
  }
}
