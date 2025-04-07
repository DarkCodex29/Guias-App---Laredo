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
    '02': 'Venta sujeta a confirmación del comprador',
    '03': 'Compra',
    '04': 'Consignación',
    '05': 'Devolución',
    '06': 'Traslado entre establecimientos de la misma empresa',
    '07': 'Traslado de bienes para transformación',
    '08': 'Recojo de bienes',
    '09': 'Traslado por emisor itinerante de comprobantes de pago',
    '10': 'Traslado zona primaria',
    '11': 'Importación',
    '12': 'Exportación',
    '13': 'Venta con entrega a terceros',
    '14': 'Otros',
  };

  // Lista de modalidades de traslado con sus códigos
  final Map<String, String> modalidades = {
    '01': 'Público',
    '02': 'Privado',
  };

  MotivoTrasladoController({GuideFlowController? flowController}) {
    _flowController = flowController;

    // No establecer valores por defecto al crear el controlador
    // Solo configurar los listeners
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
      // Notificar al flowController del cambio de modalidad para actualizar la UI
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
          motivos['07']!; // 'Traslado de bienes para transformación'

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
        motivos['07']!; // 'Traslado de bienes para transformación'

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
}
