import 'package:app_guias/core/constants/app.colors.dart';
import 'package:app_guias/presentation/controllers/guide/guide.flow.controller.dart';
import 'package:app_guias/presentation/controllers/guide/forms/guide.transportista.controller.dart';
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
    final size = MediaQuery.of(context).size;
    final isDesktop = size.width > 600;

    return Scaffold(
      appBar: _buildAppBar(context, controller),
      body: isDesktop
          ? _buildDesktopLayout(context, controller, flowController)
          : _buildMobileLayout(context, controller, flowController),
      bottomNavigationBar: isDesktop
          ? null
          : _buildMobileBottomNavigationBar(
              context, controller, flowController),
    );
  }

  AppBar _buildAppBar(
      BuildContext context, TransportistaController controller) {
    return AppBar(
      title:
          const Text('Transportista', style: TextStyle(color: AppColors.white)),
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
    );
  }

  Widget _buildMobileLayout(BuildContext context,
      TransportistaController controller, GuideFlowController flowController) {
    return ListenableBuilder(
      listenable: controller,
      builder: (context, _) {
        return SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: _buildFormFields(context, controller),
        );
      },
    );
  }

  Widget _buildDesktopLayout(BuildContext context,
      TransportistaController controller, GuideFlowController flowController) {
    return Row(
      children: [
        // Columna izquierda: Formulario y botones
        Expanded(
          flex: 3,
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: ListenableBuilder(
                      listenable: controller,
                      builder: (context, _) {
                        return _buildFormFields(context, controller);
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                _buildNavigationButtons(context, controller, flowController),
              ],
            ),
          ),
        ),
        // Columna derecha: Sidebar
        Expanded(
          flex: 1,
          child: Container(
            color: Colors.grey[100],
            child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: _buildSidebar(),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFormFields(
      BuildContext context, TransportistaController controller) {
    final transportistaProvider = context.read<TransportistaProvider>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomTextField(
          label: 'RUC',
          hint: 'Ingrese el RUC del transportista',
          controller: controller.rucController,
          errorText: controller.getError('ruc'),
          maxLength: 11,
          keyboardType: TextInputType.number,
          onChanged: (value) {
            if (value.length == 11) {
              // Podríamos llamar a buscar aquí si queremos búsqueda automática al escribir
              // controller.buscarTransportista(value, transportistaProvider);
            } else {
              // Limpiar campos si el RUC ya no tiene 11 dígitos?
              // controller.clearNombreSiRucIncompleto();
            }
          },
          isLoading: controller.isLoading,
          actionIcon: Icons.search,
          onActionPressed: () {
            if (controller.rucController.text.length == 11) {
              controller.buscarTransportista(
                controller.rucController.text,
                transportistaProvider,
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('El RUC debe tener 11 dígitos'),
                  backgroundColor: Colors.orange,
                ),
              );
            }
          },
        ),
        const SizedBox(height: 16),
        _buildRucMessage(controller),
        const SizedBox(height: 16),
        CustomTextField(
          label: 'Nombre o Razón Social',
          hint: 'Nombre/Razón Social del transportista',
          controller: controller.nombreController,
          errorText: controller.getError('nombre'),
        ),
      ],
    );
  }

  Widget _buildRucMessage(TransportistaController controller) {
    if (controller.isLoading) {
      return const SizedBox.shrink(); // No mostrar nada mientras carga
    }
    if (controller.errorMessage != null) {
      return _buildMessageContainer(
        message: controller.errorMessage!,
        isError: true,
      );
    } else if (controller.rucController.text.length == 11 &&
        controller.nombreController.text.isNotEmpty &&
        !controller.isLoading) {
      return _buildMessageContainer(
          message: 'Transportista encontrado', isError: false);
    }
    return const SizedBox.shrink();
  }

  Widget _buildMessageContainer(
      {required String message, required bool isError}) {
    final color = isError ? Colors.red : Colors.green;
    final icon = isError ? Icons.error_outline : Icons.check_circle_outline;

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.shade300),
      ),
      child: Row(
        children: [
          Icon(icon, color: color),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              message,
              style: TextStyle(color: color, fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }

  // Sidebar para escritorio
  Widget _buildSidebar() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text(
          'Datos del Transportista',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: AppColors.primary,
          ),
        ),
        SizedBox(height: 24),
        Text(
          'Ingresa el RUC de la empresa transportista que realizará el traslado de los bienes.',
          style: TextStyle(fontSize: 15, color: Colors.black87, height: 1.4),
        ),
        SizedBox(height: 24),
        Divider(thickness: 1),
        SizedBox(height: 24),
        Text(
          'Búsqueda por RUC:',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        SizedBox(height: 16),
        Text(
          '• Ingresa los 11 dígitos del RUC.\n• Presiona el ícono de búsqueda (🔍) para buscar automáticamente la razón social.\n• Si el RUC es encontrado, el campo "Nombre o Razón Social" se llenará automáticamente.\n• Si no se encuentra, deberás ingresar el nombre manualmente.',
          style: TextStyle(fontSize: 14, height: 1.6),
        ),
      ],
    );
  }

  // Botones de navegación
  Widget _buildNavigationButtons(BuildContext context,
      TransportistaController controller, GuideFlowController flowController) {
    final progress =
        flowController.getStepCompletionPercentage(GuideStep.transportista);
    final isCompleted = flowController.isStepCompleted(GuideStep.transportista);

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        CustomButton(
          text: 'Siguiente',
          progress: progress.toDouble(),
          isCompleted: isCompleted,
          onPressed: () =>
              _onNextButtonPressed(context, controller, flowController),
        ),
        const SizedBox(height: 16),
        CustomButton(
          text: 'Regresar',
          onPressed: () => Navigator.pop(context),
          isOutlined: true,
        ),
      ],
    );
  }

  // Barra inferior para móvil
  Widget _buildMobileBottomNavigationBar(BuildContext context,
      TransportistaController controller, GuideFlowController flowController) {
    return Container(
      padding: const EdgeInsets.all(24.0),
      color: Colors.white,
      child: _buildNavigationButtons(context, controller, flowController),
    );
  }

  // Lógica del botón Siguiente
  void _onNextButtonPressed(BuildContext context,
      TransportistaController controller, GuideFlowController flowController) {
    if (!controller.isFormValid()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Por favor, complete todos los campos requeridos'),
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
  }
}
