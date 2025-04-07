import 'package:app_guias/presentation/controllers/guide/guide.flow.controller.dart';
import 'package:app_guias/presentation/controllers/guide/guide.new.controller.dart';
import 'package:app_guias/presentation/pages/guias/formularios/guide.destinatario.page.dart';
import 'package:app_guias/presentation/pages/guias/formularios/guide.detalle.carga.page.dart';
import 'package:app_guias/presentation/pages/guias/formularios/guide.llegada.page.dart';
import 'package:app_guias/presentation/pages/guias/formularios/guide.motivo.traslado.page.dart';
import 'package:app_guias/presentation/pages/guias/formularios/guide.partida.page.dart';
import 'package:app_guias/presentation/pages/guias/formularios/guide.transporte.page.dart';
import 'package:app_guias/presentation/pages/guias/formularios/guide.transportista.page.dart';
import 'package:app_guias/presentation/pages/guias/formularios/guide.uso.interno.page.dart';
import 'package:app_guias/presentation/widgets/custom.button.dart';
import 'package:app_guias/presentation/widgets/custom.progress.button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NewGuidePage extends StatelessWidget {
  final GuideFlowController guideFlowController;

  const NewGuidePage({
    super.key,
    required this.guideFlowController,
  });

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: guideFlowController),
        ChangeNotifierProvider(
          create: (_) => NewGuideController(
            flowController: guideFlowController,
          ),
        ),
      ],
      child: const _NewGuidePageContent(),
    );
  }
}

class _NewGuidePageContent extends StatelessWidget {
  const _NewGuidePageContent();

  @override
  Widget build(BuildContext context) {
    final flowController = context.watch<GuideFlowController>();
    final newGuideController = context.watch<NewGuideController>();
    final totalProgress = flowController.getCompletionPercentage();

    // Proporcionar el contexto al controlador
    WidgetsBinding.instance.addPostFrameCallback((_) {
      newGuideController.setContext(context);
    });

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          children: [
            Image.asset(
              'assets/images/logo.png',
              height: 40,
            ),
          ],
        ),
        centerTitle: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  CustomProgressButton(
                    text: 'Motivo de traslado',
                    onTap: () => _navigateToForm(
                      context,
                      flowController,
                      GuideStep.motivoTraslado,
                      const MotivoTrasladoPage(),
                    ),
                    status:
                        _getStatus(flowController, GuideStep.motivoTraslado),
                    progressValue: flowController.getStepCompletionPercentage(
                            GuideStep.motivoTraslado) /
                        100,
                  ),
                  const SizedBox(height: 12),
                  CustomProgressButton(
                    text: 'Partida',
                    onTap: () => _navigateToForm(
                      context,
                      flowController,
                      GuideStep.partida,
                      const PartidaPage(),
                    ),
                    status: _getStatus(flowController, GuideStep.partida),
                    progressValue: flowController
                            .getStepCompletionPercentage(GuideStep.partida) /
                        100,
                  ),
                  const SizedBox(height: 12),
                  CustomProgressButton(
                    text: 'Llegada',
                    onTap: () => _navigateToForm(
                      context,
                      flowController,
                      GuideStep.llegada,
                      const LlegadaPage(),
                    ),
                    status: _getStatus(flowController, GuideStep.llegada),
                    progressValue: flowController
                            .getStepCompletionPercentage(GuideStep.llegada) /
                        100,
                  ),
                  const SizedBox(height: 12),
                  CustomProgressButton(
                    text: 'Destinatario',
                    onTap: () => _navigateToForm(
                      context,
                      flowController,
                      GuideStep.destinatario,
                      const DestinatarioPage(),
                    ),
                    status: _getStatus(flowController, GuideStep.destinatario),
                    progressValue: flowController.getStepCompletionPercentage(
                            GuideStep.destinatario) /
                        100,
                  ),
                  const SizedBox(height: 12),
                  CustomProgressButton(
                    text: 'Transporte',
                    onTap: () => _navigateToForm(
                      context,
                      flowController,
                      GuideStep.transporte,
                      const TransportePage(),
                    ),
                    status: _getStatus(flowController, GuideStep.transporte),
                    progressValue: flowController
                            .getStepCompletionPercentage(GuideStep.transporte) /
                        100,
                  ),
                  const SizedBox(height: 12),
                  CustomProgressButton(
                    text: 'Detalle de carga',
                    onTap: () => _navigateToForm(
                      context,
                      flowController,
                      GuideStep.detalleCarga,
                      const DetailPage(),
                    ),
                    status: _getStatus(flowController, GuideStep.detalleCarga),
                    progressValue: flowController.getStepCompletionPercentage(
                            GuideStep.detalleCarga) /
                        100,
                  ),
                  const SizedBox(height: 12),
                  if (flowController.shouldShowTransportistaStep()) ...[
                    CustomProgressButton(
                      text: 'Transportista',
                      onTap: () => _navigateToForm(
                        context,
                        flowController,
                        GuideStep.transportista,
                        const TransportistaPage(),
                      ),
                      status:
                          _getStatus(flowController, GuideStep.transportista),
                      progressValue: flowController.getStepCompletionPercentage(
                              GuideStep.transportista) /
                          100,
                    ),
                    const SizedBox(height: 12),
                  ],
                  CustomProgressButton(
                    text: 'Uso interno',
                    onTap: () => _navigateToForm(
                      context,
                      flowController,
                      GuideStep.usoInterno,
                      const UsoInternoPage(),
                    ),
                    status: _getStatus(flowController, GuideStep.usoInterno),
                    progressValue: flowController
                            .getStepCompletionPercentage(GuideStep.usoInterno) /
                        100,
                  ),
                  const SizedBox(height: 12),
                ],
              ),
            ),
            const SizedBox(height: 16),
            CustomButton(
              text: 'Generar Guía de Remisión',
              onPressed: totalProgress == 100
                  ? () => newGuideController.generateGuide(context)
                  : null,
              progress: totalProgress,
            ),
            const SizedBox(height: 12),
            CustomButton(
              text: 'Regresar',
              onPressed: () => Navigator.pop(context),
              isOutlined: true,
            ),
          ],
        ),
      ),
    );
  }

  OptionStatus _getStatus(GuideFlowController controller, GuideStep step) {
    if (!controller.isStepAvailable(step)) {
      return OptionStatus.none;
    }
    if (controller.isStepCompleted(step)) {
      return OptionStatus.completed;
    } else if (controller.getStepCompletionPercentage(step) > 0) {
      return OptionStatus.inProgress;
    }
    return OptionStatus.none;
  }

  void _navigateToForm(BuildContext context, GuideFlowController controller,
      GuideStep step, Widget page) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ChangeNotifierProvider.value(
          value: controller,
          child: page,
        ),
      ),
    );
  }
}
