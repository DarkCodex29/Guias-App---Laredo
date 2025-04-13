import 'package:app_guias/core/constants/app.colors.dart';
import 'package:app_guias/presentation/controllers/guide/guide.flow.controller.dart';
import 'package:app_guias/presentation/controllers/guide/forms/guide.llegada.controller.dart';
import 'package:app_guias/presentation/pages/guias/formularios/guide.partida.page.dart';
import 'package:app_guias/presentation/pages/guias/formularios/guide.destinatario.page.dart';
import 'package:app_guias/presentation/pages/guias/formularios/guide.detalle.carga.page.dart';
import 'package:app_guias/presentation/pages/guias/formularios/guide.transporte.page.dart';
import 'package:app_guias/presentation/pages/guias/formularios/guide.transportista.page.dart';
import 'package:app_guias/presentation/pages/guias/formularios/guide.motivo.traslado.page.dart';
import 'package:app_guias/presentation/pages/guias/formularios/guide.uso.interno.page.dart';
import 'package:app_guias/presentation/widgets/custom.button.dart';
import 'package:app_guias/presentation/widgets/custom.textfield.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LlegadaPage extends StatelessWidget {
  const LlegadaPage({super.key});

  @override
  Widget build(BuildContext context) {
    final flowController = context.watch<GuideFlowController>();
    final controller = flowController.llegadaController;
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

  AppBar _buildAppBar(BuildContext context, LlegadaController controller) {
    return AppBar(
      title: const Text('Llegada', style: TextStyle(color: AppColors.white)),
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
            await controller.resetToDefault();
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
    );
  }

  Widget _buildMobileLayout(BuildContext context, LlegadaController controller,
      GuideFlowController flowController) {
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

  Widget _buildDesktopLayout(BuildContext context, LlegadaController controller,
      GuideFlowController flowController) {
    return Row(
      children: [
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
  Widget _buildFormFields(LlegadaController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomTextField(
          label: 'Dirección',
          hint: 'Dirección de AGROINDUSTRIAL LAREDO',
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
            final departamento = controller.departamentos
                .firstWhere((d) => d.nombre == suggestion);
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
            final provincia =
                controller.provincias.firstWhere((p) => p.nombre == suggestion);
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
            final distrito =
                controller.distritos.firstWhere((d) => d.nombre == suggestion);
            controller.selectDistrito(distrito);
          },
          enabled: controller.canSelectDistrito,
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
          'Punto de Llegada',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: AppColors.primary,
          ),
        ),
        SizedBox(height: 24),
        Text(
          'Ingrese la dirección completa y seleccione el Departamento, Provincia y Distrito donde finalizará el traslado de los bienes.',
          style: TextStyle(fontSize: 15, color: Colors.black87, height: 1.4),
        ),
        SizedBox(height: 24),
        Divider(thickness: 1),
        SizedBox(height: 24),
        Text(
          'Selección de Ubigeo:',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        SizedBox(height: 16),
        Text(
          '• Comience seleccionando el Departamento.\n• Luego se habilitará la selección de Provincia.\n• Finalmente, podrá seleccionar el Distrito.',
          style: TextStyle(fontSize: 14, height: 1.5),
        ),
      ],
    );
  }

  // Botones de navegación (para escritorio y móvil)
  Widget _buildNavigationButtons(BuildContext context,
      LlegadaController controller, GuideFlowController flowController) {
    final progress =
        flowController.getStepCompletionPercentage(GuideStep.llegada);
    final isCompleted = flowController.isStepCompleted(GuideStep.llegada);

    Widget buttonColumn = Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CustomButton(
          text: 'Siguiente',
          isCompleted: isCompleted,
          progress: progress.toDouble(),
          onPressed: () {
            _onNextButtonPressed(context, controller, flowController);
          },
        ),
        const SizedBox(height: 16),
        CustomButton(
          text: 'Regresar',
          onPressed: () => Navigator.pop(context),
          isOutlined: true,
        ),
      ],
    );
    return buttonColumn;
  }

  Widget _buildMobileBottomNavigationBar(BuildContext context,
      LlegadaController controller, GuideFlowController flowController) {
    return Container(
      padding: const EdgeInsets.all(24.0),
      color: Colors.white,
      child: _buildNavigationButtons(context, controller, flowController),
    );
  }

  void _onNextButtonPressed(BuildContext context, LlegadaController controller,
      GuideFlowController flowController) {
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
