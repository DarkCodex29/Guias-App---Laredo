import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app_guias/core/constants/app.colors.dart';
import 'package:app_guias/presentation/controllers/guide/guide.flow.controller.dart';
import 'package:app_guias/presentation/widgets/custom.button.dart';
import 'package:app_guias/presentation/widgets/custom.textfield.dart';
import 'package:app_guias/providers/empleado.provider.dart';
import 'package:app_guias/providers/equipo.provider.dart';
import 'package:app_guias/providers/transportista.provider.dart';

class UsoInternoPage extends StatelessWidget {
  const UsoInternoPage({super.key});

  @override
  Widget build(BuildContext context) {
    final flowController = context.watch<GuideFlowController>();
    final controller = flowController.usoInternoController;
    final empleadoProvider = context.read<EmpleadoProvider>();
    final transportistaProvider = context.read<TransportistaProvider>();

    // Inicializar el controlador si es necesario
    if (!controller.isInitialized) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        controller.init();
      });
    }

    return Consumer<GuideFlowController>(
      builder: (context, flowController, _) {
        final progress =
            flowController.getStepCompletionPercentage(GuideStep.usoInterno);
        final isCompleted =
            flowController.isStepCompleted(GuideStep.usoInterno);

        return Scaffold(
          appBar: AppBar(
            title: const Text('Uso Interno',
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
                        label: 'N° de liberación',
                        hint: 'Ingrese el n° de liberación',
                        controller: controller.numLiberacion,
                        type: TextFieldType.number,
                        errorText: controller.getError('numLiberacion'),
                        onChanged: (_) => {},
                      ),
                      const SizedBox(height: 16),
                      CustomTextField(
                        label: 'Código de camión',
                        hint: 'Ingrese el código',
                        controller: controller.codigoCamion,
                        readOnly: false,
                        type: TextFieldType.number,
                        maxLength: 6,
                        keyboardType: TextInputType.number,
                        errorText: controller.getError('codigoCamion'),
                        onChanged: (value) =>
                            controller.validateField('codigoCamion', value),
                      ),
                      if (controller.tieneEquipo)
                        Container(
                          margin: const EdgeInsets.only(top: 8),
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
                              Text(
                                'Tipo de equipo: ${controller.tipoEquipo}',
                                style: const TextStyle(color: Colors.green),
                              ),
                            ],
                          ),
                        ),
                      const SizedBox(height: 16),
                      CustomTextField(
                        label: 'Código de chofer de camión',
                        hint: 'Ingrese el código de chofer de camión',
                        controller: controller.codigoChoferCamion,
                        type: TextFieldType.number,
                        errorText: controller.getError('codigoChoferCamion'),
                        onChanged: (_) => {},
                        maxLength: 5,
                        isLoading: controller.isLoadingChoferCamion,
                        actionIcon: Icons.search,
                        onActionPressed: () {
                          if (controller.codigoChoferCamion.text.isNotEmpty) {
                            controller.verificarChofer(
                              controller.codigoChoferCamion.text,
                              empleadoProvider,
                              'camion',
                            );
                          }
                        },
                      ),
                      // Mostrar mensaje de error o validación del chofer
                      if (controller.errorMessageChoferCamion != null)
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
                                  controller.errorMessageChoferCamion!,
                                  style: const TextStyle(color: Colors.red),
                                ),
                              ),
                            ],
                          ),
                        ),
                      // Mostrar mensaje de validación si el chofer existe
                      if (controller.nombreChoferCamion != null)
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
                                  'Empleado: ${controller.nombreChoferCamion}',
                                  style: const TextStyle(color: Colors.green),
                                ),
                              ),
                            ],
                          ),
                        ),
                      const SizedBox(height: 16),
                      CustomTextField(
                        label: 'Código de carreta',
                        hint: 'Ingrese el código de carreta',
                        controller: controller.codigoCarreta,
                        errorText: controller.getError('codigoCarreta'),
                        onChanged: (_) => {},
                        keyboardType: TextInputType.number,
                        maxLength: 6,
                        type: TextFieldType.number,
                        isLoading: controller.isLoadingCarreta,
                        actionIcon: Icons.search,
                        onActionPressed: () {
                          if (controller.codigoCarreta.text.isNotEmpty) {
                            controller.buscarEquipo(
                              controller.codigoCarreta.text,
                              'carreta',
                              context.read<EquipoProvider>(),
                            );
                          }
                        },
                      ),
                      if (controller.errorMessageCarreta != null)
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
                                  controller.errorMessageCarreta!,
                                  style: const TextStyle(color: Colors.red),
                                ),
                              ),
                            ],
                          ),
                        ),
                      if (controller.tipoCarreta != null)
                        Container(
                          margin: const EdgeInsets.only(top: 8),
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
                              Text(
                                'Tipo de equipo: ${controller.tipoCarreta}',
                                style: const TextStyle(color: Colors.green),
                              ),
                            ],
                          ),
                        ),
                      const SizedBox(height: 16),
                      CustomTextField(
                        label: 'Código de alzadora/cosechadora',
                        hint: 'Ingrese el código de alzadora/cosechadora',
                        controller: controller.codigoAlzadora,
                        errorText: controller.getError('codigoAlzadora'),
                        onChanged: (_) => {},
                        keyboardType: TextInputType.number,
                        maxLength: 6,
                        type: TextFieldType.number,
                        isLoading: controller.isLoadingAlzadora,
                        actionIcon: Icons.search,
                        onActionPressed: () {
                          if (controller.codigoAlzadora.text.isNotEmpty) {
                            controller.buscarEquipo(
                              controller.codigoAlzadora.text,
                              'alzadora',
                              context.read<EquipoProvider>(),
                            );
                          }
                        },
                      ),
                      if (controller.errorMessageAlzadora != null)
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
                                  controller.errorMessageAlzadora!,
                                  style: const TextStyle(color: Colors.red),
                                ),
                              ),
                            ],
                          ),
                        ),
                      if (controller.tipoAlzadora != null)
                        Container(
                          margin: const EdgeInsets.only(top: 8),
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
                              Text(
                                'Tipo de equipo: ${controller.tipoAlzadora}',
                                style: const TextStyle(color: Colors.green),
                              ),
                            ],
                          ),
                        ),
                      const SizedBox(height: 16),
                      CustomTextField(
                        label: 'Código de operador',
                        hint: 'Ingrese el código de operador',
                        controller: controller.codigoOperador,
                        type: TextFieldType.number,
                        errorText: controller.getError('codigoOperador'),
                        onChanged: (_) => {},
                        maxLength: 5,
                        isLoading: controller.isLoadingChoferAlzadora,
                        actionIcon: Icons.search,
                        onActionPressed: () {
                          if (controller.codigoOperador.text.isNotEmpty) {
                            controller.verificarChofer(
                              controller.codigoOperador.text,
                              empleadoProvider,
                              'alzadora',
                            );
                          }
                        },
                      ),
                      // Mostrar mensaje de error o validación del chofer de alzadora
                      if (controller.errorMessageChoferAlzadora != null)
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
                                  controller.errorMessageChoferAlzadora!,
                                  style: const TextStyle(color: Colors.red),
                                ),
                              ),
                            ],
                          ),
                        ),
                      // Mostrar mensaje de validación si el chofer existe
                      if (controller.nombreChoferAlzadora != null)
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
                                  'Empleado: ${controller.nombreChoferAlzadora}',
                                  style: const TextStyle(color: Colors.green),
                                ),
                              ),
                            ],
                          ),
                        ),
                      const SizedBox(height: 16),
                      CustomTextField(
                        label: 'Código de transportista de corte',
                        hint: 'Ingrese el código de transportista de corte',
                        controller: controller.codigoCortero,
                        type: TextFieldType.number,
                        errorText: controller.getError('codigoCortero'),
                        onChanged: (_) => {},
                        maxLength: 5,
                        isLoading: controller.isLoadingCortero,
                        actionIcon: Icons.search,
                        onActionPressed: () {
                          if (controller.codigoCortero.text.isNotEmpty) {
                            controller.buscarTransportistaCortero(
                              controller.codigoCortero.text,
                              transportistaProvider,
                            );
                          }
                        },
                      ),
                      // Mostrar mensaje de error o validación del cortero
                      if (controller.errorMessageCortero != null)
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
                                  controller.errorMessageCortero!,
                                  style: const TextStyle(color: Colors.red),
                                ),
                              ),
                            ],
                          ),
                        ),
                      // Mostrar mensaje de validación si el cortero existe
                      if (controller.transportistaCortero != null)
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
                                  'Transportista: ${controller.transportistaCortero?.transportista}',
                                  style: const TextStyle(color: Colors.green),
                                ),
                              ),
                            ],
                          ),
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
                    if (flowController.getCompletionPercentage() == 100) {
                      Navigator.pop(context);
                    } else {
                      flowController.goToNextIncompleteStep();
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
