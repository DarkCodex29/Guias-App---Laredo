import 'package:app_guias/core/constants/app.colors.dart';
import 'package:app_guias/presentation/controllers/guide/guide.flow.controller.dart';
import 'package:app_guias/presentation/controllers/guide/forms/guide.detalle.carga.controller.dart';
import 'package:app_guias/presentation/pages/guias/widgets/modal.detalle.carga.dart';
import 'package:app_guias/presentation/pages/guias/formularios/guide.partida.page.dart';
import 'package:app_guias/presentation/pages/guias/formularios/guide.llegada.page.dart';
import 'package:app_guias/presentation/pages/guias/formularios/guide.destinatario.page.dart';
import 'package:app_guias/presentation/pages/guias/formularios/guide.transporte.page.dart';
import 'package:app_guias/presentation/pages/guias/formularios/guide.transportista.page.dart';
import 'package:app_guias/presentation/pages/guias/formularios/guide.motivo.traslado.page.dart';
import 'package:app_guias/presentation/pages/guias/formularios/guide.uso.interno.page.dart';
import 'package:app_guias/presentation/widgets/custom.button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app_guias/presentation/widgets/custom.card.dart';
import 'package:intl/intl.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final flowController = context.watch<GuideFlowController>();
    final size = MediaQuery.of(context).size;
    final isDesktop = size.width > 600;

    return Scaffold(
      appBar: _buildAppBar(context),
      body: isDesktop
          ? _buildDesktopLayout(context, flowController)
          : _buildMobileLayout(context, flowController),
      floatingActionButton: isDesktop
          ? null
          : _buildFloatingActionButton(context, flowController),
      bottomNavigationBar:
          isDesktop ? null : _buildMobileBottomAppBar(context, flowController),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      title: const Text('Detalle de Carga',
          style: TextStyle(color: AppColors.white)),
      backgroundColor: AppColors.primary,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        color: AppColors.white,
        onPressed: () => Navigator.pop(context),
      ),
    );
  }

  Widget _buildMobileLayout(
      BuildContext context, GuideFlowController flowController) {
    final controller = flowController.detalleCargaController;
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(24.0, 24.0, 24.0, 150.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildPesoTotal(context, controller),
              const SizedBox(height: 16),
              Expanded(
                child: _buildProductList(context, controller, flowController),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDesktopLayout(
      BuildContext context, GuideFlowController flowController) {
    final controller = flowController.detalleCargaController;
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildPesoTotal(context, controller),
                const SizedBox(height: 16),
                Expanded(
                  child: _buildProductList(context, controller, flowController),
                ),
                const SizedBox(height: 24),
                _buildNavigationButtons(context, flowController, controller),
              ],
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Container(
            color: Colors.grey[100],
            child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: _buildSidebar(context, flowController, controller),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPesoTotal(
      BuildContext context, DetalleCargaController controller) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text('Peso total: ${controller.formatearPesoTotal()}',
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget _buildProductList(BuildContext context,
      DetalleCargaController controller, GuideFlowController flowController) {
    final products = controller.detalleCargas;

    if (products.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.inventory_2_outlined, size: 64, color: Colors.grey),
            SizedBox(height: 16),
            Text('No hay detalles de carga agregados',
                style: TextStyle(fontSize: 16, color: Colors.grey)),
          ],
        ),
      );
    }

    return ListView.builder(
      itemCount: products.length,
      itemBuilder: (context, index) {
        final product = products[index];
        return CustomCard(
          title: product.producto,
          subtitleWidgets: [
            Row(
              children: [
                const Icon(Icons.scale, size: 14, color: Colors.grey),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    'Cantidad: ${product.cantidad} ${product.unidadMedida == 'KG' ? 'KGM' : (product.unidadMedida == 'TM' ? 'TNE' : product.unidadMedida)}',
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                const Icon(Icons.landscape, size: 14, color: Colors.grey),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    'Campo: ${product.campo}',
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                const Icon(Icons.straight, size: 14, color: Colors.grey),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    'Jirón: ${product.jiron}',
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                const Icon(Icons.grid_on, size: 14, color: Colors.grey),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    'Cuartel: ${product.cuartel}',
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                const Icon(Icons.local_florist, size: 14, color: Colors.grey),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    'Variedad: ${product.variedad}',
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                const Icon(Icons.calendar_today, size: 14, color: Colors.grey),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    'Fecha: ${DateFormat('dd-MM-yyyy').format(product.fechaCorte)}',
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
          ],
          trailing: [
            PopupMenuButton<String>(
              color: AppColors.white,
              icon: const Icon(Icons.more_vert, color: Colors.grey),
              onSelected: (value) async {
                if (value == 'edit') {
                  flowController.modalDetalleCargaController
                      .editDetalleCarga(product, index);
                  ModalDetalleCarga.show(
                    context,
                    onDetalleAgregado: () {
                      controller.loadDetalleCargas();
                    },
                    controller: flowController.modalDetalleCargaController,
                    isEditing: true,
                  );
                } else if (value == 'delete') {
                  await controller.deleteDetalle(context, index);
                }
              },
              itemBuilder: (BuildContext context) => [
                const PopupMenuItem(
                  value: 'edit',
                  child: Row(
                    children: [
                      Icon(Icons.edit, color: Colors.blue, size: 20),
                      SizedBox(width: 8),
                      Text('Editar'),
                    ],
                  ),
                ),
                const PopupMenuItem(
                  value: 'delete',
                  child: Row(
                    children: [
                      Icon(Icons.delete, color: Colors.red, size: 20),
                      SizedBox(width: 8),
                      Text('Eliminar'),
                    ],
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  Widget _buildSidebar(BuildContext context, GuideFlowController flowController,
      DetalleCargaController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Detalle de la Carga',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: AppColors.primary,
          ),
        ),
        const SizedBox(height: 24),
        const Text(
          'Agregue cada uno de los productos o bienes que forman parte de la carga a trasladar.',
          style: TextStyle(fontSize: 15, color: Colors.black87, height: 1.4),
        ),
        const SizedBox(height: 24),
        const Divider(thickness: 1),
        const SizedBox(height: 24),
        CustomButton(
          text: 'Agregar Detalle',
          onPressed: () {
            flowController.modalDetalleCargaController.clear();
            ModalDetalleCarga.show(
              context,
              onDetalleAgregado: () {
                controller.loadDetalleCargas();
              },
              controller: flowController.modalDetalleCargaController,
            );
          },
        ),
      ],
    );
  }

  Widget _buildNavigationButtons(BuildContext context,
      GuideFlowController flowController, DetalleCargaController controller) {
    final progress =
        flowController.getStepCompletionPercentage(GuideStep.detalleCarga);
    final isCompleted = flowController.isStepCompleted(GuideStep.detalleCarga);
    final products = controller.detalleCargas;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        CustomButton(
          text: 'Siguiente',
          progress: progress.toDouble(),
          isCompleted: isCompleted,
          onPressed: () =>
              _onNextButtonPressed(context, flowController, products),
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

  Widget _buildFloatingActionButton(
      BuildContext context, GuideFlowController flowController) {
    final controller = flowController.detalleCargaController;
    return FloatingActionButton(
      onPressed: () {
        flowController.modalDetalleCargaController.clear();
        ModalDetalleCarga.show(
          context,
          onDetalleAgregado: () {
            controller.loadDetalleCargas();
          },
          controller: flowController.modalDetalleCargaController,
        );
      },
      backgroundColor: AppColors.primary,
      child: const Icon(Icons.add, color: AppColors.white),
    );
  }

  Widget _buildMobileBottomAppBar(
      BuildContext context, GuideFlowController flowController) {
    final controller = flowController.detalleCargaController;
    final progress =
        flowController.getStepCompletionPercentage(GuideStep.detalleCarga);
    final isCompleted = flowController.isStepCompleted(GuideStep.detalleCarga);
    final products = controller.detalleCargas;

    return BottomAppBar(
      color: Colors.white,
      elevation: 8.0,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
        child: Row(
          children: [
            Expanded(
              child: CustomButton(
                text: 'Regresar',
                onPressed: () => Navigator.pop(context),
                isOutlined: true,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: CustomButton(
                text: 'Siguiente',
                progress: progress.toDouble(),
                isCompleted: isCompleted,
                onPressed: () =>
                    _onNextButtonPressed(context, flowController, products),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onNextButtonPressed(
      BuildContext context, GuideFlowController flowController, List products) {
    if (products.isNotEmpty) {
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
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Debe agregar al menos un detalle de carga'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}
