import 'package:app_guias/core/constants/app.colors.dart';
import 'package:app_guias/presentation/controllers/guide/guide.flow.controller.dart';
import 'package:app_guias/presentation/pages/guias/formularios/guide.llegada.page.dart';
import 'package:app_guias/presentation/pages/guias/formularios/guide.destinatario.page.dart';
import 'package:app_guias/presentation/pages/guias/formularios/guide.transporte.page.dart';
import 'package:app_guias/presentation/pages/guias/formularios/guide.detalle.carga.page.dart';
import 'package:app_guias/presentation/pages/guias/formularios/guide.transportista.page.dart';
import 'package:app_guias/presentation/pages/guias/formularios/guide.motivo.traslado.page.dart';
import 'package:app_guias/presentation/pages/guias/formularios/guide.uso.interno.page.dart';
import 'package:app_guias/presentation/widgets/custom.button.dart';
import 'package:app_guias/presentation/widgets/custom.textfield.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PartidaPage extends StatelessWidget {
  const PartidaPage({super.key});

  @override
  Widget build(BuildContext context) {
    final flowController = context.watch<GuideFlowController>();
    final controller = flowController.partidaController;

    // Inicializar el controlador si es necesario
    if (!controller.isInitialized) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        controller.init();
      });
    }

    return Consumer<GuideFlowController>(
      builder: (context, flowController, _) {
        final progress =
            flowController.getStepCompletionPercentage(GuideStep.partida);
        final isCompleted = flowController.isStepCompleted(GuideStep.partida);

        return Scaffold(
          appBar: AppBar(
            title:
                const Text('Partida', style: TextStyle(color: AppColors.white)),
            backgroundColor: AppColors.primary,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              color: AppColors.white,
              onPressed: () => Navigator.pop(context),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.refresh, color: AppColors.white),
                onPressed: () async {
                  controller.resetToDefault();
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Información restablecida'),
                        backgroundColor: Colors.green,
                      ),
                    );
                  }
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
                        label: 'Dirección',
                        hint: 'Ingrese la dirección',
                        controller: controller.direccionController,
                        errorText: controller.getError('direccion'),
                        toUpperCase: true,
                      ),
                      const SizedBox(height: 16),
                      CustomTextField(
                        label: 'Departamento',
                        hint: 'Seleccione el departamento',
                        controller: controller.departamentoController,
                        errorText: controller.getError('departamento'),
                        enableSuggestions: true,
                        suggestions: controller.getDepartamentoSuggestions(''),
                        onSuggestionSelected: (String suggestion) {
                          final departamento =
                              controller.departamentos.firstWhere(
                            (d) => d.nombre == suggestion,
                          );
                          controller.selectDepartamento(departamento);
                        },
                      ),
                      const SizedBox(height: 16),
                      CustomTextField(
                        label: 'Provincia',
                        hint: 'Seleccione la provincia',
                        controller: controller.provinciaController,
                        errorText: controller.getError('provincia'),
                        enableSuggestions: true,
                        suggestions: controller.getProvinciaSuggestions(''),
                        onSuggestionSelected: (String suggestion) {
                          final provincia = controller.provincias.firstWhere(
                            (p) => p.nombre == suggestion,
                          );
                          controller.selectProvincia(provincia);
                        },
                        enabled: controller.canSelectProvincia,
                      ),
                      const SizedBox(height: 16),
                      CustomTextField(
                        label: 'Distrito',
                        hint: 'Seleccione el distrito',
                        controller: controller.distritoController,
                        errorText: controller.getError('distrito'),
                        enableSuggestions: true,
                        suggestions: controller.getDistritoSuggestions(''),
                        onSuggestionSelected: (String suggestion) {
                          final distrito = controller.distritos.firstWhere(
                            (d) => d.nombre == suggestion,
                          );
                          controller.selectDistrito(distrito);
                        },
                        enabled: controller.canSelectDistrito,
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
                          content: Text(
                              'Por favor complete todos los campos requeridos'),
                          backgroundColor: Colors.red,
                        ),
                      );
                      return;
                    }

                    final nextStep = flowController.getNextIncompleteStep();
                    if (nextStep != null) {
                      Widget page;
                      switch (nextStep) {
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
                        case GuideStep.motivoTraslado:
                          page = const MotivoTrasladoPage();
                          break;
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
