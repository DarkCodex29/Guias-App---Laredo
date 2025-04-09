import 'package:app_guias/core/constants/app.colors.dart';
import 'package:app_guias/presentation/controllers/guide/guide.flow.controller.dart';
import 'package:app_guias/presentation/controllers/guide/forms/guide.destinatario.controller.dart';
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
          : _buildBottomNavigationBar(context, controller, flowController),
    );
  }

  AppBar _buildAppBar(BuildContext context, DestinatarioController controller) {
    return AppBar(
      title:
          const Text('Destinatario', style: TextStyle(color: AppColors.white)),
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
      DestinatarioController controller, GuideFlowController flowController) {
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
      DestinatarioController controller, GuideFlowController flowController) {
    final progress =
        flowController.getStepCompletionPercentage(GuideStep.destinatario);
    final isCompleted = flowController.isStepCompleted(GuideStep.destinatario);

    // Layout de dos columnas para escritorio
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            // Usar Column para poner botones debajo del formulario scrollable
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch, // Estirar botones
              children: [
                Expanded(
                  // Hacer que el formulario ocupe el espacio disponible
                  child: SingleChildScrollView(
                    child: ListenableBuilder(
                      listenable: controller,
                      builder: (context, _) {
                        return _buildFormFields(controller);
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 24), // Espacio antes de los botones
                CustomButton(
                  text: 'Siguiente',
                  isCompleted: isCompleted,
                  progress: progress.toDouble(),
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
            ),
          ),
        ),
        // Columna derecha para el panel lateral
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

  // Panel lateral mejorado
  Widget _buildSidebar() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text(
          'Información del Destinatario',
          style: TextStyle(
            fontSize: 22, // Tamaño de fuente aumentado
            fontWeight: FontWeight.bold,
            color: AppColors.primary,
          ),
        ),
        SizedBox(height: 24), // Mayor espaciado
        Text(
          'Ingrese los datos de la persona o empresa que recibirá la mercancía.',
          style: TextStyle(
              fontSize: 15,
              color: Colors.black87,
              height: 1.4), // Texto más legible
        ),
        SizedBox(height: 24),
        Divider(thickness: 1), // Divisor más grueso
        SizedBox(height: 24),
        Text(
          'Campos Requeridos:',
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.w600), // Estilo ajustado
        ),
        SizedBox(height: 16),
        Padding(
          padding: EdgeInsets.only(left: 8.0),
          child: Text(
            '• Razón Social: Nombre completo o denominación social de la empresa destinataria.',
            style: TextStyle(
                fontSize: 14, height: 1.5), // Altura de línea mejorada
          ),
        ),
        SizedBox(height: 12),
        Padding(
          padding: EdgeInsets.only(left: 8.0),
          child: Text(
            '• RUC: Registro Único de Contribuyentes del destinatario (11 dígitos numéricos).',
            style: TextStyle(fontSize: 14, height: 1.5),
          ),
        ),
      ],
    );
  }

  Widget _buildFormFields(DestinatarioController controller) {
    return Column(
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
    );
  }

  // Lógica extraída del botón Siguiente para reutilizar
  void _onNextButtonPressed(BuildContext context,
      DestinatarioController controller, GuideFlowController flowController) {
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

  // Barra inferior solo para móvil
  Widget _buildBottomNavigationBar(BuildContext context,
      DestinatarioController controller, GuideFlowController flowController) {
    final progress =
        flowController.getStepCompletionPercentage(GuideStep.destinatario);
    final isCompleted = flowController.isStepCompleted(GuideStep.destinatario);

    // Contenido de los botones (la columna)
    Widget buttonColumn = Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CustomButton(
          text: 'Siguiente',
          isCompleted: isCompleted,
          progress: progress.toDouble(),
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

    // Aplicar padding estándar para móvil
    return Container(
      padding: const EdgeInsets.all(24.0),
      color: Colors.white,
      child: buttonColumn,
    );
  }
}
