import 'package:app_guias/core/models/detalle.carga.dart';
import 'package:app_guias/core/services/detalle.carga.service.dart';
import 'package:app_guias/presentation/controllers/guide/guide.flow.controller.dart';
import 'package:app_guias/services/log/logger.service.dart';
import 'package:flutter/material.dart';

class DetalleCargaController extends ChangeNotifier {
  GuideFlowController? _flowController;
  bool _isInitialized = false;
  final _detalleCargaService = DetalleCargaService();
  List<DetalleCarga> _detalleCargas = [];

  bool get isInitialized => _isInitialized;
  GuideFlowController get flowController => _flowController!;
  List<DetalleCarga> get detalleCargas => _detalleCargas;

  DetalleCargaController({GuideFlowController? flowController}) {
    _flowController = flowController;
    _setupListeners();
    loadDetalleCargas();
  }

  void setFlowController(GuideFlowController controller) {
    _flowController = controller;
  }

  void _setupListeners() {
    // No necesitamos listeners aquí ya que el progreso se actualiza
    // cuando se cargan los detalles o se eliminan
  }

  void _updateFieldProgress() {
    if (_flowController == null) return;

    int completedFields = _detalleCargas.isNotEmpty ? 1 : 0;
    const totalFields = 1;

    _flowController!.updateStepProgress(
        GuideStep.detalleCarga, completedFields, totalFields);
  }

  Future<void> loadDetalleCargas() async {
    _detalleCargas = await _detalleCargaService.getAllDetalles();
    _updateFieldProgress();
    notifyListeners();
  }

  Future<void> deleteDetalle(BuildContext context, int index) async {
    try {
      await _detalleCargaService.deleteDetalle(index);
      _detalleCargas.removeAt(index);
      _updateFieldProgress();
      notifyListeners();
      if (context.mounted) {
        _showSnackBar(context, 'Detalle eliminado exitosamente', Colors.green);
      }
    } catch (e) {
      if (context.mounted) {
        _showSnackBar(context, 'Error al eliminar detalle: $e', Colors.red);
      }
    }
  }

  void _showSnackBar(BuildContext context, String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: color,
      ),
    );
  }

  Future<void> init() async {
    if (_isInitialized) return;

    await loadDetalleCargas();

    _isInitialized = true;
    _updateFieldProgress();
    notifyListeners();
  }

  double calcularPesoTotal() {
    return detalleCargas.fold(0.0, (sum, item) => sum + item.pesoKg);
  }

  // Determina si debemos usar TNE o KGM basado en las unidades de los items
  String determinarUnidadMedidaTotal() {
    // Si hay al menos un item con unidad TM, usamos TNE
    if (detalleCargas.any((item) => item.unidadMedida == 'TM')) {
      return 'TNE';
    } else {
      return 'KGM';
    }
  }

  // Calcula el peso en la unidad adecuada
  double calcularPesoEnUnidadCorrecta() {
    double totalKg = calcularPesoTotal();
    if (determinarUnidadMedidaTotal() == 'TNE') {
      return totalKg / 1000; // Convertir a toneladas
    } else {
      return totalKg; // Mantener en kilogramos
    }
  }

  double calcularPesoTotalToneladas() {
    return calcularPesoTotal() / 1000;
  }

  String formatearPesoTotal() {
    double totalKg = calcularPesoTotal();
    if (totalKg >= 1000) {
      double tne = totalKg / 1000;
      double kgRestantes = totalKg % 1000;
      if (kgRestantes > 0) {
        return '${tne.toStringAsFixed(0)} TNE - ${kgRestantes.toStringAsFixed(2)} KGM';
      } else {
        return '${tne.toStringAsFixed(0)} TNE';
      }
    }
    return '${totalKg.toStringAsFixed(2)} KGM';
  }

  Map<String, dynamic> toJson() {
    return {
      'items': detalleCargas
          .asMap()
          .entries
          .map((entry) => {
                'numero': (entry.key + 1).toString(),
                'unidadMedida': entry.value.unidadMedida,
                'descripcionUnidad': entry.value.unidadMedida == 'TM'
                    ? 'TONELADA METRICA'
                    : 'KILOGRAMO',
                'cantidad': entry.value.cantidad.toString(),
                'descripcion': entry.value.producto,
                'codigo': '',
                'codigoSunat': '',
                'campo': entry.value.campo,
                'jiron': entry.value.jiron,
                'cuartel': entry.value.cuartel,
                'variedad': entry.value.variedad,
                'fechaCorte': entry.value.fechaCorte,
              })
          .toList(),
      'pesoBruto': calcularPesoEnUnidadCorrecta().toString(),
      'unidadMedida': determinarUnidadMedidaTotal(),
    };
  }

  Future<void> resetData() async {
    try {
      // Limpiar todos los detalles en almacenamiento
      await _detalleCargaService.deleteAll();

      // Actualizar la lista en memoria
      _detalleCargas.clear();

      // Actualizar progreso y notificar
      _updateFieldProgress();
      notifyListeners();
    } catch (e) {
      LoggerService.error('Error al limpiar detalles de carga: $e');
    }
  }
}
