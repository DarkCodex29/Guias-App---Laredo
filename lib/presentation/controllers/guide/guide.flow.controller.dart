import 'package:flutter/material.dart';
import 'package:app_guias/presentation/controllers/guide/forms/guide.llegada.controller.dart';
import 'package:app_guias/presentation/controllers/guide/forms/guide.partida.controller.dart';
import 'package:app_guias/presentation/controllers/guide/forms/guide.destinatario.controller.dart';
import 'package:app_guias/presentation/controllers/guide/forms/guide.transporte.controller.dart';
import 'package:app_guias/presentation/controllers/guide/forms/guide.transportista.controller.dart';
import 'package:app_guias/presentation/controllers/guide/forms/guide.motivo.traslado.controller.dart';
import 'package:app_guias/presentation/controllers/guide/forms/guide.uso.interno.controller.dart';
import 'package:app_guias/presentation/controllers/guide/forms/guide.detalle.carga.controller.dart';
import 'package:app_guias/presentation/controllers/guide/forms/widgets/modal.detalle.carga.controller.dart';
import 'package:app_guias/presentation/controllers/ubigeo_controller.dart';
import 'package:app_guias/data/repositories/ubigeo_repository_impl.dart';
import 'package:app_guias/services/firebase.service.dart';

enum GuideStep {
  motivoTraslado,
  partida,
  llegada,
  destinatario,
  transporte,
  transportista,
  detalleCarga,
  usoInterno
}

class GuideFlowController extends ChangeNotifier {
  // Factory para crear una instancia con todas sus dependencias
  factory GuideFlowController.create() {
    final firebaseService = FirebaseService();
    final ubigeoRepository = UbigeoRepositoryImpl(firebaseService);
    final ubigeoController = UbigeoController(ubigeoRepository);

    // Crear el controlador principal
    final flowController = GuideFlowController._internal(
      ubigeoController: ubigeoController,
    );

    return flowController;
  }

  // Constructor privado para la creación interna
  GuideFlowController._internal({
    required UbigeoController ubigeoController,
  })  : partidaController =
            PartidaController(ubigeoController, flowController: null),
        llegadaController =
            LlegadaController(ubigeoController, flowController: null),
        destinatarioController = DestinatarioController(flowController: null),
        transporteController = TransporteController(flowController: null),
        detalleCargaController = DetalleCargaController(flowController: null),
        modalDetalleCargaController =
            ModalDetalleCargaController(flowController: null),
        transportistaController = TransportistaController(flowController: null),
        motivoTrasladoController =
            MotivoTrasladoController(flowController: null),
        usoInternoController = UsoInternoController(flowController: null) {
    // Asignar la referencia al flowController a todos los controladores
    partidaController.setFlowController(this);
    llegadaController.setFlowController(this);
    destinatarioController.setFlowController(this);
    transporteController.setFlowController(this);
    detalleCargaController.setFlowController(this);
    modalDetalleCargaController.setFlowController(this);
    transportistaController.setFlowController(this);
    motivoTrasladoController.setFlowController(this);
    usoInternoController.setFlowController(this);

    // Inicializar los controladores en orden correcto
    _initializeControllers();
  }

  // Método para inicializar los controladores en el orden correcto
  void _initializeControllers() async {
    // Primero inicializar el controlador de motivo de traslado
    await motivoTrasladoController.init();

    // Luego inicializar el resto de controladores
    await partidaController.init();
    await llegadaController.init();
    await destinatarioController.init();
    await transporteController.init();
    await transportistaController.init();
    await detalleCargaController.init();
    await usoInternoController.init();

    // Notificar a los observadores después de la inicialización
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });
  }

  // Controladores de los formularios
  final PartidaController partidaController;
  final LlegadaController llegadaController;
  final DestinatarioController destinatarioController;
  final TransporteController transporteController;
  final DetalleCargaController detalleCargaController;
  final ModalDetalleCargaController modalDetalleCargaController;
  final TransportistaController transportistaController;
  final MotivoTrasladoController motivoTrasladoController;
  final UsoInternoController usoInternoController;

  // Estado del progreso
  final Map<GuideStep, int> _fieldProgress = {
    GuideStep.motivoTraslado: 0,
    GuideStep.partida: 0,
    GuideStep.llegada: 0,
    GuideStep.destinatario: 0,
    GuideStep.transporte: 0,
    GuideStep.transportista: 0,
    GuideStep.detalleCarga: 0,
    GuideStep.usoInterno: 0,
  };

  // El paso actual en el flujo
  GuideStep _currentStep = GuideStep.motivoTraslado;

  GuideStep get currentStep => _currentStep;

  // Devuelve si un paso está completo
  bool isStepCompleted(GuideStep step) {
    return _fieldProgress[step] == 100;
  }

  // Calcula el porcentaje total de avance
  double getCompletionPercentage() {
    int totalSteps = GuideStep.values.length;
    int completedSteps = 0;

    for (var step in GuideStep.values) {
      if (!isStepAvailable(step)) {
        totalSteps--;
        continue;
      }
      if (isStepCompleted(step)) {
        completedSteps++;
      }
    }

    return totalSteps > 0 ? (completedSteps / totalSteps) * 100 : 0;
  }

  // Obtiene el porcentaje de avance para un paso específico
  int getStepCompletionPercentage(GuideStep step) {
    return _fieldProgress[step] ?? 0;
  }

  // Método para que los controladores actualicen su progreso
  void updateStepProgress(
      GuideStep step, int completedFields, int totalFields) {
    if (totalFields <= 0) return;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      int percentage = (completedFields * 100) ~/ totalFields;
      _fieldProgress[step] = percentage;
      notifyListeners();
    });
  }

  // Obtiene el siguiente paso incompleto
  GuideStep? getNextIncompleteStep() {
    final steps = GuideStep.values;
    final currentIndex = steps.indexOf(_currentStep);

    // Buscar el siguiente paso incompleto después del paso actual
    for (int i = currentIndex + 1; i < steps.length; i++) {
      final step = steps[i];
      // Solo considerar el paso si está disponible
      if (isStepAvailable(step) && !isStepCompleted(step)) {
        return step;
      }
    }

    return null;
  }

  // Navega al siguiente paso incompleto
  void goToNextIncompleteStep() {
    final nextStep = getNextIncompleteStep();
    if (nextStep != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _currentStep = nextStep;
        notifyListeners();
      });
    }
  }

  void goToPreviousStep() {
    final currentIndex = GuideStep.values.indexOf(_currentStep);
    if (currentIndex > 0) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _currentStep = GuideStep.values[currentIndex - 1];
        notifyListeners();
      });
    }
  }

  void goToStep(GuideStep step) {
    if (step != _currentStep) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _currentStep = step;
        notifyListeners();
      });
    }
  }

  // Método para verificar si el paso del transportista debe mostrarse
  bool shouldShowTransportistaStep() {
    // Obtener el codigo de modalidad seleccionado ('01' o '02')
    final modalidadTexto = motivoTrasladoController.modalidadTraslado.text;

    // Buscar el código correspondiente al texto seleccionado
    String? codigoModalidad;
    motivoTrasladoController.modalidades.forEach((codigo, texto) {
      if (texto == modalidadTexto) {
        codigoModalidad = codigo;
      }
    });

    // Mostrar transportista solo cuando es PÚBLICO (01)
    return codigoModalidad == '01';
  }

  // Método para verificar si un paso está disponible
  bool isStepAvailable(GuideStep step) {
    if (step == GuideStep.transportista) {
      return shouldShowTransportistaStep();
    }
    return true;
  }
}
