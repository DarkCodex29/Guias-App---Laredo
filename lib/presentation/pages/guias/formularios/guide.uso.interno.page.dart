import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app_guias/core/constants/app.colors.dart';
import 'package:app_guias/presentation/controllers/guide/guide.flow.controller.dart';
import 'package:app_guias/presentation/controllers/guide/forms/guide.uso.interno.controller.dart';
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

  AppBar _buildAppBar(BuildContext context, UsoInternoController controller) {
    return AppBar(
      title:
          const Text('Uso Interno', style: TextStyle(color: AppColors.white)),
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
      UsoInternoController controller, GuideFlowController flowController) {
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
      UsoInternoController controller, GuideFlowController flowController) {
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
      BuildContext context, UsoInternoController controller) {
    final empleadoProvider = context.read<EmpleadoProvider>();
    final equipoProvider = context.read<EquipoProvider>();
    final transportistaProvider = context.read<TransportistaProvider>();

    return Column(
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
          maxLength: controller.requiereBusquedaManualCamion ? null : 6,
          keyboardType: TextInputType.number,
          errorText: controller.getError('codigoCamion'),
          onChanged: (value) => controller.validateField('codigoCamion', value),
          isLoading: controller.isLoadingCamion,
          actionIcon:
              controller.requiereBusquedaManualCamion ? Icons.search : null,
          onActionPressed: controller.requiereBusquedaManualCamion
              ? () {
                  if (controller.codigoCamion.text.isNotEmpty) {
                    controller.buscarCamionYTransportista(
                      controller.codigoCamion.text,
                      equipoProvider,
                      transportistaProvider,
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Ingrese un código de camión'),
                        backgroundColor: Colors.orange,
                      ),
                    );
                  }
                }
              : null,
        ),
        _buildCamionMessage(controller),
        const SizedBox(height: 16),
        CustomTextField(
          label: 'Código de chofer de camión',
          hint: 'Ingrese el código de chofer de camión',
          controller: controller.codigoChoferCamion,
          type: TextFieldType.number,
          errorText: controller.getError('codigoChoferCamion'),
          isLoading: controller.isLoadingChoferCamion,
          actionIcon: Icons.search,
          onActionPressed: () {
            if (controller.codigoChoferCamion.text.isNotEmpty) {
              controller.verificarChofer(
                controller.codigoChoferCamion.text,
                empleadoProvider,
                'camion',
                transportistaProvider: transportistaProvider,
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Ingrese un código de chofer'),
                  backgroundColor: Colors.orange,
                ),
              );
            }
          },
        ),
        _buildChoferCamionMessage(controller),
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
                equipoProvider,
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Ingrese un código de carreta'),
                  backgroundColor: Colors.orange,
                ),
              );
            }
          },
        ),
        _buildCarretaMessage(controller),
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
                equipoProvider,
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Ingrese un código de alzadora/cosechadora'),
                  backgroundColor: Colors.orange,
                ),
              );
            }
          },
        ),
        _buildAlzadoraMessage(controller),
        const SizedBox(height: 16),
        CustomTextField(
          label: 'Código de operador',
          hint: 'Ingrese el código de operador',
          controller: controller.codigoOperador,
          type: TextFieldType.number,
          errorText: controller.getError('codigoOperador'),
          isLoading: controller.isLoadingChoferAlzadora,
          actionIcon: Icons.search,
          onActionPressed: () {
            if (controller.codigoOperador.text.isNotEmpty) {
              controller.verificarChofer(
                controller.codigoOperador.text,
                empleadoProvider,
                'alzadora',
                transportistaProvider: transportistaProvider,
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Ingrese un código de operador'),
                  backgroundColor: Colors.orange,
                ),
              );
            }
          },
        ),
        _buildOperadorMessage(controller),
        const SizedBox(height: 16),
        CustomTextField(
          label: 'Código de transportista de corte',
          hint: 'Ingrese el código de transportista de corte',
          controller: controller.codigoCortero,
          type: TextFieldType.number,
          errorText: controller.getError('codigoCortero'),
          isLoading: controller.isLoadingCortero,
          actionIcon: Icons.search,
          onActionPressed: () {
            if (controller.codigoCortero.text.isNotEmpty) {
              controller.buscarTransportistaCortero(
                controller.codigoCortero.text,
                transportistaProvider,
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Ingrese un código de transportista de corte'),
                  backgroundColor: Colors.orange,
                ),
              );
            }
          },
        ),
        _buildCorteroMessage(controller),
      ],
    );
  }

  // --- Métodos para construir mensajes --- //

  Widget _buildCamionMessage(UsoInternoController controller) {
    if (controller.isLoadingCamion) return const SizedBox.shrink();

    if (controller.errorMessageCamion != null) {
      return _buildMessageContainer(
        message: controller.errorMessageCamion!,
        isError: true,
      );
    }

    List<Widget> messages = [];
    if (controller.tieneEquipo) {
      messages.add(_buildMessageContainer(
        message: 'Tipo de equipo: ${controller.tipoEquipo}',
        isError: false,
      ));
    }
    if (!controller.tieneEquipo && controller.transportistaCamion != null) {
      messages.add(_buildMessageContainer(
        message:
            'Transportista: ${controller.transportistaCamion?.transportista}',
        isError: false,
      ));
    }

    if (messages.isEmpty) return const SizedBox.shrink();
    return Column(children: messages);
  }

  Widget _buildChoferCamionMessage(UsoInternoController controller) {
    if (controller.isLoadingChoferCamion) return const SizedBox.shrink();

    if (controller.errorMessageChoferCamion != null) {
      return _buildMessageContainer(
        message: controller.errorMessageChoferCamion!,
        isError: true,
      );
    } else if (controller.nombreChoferCamion != null) {
      final label = controller.esTrasladoPublico ? 'Transportista' : 'Empleado';
      return _buildMessageContainer(
        message: '$label: ${controller.nombreChoferCamion}',
        isError: false,
      );
    }
    return const SizedBox.shrink();
  }

  Widget _buildCarretaMessage(UsoInternoController controller) {
    if (controller.isLoadingCarreta) return const SizedBox.shrink();

    if (controller.errorMessageCarreta != null) {
      return _buildMessageContainer(
        message: controller.errorMessageCarreta!,
        isError: true,
      );
    } else if (controller.tipoCarreta != null) {
      return _buildMessageContainer(
        message: 'Tipo de equipo: ${controller.tipoCarreta}',
        isError: false,
      );
    }
    return const SizedBox.shrink();
  }

  Widget _buildAlzadoraMessage(UsoInternoController controller) {
    if (controller.isLoadingAlzadora) return const SizedBox.shrink();

    if (controller.errorMessageAlzadora != null) {
      return _buildMessageContainer(
        message: controller.errorMessageAlzadora!,
        isError: true,
      );
    } else if (controller.tipoAlzadora != null) {
      return _buildMessageContainer(
        message: 'Tipo de equipo: ${controller.tipoAlzadora}',
        isError: false,
      );
    }
    return const SizedBox.shrink();
  }

  Widget _buildOperadorMessage(UsoInternoController controller) {
    if (controller.isLoadingChoferAlzadora) return const SizedBox.shrink();

    if (controller.errorMessageChoferAlzadora != null) {
      return _buildMessageContainer(
        message: controller.errorMessageChoferAlzadora!,
        isError: true,
      );
    } else if (controller.nombreChoferAlzadora != null) {
      final label = controller.esTrasladoPublico ? 'Transportista' : 'Empleado';
      return _buildMessageContainer(
        message: '$label: ${controller.nombreChoferAlzadora}',
        isError: false,
      );
    }
    return const SizedBox.shrink();
  }

  Widget _buildCorteroMessage(UsoInternoController controller) {
    if (controller.isLoadingCortero) return const SizedBox.shrink();

    if (controller.errorMessageCortero != null) {
      return _buildMessageContainer(
        message: controller.errorMessageCortero!,
        isError: true,
      );
    } else if (controller.transportistaCortero != null) {
      return _buildMessageContainer(
        message:
            'Transportista: ${controller.transportistaCortero?.transportista}',
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

  // --- Fin Métodos para construir mensajes --- //

  // Sidebar para escritorio
  Widget _buildSidebar() {
    // El contenido del sidebar puede ser extenso, considerar usar SingleChildScrollView si es necesario
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            'Datos de Uso Interno',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: AppColors.primary,
            ),
          ),
          SizedBox(height: 24),
          Text(
            'Completa los códigos internos relacionados con la operación logística.',
            style: TextStyle(fontSize: 15, color: Colors.black87, height: 1.4),
          ),
          SizedBox(height: 24),
          Divider(thickness: 1),
          SizedBox(height: 24),
          Text(
            'Detalles de Campos:',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          SizedBox(height: 16),
          Text(
            '• N° de liberación: Número de documento interno.\n\n'
            '• Código de camión: Código del vehículo principal. Si no se encontró automáticamente, puedes buscarlo manualmente.\n\n'
            '• Código de chofer de camión: Código del conductor del camión. Presiona buscar (🔍) para verificar.\n\n'
            '• Código de carreta: Código del remolque o carreta. Presiona buscar (🔍).\n\n'
            '• Código de alzadora/cosechadora: Código del equipo de carga/cosecha. Presiona buscar (🔍).\n\n'
            '• Código de operador: Código del operador de la alzadora/cosechadora. Presiona buscar (🔍).\n\n'
            '• Código de transportista de corte: Código de la empresa encargada del corte (si aplica). Presiona buscar (🔍).',
            style: TextStyle(fontSize: 14, height: 1.6),
          ),
          SizedBox(height: 24),
          Text(
            'Nota: Los campos de búsqueda (🔍) validarán la información ingresada y mostrarán el resultado debajo.',
            style: TextStyle(
                fontSize: 13,
                fontStyle: FontStyle.italic,
                color: Colors.black54),
          ),
        ],
      ),
    );
  }

  // Botones de navegación
  Widget _buildNavigationButtons(BuildContext context,
      UsoInternoController controller, GuideFlowController flowController) {
    final progress =
        flowController.getStepCompletionPercentage(GuideStep.usoInterno);
    final isCompleted = flowController.isStepCompleted(GuideStep.usoInterno);
    // Determinar si es el último paso *disponible*
    final availableSteps = GuideStep.values
        .where((s) => flowController.isStepAvailable(s))
        .toList();
    final currentIndex = availableSteps.indexOf(GuideStep.usoInterno);
    final isLastAvailableStep = currentIndex == availableSteps.length - 1;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        CustomButton(
          // Usar isLastAvailableStep en lugar de isLastStep
          text: isLastAvailableStep ? 'Finalizar' : 'Siguiente',
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
      UsoInternoController controller, GuideFlowController flowController) {
    return Container(
      padding: const EdgeInsets.all(24.0),
      color: Colors.white,
      child: _buildNavigationButtons(context, controller, flowController),
    );
  }

  // Lógica del botón Siguiente/Finalizar
  void _onNextButtonPressed(BuildContext context,
      UsoInternoController controller, GuideFlowController flowController) {
    if (!controller.isFormValid()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Por favor, complete todos los campos requeridos'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // Determinar si es el último paso *disponible*
    final availableSteps = GuideStep.values
        .where((s) => flowController.isStepAvailable(s))
        .toList();
    final currentIndex = availableSteps.indexOf(GuideStep.usoInterno);
    final isLastAvailableStep = currentIndex == availableSteps.length - 1;

    if (isLastAvailableStep) {
      // Usar isLastAvailableStep
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Guía completada (simulación)'),
          backgroundColor: Colors.green,
        ),
      );
      Navigator.of(context).popUntil((route) => route.isFirst);
    } else {
      // Esto no debería ejecutarse si la lógica es correcta,
      // pero lo dejamos por seguridad.
      final nextStep = flowController.getNextIncompleteStep();
      if (nextStep != null) {
        // Ir al siguiente paso (aunque teóricamente no debería haber uno)
        flowController.goToStep(nextStep);
        print(
            "Advertencia: Se navegó al paso $nextStep después de Uso Interno, revisar lógica.");
      } else {
        print(
            "Error: No se encontró el siguiente paso, aunque isLastAvailableStep era falso.");
      }
    }
  }
}
