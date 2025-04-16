import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app_guias/core/constants/app.colors.dart';
import 'package:app_guias/presentation/controllers/guide/guide.flow.controller.dart';
import 'package:app_guias/presentation/controllers/guide/forms/guide.motivo.traslado.controller.dart';
import 'package:app_guias/presentation/pages/guias/formularios/guide.partida.page.dart';
import 'package:app_guias/presentation/pages/guias/formularios/guide.llegada.page.dart';
import 'package:app_guias/presentation/pages/guias/formularios/guide.destinatario.page.dart';
import 'package:app_guias/presentation/pages/guias/formularios/guide.transporte.page.dart';
import 'package:app_guias/presentation/pages/guias/formularios/guide.detalle.carga.page.dart';
import 'package:app_guias/presentation/pages/guias/formularios/guide.transportista.page.dart';
import 'package:app_guias/presentation/pages/guias/formularios/guide.uso.interno.page.dart';
import 'package:app_guias/presentation/widgets/custom.button.dart';
import 'package:app_guias/presentation/widgets/custom.textfield.dart';

class MotivoTrasladoPage extends StatelessWidget {
  const MotivoTrasladoPage({super.key});

  @override
  Widget build(BuildContext context) {
    final flowController = context.watch<GuideFlowController>();
    final controller = flowController.motivoTrasladoController;
    final size = MediaQuery.of(context).size;
    final isDesktop = size.width > 600;

    // Inicializar el controlador si es necesario
    if (!controller.isInitialized) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        controller.init();
      });
    }

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
      BuildContext context, MotivoTrasladoController controller) {
    return AppBar(
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
    );
  }

  Widget _buildMobileLayout(BuildContext context,
      MotivoTrasladoController controller, GuideFlowController flowController) {
    return ListenableBuilder(
      listenable: controller,
      builder: (context, _) {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: _buildFormFields(controller),
          ),
        );
      },
    );
  }

  Widget _buildDesktopLayout(BuildContext context,
      MotivoTrasladoController controller, GuideFlowController flowController) {
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
                        return _buildFormFields(controller);
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

  // Campos del formulario
  Widget _buildFormFields(MotivoTrasladoController controller) {
    return Column(
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
          onChanged: (value) {
            // Notificar al controlador del cambio de modalidad
            controller.onModalidadChanged();
          },
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
        const SizedBox(height: 16),
        CustomTextField(
          label: 'Descripción del motivo',
          hint: 'Ingrese la descripción del motivo',
          controller: controller.descripcionMotivo,
          type: TextFieldType.text,
          errorText: controller.getError('descripcionMotivo'),
        ),
      ],
    );
  }

  // Sidebar para escritorio
  Widget _buildSidebar() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text(
          'Modalidad y Motivo',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: AppColors.primary,
          ),
        ),
        SizedBox(height: 24),
        Text(
          'Seleccione cómo se realizará el transporte y la razón principal del mismo.',
          style: TextStyle(fontSize: 15, color: Colors.black87, height: 1.4),
        ),
        SizedBox(height: 24),
        Divider(thickness: 1),
        SizedBox(height: 24),
        Text(
          'Modalidad:',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        SizedBox(height: 8),
        Text(
          '• Transporte Público: Realizado por un tercero contratado.\n• Transporte Privado: Realizado con vehículos propios.',
          style: TextStyle(fontSize: 14, height: 1.5),
        ),
        SizedBox(height: 16),
        Text(
          'Motivo:',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        SizedBox(height: 8),
        Text(
          '• Seleccione la opción que mejor describa la razón del traslado (Venta, Compra, Traslado entre establecimientos, etc.).',
          style: TextStyle(fontSize: 14, height: 1.5),
        ),
      ],
    );
  }

  Widget _buildNavigationButtons(BuildContext context,
      MotivoTrasladoController controller, GuideFlowController flowController) {
    final progress =
        flowController.getStepCompletionPercentage(GuideStep.motivoTraslado);
    final isCompleted =
        flowController.isStepCompleted(GuideStep.motivoTraslado);

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

  // Barra inferior solo para móvil
  Widget _buildMobileBottomNavigationBar(BuildContext context,
      MotivoTrasladoController controller, GuideFlowController flowController) {
    return Container(
      padding: const EdgeInsets.all(24.0),
      color: Colors.white,
      child: _buildNavigationButtons(context, controller, flowController),
    );
  }

  // Lógica del botón Siguiente
  void _onNextButtonPressed(BuildContext context,
      MotivoTrasladoController controller, GuideFlowController flowController) {
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
  }
}
