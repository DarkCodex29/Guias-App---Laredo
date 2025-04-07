import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app_guias/core/constants/app.colors.dart';
import 'package:app_guias/presentation/controllers/guide/guide.flow.controller.dart';
import 'package:app_guias/presentation/pages/guias/formularios/guide.uso.interno.page.dart';
import 'package:app_guias/presentation/widgets/custom.button.dart';
import 'package:app_guias/presentation/widgets/custom.textfield.dart';

class MotivoTrasladoPage extends StatelessWidget {
  const MotivoTrasladoPage({super.key});

  @override
  Widget build(BuildContext context) {
    final flowController = context.watch<GuideFlowController>();
    final controller = flowController.motivoTrasladoController;

    // Inicializar el controlador si es necesario
    if (!controller.isInitialized) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        controller.init();
      });
    }

    return Consumer<GuideFlowController>(
      builder: (context, flowController, _) {
        final progress = flowController
            .getStepCompletionPercentage(GuideStep.motivoTraslado);
        final isCompleted =
            flowController.isStepCompleted(GuideStep.motivoTraslado);

        return Scaffold(
          appBar: AppBar(
            title: const Text('Motivo de Traslado',
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
                        label: 'Modalidad de Traslado',
                        hint: 'Seleccione la modalidad de traslado',
                        controller: controller.modalidadTraslado,
                        type: TextFieldType.selection,
                        suggestions: controller.modalidades.values.toList(),
                        enableSuggestions: true,
                        errorText: controller.getError('modalidadTraslado'),
                        onChanged: (_) => {},
                      ),
                      const SizedBox(height: 16),
                      CustomTextField(
                        label: 'Motivo de Traslado',
                        hint: 'Seleccione el motivo de traslado',
                        controller: controller.motivoTraslado,
                        type: TextFieldType.selection,
                        suggestions: controller.motivos.values.toList(),
                        enableSuggestions: true,
                        errorText: controller.getError('motivoTraslado'),
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
                        case GuideStep.usoInterno:
                          page = const UsoInternoPage();
                          break;
                        default:
                          return;
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
