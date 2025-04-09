import 'package:app_guias/core/constants/app.colors.dart';
import 'package:app_guias/presentation/controllers/guide/guide.flow.controller.dart';
import 'package:app_guias/presentation/controllers/guide/forms/guide.transporte.controller.dart';
import 'package:app_guias/presentation/pages/guias/formularios/guide.detalle.carga.page.dart';
import 'package:app_guias/presentation/pages/guias/formularios/guide.transportista.page.dart';
import 'package:app_guias/presentation/pages/guias/formularios/guide.motivo.traslado.page.dart';
import 'package:app_guias/presentation/pages/guias/formularios/guide.uso.interno.page.dart';
import 'package:app_guias/presentation/pages/guias/formularios/guide.partida.page.dart';
import 'package:app_guias/presentation/pages/guias/formularios/guide.llegada.page.dart';
import 'package:app_guias/presentation/pages/guias/formularios/guide.destinatario.page.dart';
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

  AppBar _buildAppBar(BuildContext context, TransporteController controller) {
    return AppBar(
      title: const Text('Transporte', style: TextStyle(color: AppColors.white)),
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
      TransporteController controller, GuideFlowController flowController) {
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
      TransporteController controller, GuideFlowController flowController) {
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
      BuildContext context, TransporteController controller) {
    final empleadoProvider = context.read<EmpleadoProvider>();
    final equipoProvider = context.read<EquipoProvider>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomTextField(
          label: 'DNI',
          hint: 'Ingrese el DNI del conductor',
          controller: controller.dni,
          errorText: controller.getError('dni'),
          maxLength: 8,
          keyboardType: TextInputType.number,
          onChanged: (value) {
            if (value.length == 8) {
              controller.buscarEmpleado(
                  value, empleadoProvider, equipoProvider);
            }
          },
          isLoading: controller.isLoadingDni,
        ),
        const SizedBox(height: 16),
        // Mensaje de error/info para DNI
        _buildDniMessage(controller),
        const SizedBox(height: 16),
        CustomTextField(
          label: 'Nombres',
          hint: 'Nombres del conductor',
          controller: controller.nombresController,
          enabled: controller.nombresEditables,
          errorText: controller.getError('nombres'),
          onChanged: (_) {},
          toUpperCase: true,
        ),
        const SizedBox(height: 16),
        CustomTextField(
          label: 'Apellidos',
          hint: 'Apellidos del conductor',
          controller: controller.apellidosController,
          enabled: controller.nombresEditables,
          errorText: controller.getError('apellidos'),
          onChanged: (_) {},
          toUpperCase: true,
        ),
        const SizedBox(height: 16),
        CustomTextField(
          label: 'Placa',
          hint: 'Ingrese la placa (ej: ABC-123)',
          controller: controller.placaController,
          errorText: controller.getError('placa'),
          onChanged: (value) {
            value = value.toUpperCase();
            String placaFormateada = value;
            if (value.length == 3 && !value.contains('-')) {
              placaFormateada = '$value-';
            } else if (value.length == 4 &&
                value.endsWith('-') &&
                controller.placaController.text.length < 4) {
              placaFormateada = value.substring(0, 3);
            }

            if (placaFormateada != controller.placaController.text) {
              controller.placaController.value = TextEditingValue(
                text: placaFormateada,
                selection:
                    TextSelection.collapsed(offset: placaFormateada.length),
              );
            }

            if (placaFormateada.length == 7) {
              controller.buscarEquipoPorPlaca(equipoProvider);
            }
          },
          textCapitalization: TextCapitalization.characters,
          toUpperCase: true,
          maxLength: 7,
          enableSuggestions: false,
          isLoading: controller.isLoadingPlaca,
        ),
        const SizedBox(height: 16),
        // Mensaje de error/info para Placa
        _buildPlacaMessage(controller),
        const SizedBox(height: 16),
        CustomTextField(
          label: 'Brevete',
          hint: 'Ingrese el número de brevete',
          controller: controller.licenciaConducir,
          errorText: controller.getError('licenciaConducir'),
          onChanged: (_) {},
          maxLength: 9,
          textCapitalization: TextCapitalization.characters,
          toUpperCase: true,
          enableSuggestions: false,
        ),
        const SizedBox(height: 24),
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
            Checkbox(
              value: controller.isM1orL ?? false,
              onChanged: (bool? value) => controller.setM1orL(value),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDniMessage(TransporteController controller) {
    if (controller.isLoadingDni) {
      return const SizedBox.shrink();
    }
    if (controller.errorMessage != null) {
      return _buildMessageContainer(
        message: controller.errorMessage!,
        isError: true,
      );
    } else if (controller.dni.text.length == 8 &&
        controller.nombresController.text.isNotEmpty &&
        !controller.nombresEditables) {
      return _buildMessageContainer(
          message: 'Empleado encontrado', isError: false);
    }
    return const SizedBox.shrink();
  }

  Widget _buildPlacaMessage(TransporteController controller) {
    if (controller.isLoadingPlaca) {
      return const SizedBox.shrink();
    }
    if (controller.errorMessagePlaca != null) {
      return _buildMessageContainer(
        message: controller.errorMessagePlaca!,
        isError: true,
      );
    } else if (controller.equipoData != null) {
      return _buildMessageContainer(
        message: 'Equipo encontrado: ${controller.equipoData!['codigo']}',
        isError: false,
      );
    }
    return const SizedBox.shrink();
  }

  Widget _buildMessageContainer(
      {required String message, required bool isError}) {
    final color = isError ? Colors.red : Colors.green;
    final icon = isError ? Icons.error_outline : Icons.check_circle_outline;

    return Container(
      margin: const EdgeInsets.only(top: 8, bottom: 8),
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
          'Datos de Transporte',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: AppColors.primary,
          ),
        ),
        SizedBox(height: 24),
        Text(
          'Ingresa los datos del conductor y del vehículo que realizará el transporte.',
          style: TextStyle(fontSize: 15, color: Colors.black87, height: 1.4),
        ),
        SizedBox(height: 24),
        Divider(thickness: 1),
        SizedBox(height: 24),
        Text(
          'Detalles:',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        SizedBox(height: 16),
        Text(
          '• DNI: Busca automáticamente al empleado. Si no se encuentra, puedes ingresar nombres y apellidos manualmente.\n• Placa: Ingresa la placa en formato XXX-000. Se buscará automáticamente el equipo asociado.\n• Brevete: Número de licencia de conducir.\n• M1/L: Marca esta casilla si el vehículo es de categoría M1 o L (vehículos ligeros).',
          style: TextStyle(fontSize: 14, height: 1.6),
        ),
      ],
    );
  }

  // Botones de navegación
  Widget _buildNavigationButtons(BuildContext context,
      TransporteController controller, GuideFlowController flowController) {
    final progress =
        flowController.getStepCompletionPercentage(GuideStep.transporte);
    final isCompleted = flowController.isStepCompleted(GuideStep.transporte);

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
      TransporteController controller, GuideFlowController flowController) {
    return Container(
      padding: const EdgeInsets.all(24.0),
      color: Colors.white,
      child: _buildNavigationButtons(context, controller, flowController),
    );
  }

  // Lógica del botón Siguiente
  void _onNextButtonPressed(BuildContext context,
      TransporteController controller, GuideFlowController flowController) {
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
