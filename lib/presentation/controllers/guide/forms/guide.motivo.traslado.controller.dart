import 'package:flutter/material.dart';
import 'package:app_guias/presentation/controllers/guide/guide.flow.controller.dart';

class MotivoTrasladoController extends ChangeNotifier {
  GuideFlowController? _flowController;
  bool _isInitialized = false;

  bool get isInitialized => _isInitialized;
  GuideFlowController get flowController => _flowController!;

  final TextEditingController modalidadTraslado = TextEditingController();
  final TextEditingController motivoTraslado = TextEditingController();

  final Map<String, String?> _errors = {
    'modalidadTraslado': null,
    'motivoTraslado': null,
  };

  // Set para rastrear campos tocados
  final Set<String> _touchedFields = {};

  // Índice de motivos de traslado con sus códigos
  final Map<String, String> motivos = {
    '01': 'Venta',
    '02': 'Compra',
    '03': 'Venta con entrega a terceros',
    '04': 'Traslado entre establecimientos de la misma empresa',
    '06': 'Devolucion',
    '08': 'Importacion',
    '09': 'Exportacion',
    '13': 'Otros',
    '14': 'Traslado emisor itinerante CP',
    '15': 'Venta sujeta a confirmación del comprador',
    '16': 'Recojo de bienes transformados',
    '17': 'Traslado de bienes para transformación',
  };

  // Lista de modalidades de traslado con sus códigos
  final Map<String, String> modalidades = {
    '01': 'Público',
    '02': 'Privado',
  };

  MotivoTrasladoController({GuideFlowController? flowController}) {
    _flowController = flowController;
    _setupListeners();
  }

  void setFlowController(GuideFlowController controller) {
    _flowController = controller;
  }

  String? getError(String field) =>
      _touchedFields.contains(field) ? _errors[field] : null;

  void _setupListeners() {
    modalidadTraslado.addListener(() {
      _onFieldChanged('modalidadTraslado');
      if (_flowController != null) {
        _flowController!.notifyListeners();
      }
    });
    motivoTraslado.addListener(() => _onFieldChanged('motivoTraslado'));
  }

  void _onFieldChanged(String field) {
    _touchedFields.add(field);
    validateFields();
    notifyListeners();
  }

  void validateFields() {
    if (_flowController == null) return;

    // Validar campos
    if (_touchedFields.contains('modalidadTraslado')) {
      _errors['modalidadTraslado'] = modalidadTraslado.text.isEmpty
          ? 'La modalidad de traslado es requerida'
          : null;
    }
    if (_touchedFields.contains('motivoTraslado')) {
      _errors['motivoTraslado'] = motivoTraslado.text.isEmpty
          ? 'El motivo de traslado es requerido'
          : null;
    }

    // Actualizar progreso
    int completedFields = 0;
    const totalFields = 2;

    if (modalidadTraslado.text.isNotEmpty) completedFields++;
    if (motivoTraslado.text.isNotEmpty) completedFields++;

    _flowController!.updateStepProgress(
      GuideStep.motivoTraslado,
      completedFields,
      totalFields,
    );
  }

  bool isFormValid() {
    validateFields();
    return !_errors.values.any((error) => error != null);
  }

  Future<void> init() async {
    if (!_isInitialized) {
      // Establecer valores por defecto al inicializar
      modalidadTraslado.text = modalidades['02']!; // 'Privado'
      motivoTraslado.text =
          motivos['17']!; // 'Traslado de bienes para transformación'

      // Marcar campos como tocados para validación
      _touchedFields.add('modalidadTraslado');
      _touchedFields.add('motivoTraslado');

      _isInitialized = true;
    }
    validateFields();
  }

  void resetToDefault() {
    // Establecer valores por defecto estándar para la empresa
    modalidadTraslado.text = modalidades['02']!; // 'Privado'
    motivoTraslado.text =
        motivos['17']!; // 'Traslado de bienes para transformación'

    // Limpiar errores y campos tocados
    _errors.forEach((key, _) => _errors[key] = null);
    _touchedFields.add('modalidadTraslado');
    _touchedFields.add('motivoTraslado');

    // Validar y notificar
    validateFields();
    notifyListeners();
  }

  @override
  void dispose() {
    modalidadTraslado.dispose();
    motivoTraslado.dispose();
    super.dispose();
  }

  Map<String, dynamic> toJson() {
    String getKeyByValue(Map<String, String> map, String value) {
      try {
        return map.entries.firstWhere((entry) => entry.value == value).key;
      } catch (e) {
        // Si no se encuentra el valor, retornar un valor por defecto
        return map.entries.first.key;
      }
    }

    // Obtener los códigos
    final modalidadCodigo = getKeyByValue(modalidades, modalidadTraslado.text);
    final motivoCodigo = getKeyByValue(motivos, motivoTraslado.text);

    return {
      'modalidadTraslado': modalidadCodigo, // '01' o '02'
      'motivoTraslado': motivoCodigo, // '01' a '14'
    };
  }

  // Método para notificar que cambió la modalidad de traslado
  void onModalidadChanged() {
    if (_flowController == null) return;

    // Verificar que el controlador de transporte exista y esté inicializado
    if (_flowController!.transporteController.isInitialized) {
      // Verificar si es transporte público y necesita edición manual
      if (esTransportePublico() &&
          _flowController!.transporteController.dni.text.isEmpty) {
        // Habilitar la edición manual
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _flowController!.transporteController.habilitarEdicionManual(true);
        });
      }
    }
  }

  // Verificar si la modalidad seleccionada es transporte público (código 01)
  bool esTransportePublico() {
    final modalidadTexto = modalidadTraslado.text;
    String? codigoModalidad;

    modalidades.forEach((codigo, texto) {
      if (texto == modalidadTexto) {
        codigoModalidad = codigo;
      }
    });

    return codigoModalidad == '01';
  }
}
