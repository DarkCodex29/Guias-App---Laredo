import 'package:app_guias/core/constants/app.colors.dart';
import 'package:app_guias/presentation/controllers/guide/guide.flow.controller.dart';
import 'package:app_guias/presentation/pages/guias/formularios/guide.motivo.traslado.page.dart';
import 'package:app_guias/presentation/pages/guias/formularios/guide.uso.interno.page.dart';
import 'package:app_guias/presentation/pages/guias/formularios/guide.partida.page.dart';
import 'package:app_guias/presentation/pages/guias/formularios/guide.llegada.page.dart';
import 'package:app_guias/presentation/pages/guias/formularios/guide.destinatario.page.dart';
import 'package:app_guias/presentation/pages/guias/formularios/guide.transporte.page.dart';
import 'package:app_guias/presentation/pages/guias/formularios/guide.detalle.carga.page.dart';
import 'package:app_guias/presentation/widgets/custom.button.dart';
import 'package:app_guias/presentation/widgets/custom.textfield.dart';
import 'package:app_guias/providers/transportista.provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TransportistaPage extends StatelessWidget {
  const TransportistaPage({super.key});

  @override
  Widget build(BuildContext context) {
    final flowController = context.watch<GuideFlowController>();
    final controller = flowController.transportistaController;

    return Consumer<GuideFlowController>(
      builder: (context, flowController, _) {
        final progress =
            flowController.getStepCompletionPercentage(GuideStep.transportista);
        final isCompleted =
            flowController.isStepCompleted(GuideStep.transportista);

        return Scaffold(
          appBar: AppBar(
            title: const Text('Transportista',
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
                  controller.clear();
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
              final transportistaProvider =
                  context.read<TransportistaProvider>();

              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomTextField(
                        label: 'RUC',
                        hint: 'Ingrese el RUC',
                        controller: controller.rucController,
                        errorText: controller.getError('ruc'),
                        maxLength: 11,
                        keyboardType: TextInputType.number,
                        onChanged: (_) => {},
                        isLoading: controller.isLoading,
                        actionIcon: Icons.search,
                        onActionPressed: () {
                          if (controller.rucController.text.length == 11) {
                            controller.buscarTransportista(
                              controller.rucController.text,
                              transportistaProvider,
                            );
                          }
                        },
                      ),
                      const SizedBox(height: 16),
                      if (controller.errorMessage != null)
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.red.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            children: [
                              const Icon(Icons.error_outline,
                                  color: Colors.red),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  controller.errorMessage!,
                                  style: const TextStyle(color: Colors.red),
                                ),
                              ),
                            ],
                          ),
                        ),
                      const SizedBox(height: 16),
                      CustomTextField(
                        label: 'Nombre',
                        hint: 'Nombre del transportista',
                        controller: controller.nombreController,
                        errorText: controller.getError('nombre'),
                        onChanged: (_) => {},
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
                  progress: progress.toDouble(),
                  isCompleted: isCompleted,
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
