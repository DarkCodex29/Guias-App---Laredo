import 'package:app_guias/core/constants/app.colors.dart';
import 'package:app_guias/presentation/controllers/guide/guide.flow.controller.dart';
import 'package:app_guias/presentation/pages/guias/formularios/guide.detalle.carga.page.dart';
import 'package:app_guias/presentation/pages/guias/formularios/guide.motivo.traslado.page.dart';
import 'package:app_guias/presentation/pages/guias/formularios/guide.partida.page.dart';
import 'package:app_guias/presentation/pages/guias/formularios/guide.llegada.page.dart';
import 'package:app_guias/presentation/pages/guias/formularios/guide.transporte.page.dart';
import 'package:app_guias/presentation/pages/guias/formularios/guide.transportista.page.dart';
import 'package:app_guias/presentation/pages/guias/formularios/guide.uso.interno.page.dart';
import 'package:app_guias/presentation/widgets/custom.button.dart';
import 'package:app_guias/presentation/widgets/custom.textfield.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DestinatarioPage extends StatelessWidget {
  const DestinatarioPage({super.key});

  @override
  Widget build(BuildContext context) {
    final flowController = context.watch<GuideFlowController>();
    final controller = flowController.destinatarioController;

    // Inicializar el controlador si es necesario
    if (!controller.isInitialized) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        controller.init();
      });
    }

    return Consumer<GuideFlowController>(
      builder: (context, flowController, _) {
        final progress =
            flowController.getStepCompletionPercentage(GuideStep.destinatario);
        final isCompleted =
            flowController.isStepCompleted(GuideStep.destinatario);

        return Scaffold(
          appBar: AppBar(
            title: const Text('Destinatario',
                style: TextStyle(color: AppColors.white)),
            backgroundColor: AppColors.primary,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              color: AppColors.white,
              onPressed: () => Navigator.pop(context),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.refresh, color: AppColors.white),
                onPressed: () {
                  controller.resetToDefault();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Información restablecida'),
                      backgroundColor: Colors.green,
                    ),
                  );
                },
              ),
            ],
          ),
          body: ListenableBuilder(
            listenable: controller,
            builder: (context, _) {
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomTextField(
                        label: 'Razón social',
                        hint: 'Ingrese la razón social',
                        controller: controller.razonSocial,
                        errorText: controller.getError('razonSocial'),
                        toUpperCase: true,
                      ),
                      const SizedBox(height: 16),
                      CustomTextField(
                        label: 'RUC',
                        hint: 'Ingrese el RUC',
                        keyboardType: TextInputType.number,
                        maxLength: 11,
                        controller: controller.ruc,
                        errorText: controller.getError('ruc'),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomButton(
                  text: 'Siguiente',
                  isCompleted: isCompleted,
                  progress: progress.toDouble(),
                  onPressed: () {
                    if (!controller.isFormValid()) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Por favor, complete todos los campos'),
                          backgroundColor: Colors.red,
                        ),
                      );
                      return;
                    }

                    final nextStep = flowController.getNextIncompleteStep();
                    if (nextStep != null) {
                      Widget page;
                      switch (nextStep) {
                        case GuideStep.motivoTraslado:
                          page = const MotivoTrasladoPage();
                          break;
                        case GuideStep.partida:
                          page = const PartidaPage();
                          break;
                        case GuideStep.llegada:
                          page = const LlegadaPage();
                          break;
                        case GuideStep.destinatario:
                          page = const DestinatarioPage();
                          break;
                        case GuideStep.transporte:
                          page = const TransportePage();
                          break;
                        case GuideStep.detalleCarga:
                          page = const DetailPage();
                          break;
                        case GuideStep.transportista:
                          page = const TransportistaPage();
                          break;
                        case GuideStep.usoInterno:
                          page = const UsoInternoPage();
                          break;
                      }
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ChangeNotifierProvider.value(
                            value: flowController,
                            child: page,
                          ),
                        ),
                      );
                    }
                  },
                ),
                const SizedBox(height: 16),
                CustomButton(
                  text: 'Regresar',
                  onPressed: () => Navigator.pop(context),
                  isOutlined: true,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
