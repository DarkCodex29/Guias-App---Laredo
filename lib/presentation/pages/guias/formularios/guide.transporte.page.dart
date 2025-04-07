import 'package:app_guias/core/constants/app.colors.dart';
import 'package:app_guias/presentation/controllers/guide/guide.flow.controller.dart';
import 'package:app_guias/presentation/pages/guias/formularios/guide.detalle.carga.page.dart';
import 'package:app_guias/presentation/pages/guias/formularios/guide.transportista.page.dart';
import 'package:app_guias/presentation/pages/guias/formularios/guide.motivo.traslado.page.dart';
import 'package:app_guias/presentation/pages/guias/formularios/guide.uso.interno.page.dart';
import 'package:app_guias/presentation/widgets/custom.button.dart';
import 'package:app_guias/presentation/widgets/custom.textfield.dart';
import 'package:app_guias/providers/empleado.provider.dart';
import 'package:app_guias/providers/equipo.provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TransportePage extends StatelessWidget {
  const TransportePage({super.key});

  @override
  Widget build(BuildContext context) {
    final flowController = context.watch<GuideFlowController>();
    final controller = flowController.transporteController;

    return Consumer<GuideFlowController>(
      builder: (context, flowController, _) {
        final progress =
            flowController.getStepCompletionPercentage(GuideStep.transporte);
        final isCompleted =
            flowController.isStepCompleted(GuideStep.transporte);

        return Scaffold(
          appBar: AppBar(
            title: const Text('Transporte',
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
              final empleadoProvider = context.read<EmpleadoProvider>();
              final equipoProvider = context.read<EquipoProvider>();

              return Container(
                width: double.infinity,
                alignment: Alignment.center,
                child: Container(
                  constraints: const BoxConstraints(maxWidth: 600),
                  padding: const EdgeInsets.all(24.0),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomTextField(
                          label: 'DNI',
                          hint: 'Ingrese el DNI',
                          controller: controller.dni,
                          errorText: controller.getError('dni'),
                          maxLength: 8,
                          keyboardType: TextInputType.number,
                          onChanged: (_) => {},
                          isLoading: controller.isLoadingDni,
                          actionIcon: Icons.search,
                          onActionPressed: () {
                            if (controller.dni.text.length == 8) {
                              controller.buscarEmpleado(
                                controller.dni.text,
                                empleadoProvider,
                                equipoProvider,
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
                          label: 'Nombres',
                          hint: 'Nombres del empleado',
                          controller: controller.nombresController,
                          enabled: false,
                        ),
                        const SizedBox(height: 16),
                        CustomTextField(
                          label: 'Apellidos',
                          hint: 'Apellidos del empleado',
                          controller: controller.apellidosController,
                          enabled: false,
                        ),
                        const SizedBox(height: 16),
                        CustomTextField(
                          label: 'Placa',
                          hint: 'Ingrese la placa (ej: ABC-123)',
                          controller: controller.placaController,
                          errorText: controller.getError('placa'),
                          onChanged: (value) {
                            // Formatear automáticamente: insertar guion después de 3 letras
                            if (value.length == 3 && !value.contains('-')) {
                              controller.placaController.text = '$value-';
                              controller.placaController.selection =
                                  TextSelection.fromPosition(
                                TextPosition(
                                    offset:
                                        controller.placaController.text.length),
                              );
                            }

                            // Manejar borrado del guión (si ya tiene guión pero el usuario intenta borrarlo)
                            if (value.length == 3 && value.endsWith('-')) {
                              // Si el usuario intenta borrar el guión, permitirlo quitando también el guión
                              controller.placaController.text =
                                  value.substring(0, 2);
                              controller.placaController.selection =
                                  TextSelection.fromPosition(
                                TextPosition(
                                    offset:
                                        controller.placaController.text.length),
                              );
                            }
                          },
                          textCapitalization: TextCapitalization.characters,
                          toUpperCase: true,
                          maxLength: 7, // 3 letras + 1 guion + 3 números
                          enableSuggestions: false,
                          isLoading: controller.isLoadingPlaca,
                          actionIcon: Icons.search,
                          onActionPressed: () {
                            if (controller.placaController.text.isNotEmpty) {
                              controller.buscarEquipoPorPlaca(equipoProvider);
                            }
                          },
                        ),
                        // Mostrar mensaje de error de la placa
                        if (controller.errorMessagePlaca != null)
                          Container(
                            margin: const EdgeInsets.only(top: 8),
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.red.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: Colors.red.shade300),
                            ),
                            child: Row(
                              children: [
                                const Icon(Icons.error_outline,
                                    color: Colors.red),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    controller.errorMessagePlaca!,
                                    style: const TextStyle(color: Colors.red),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        // Mostrar información del equipo encontrado, si existe
                        if (controller.equipoData != null)
                          Container(
                            margin: const EdgeInsets.only(top: 8, bottom: 8),
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.green.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: Colors.green.shade300),
                            ),
                            child: Row(
                              children: [
                                const Icon(Icons.check_circle,
                                    color: Colors.green),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    'Equipo encontrado: ${controller.equipoData!['codigo']}',
                                    style: const TextStyle(color: Colors.green),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        const SizedBox(height: 16),
                        CustomTextField(
                          label: 'Brevete',
                          hint: 'Ingrese el número de brevete',
                          controller: controller.licenciaConducir,
                          errorText: controller.getError('licenciaConducir'),
                          onChanged: (_) => {},
                          maxLength: 9,
                          textCapitalization: TextCapitalization.characters,
                          toUpperCase: true,
                          enableSuggestions: false,
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            const Expanded(
                              child: Text(
                                'Indicador de traslado M1 o L:',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: AppColors.black,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            //const Text('Sí'),
                            Checkbox(
                              value: controller.isM1orL ?? false,
                              onChanged: (bool? value) =>
                                  controller.setM1orL(value),
                            ),
                          ],
                        ),
                      ],
                    ),
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
