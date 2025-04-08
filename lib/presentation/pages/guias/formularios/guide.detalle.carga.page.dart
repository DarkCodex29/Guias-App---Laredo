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
    final controller = flowController.detalleCargaController;

    return Consumer<GuideFlowController>(
      builder: (context, flowController, _) {
        final progress =
            flowController.getStepCompletionPercentage(GuideStep.detalleCarga);
        final isCompleted =
            flowController.isStepCompleted(GuideStep.detalleCarga);

        return ChangeNotifierProvider.value(
          value: controller,
          child: Builder(
            builder: (context) {
              final controller = Provider.of<DetalleCargaController>(context);
              final products = controller.detalleCargas;

              return Scaffold(
                appBar: AppBar(
                  title: const Text('Detalle de Carga',
                      style: TextStyle(color: AppColors.white)),
                  backgroundColor: AppColors.primary,
                  leading: IconButton(
                    icon: const Icon(Icons.arrow_back),
                    color: AppColors.white,
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
                body: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                  'Peso total: ${controller.formatearPesoTotal()}',
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold)),
                            ],
                          ),
                          Expanded(
                            child: ListView.builder(
                              itemCount: products.length,
                              itemBuilder: (context, index) {
                                final product = products[index];
                                return CustomCard(
                                  title: product.producto,
                                  subtitleWidgets: [
                                    Row(
                                      children: [
                                        const Icon(Icons.scale,
                                            size: 14, color: Colors.grey),
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
                                        const Icon(Icons.landscape,
                                            size: 14, color: Colors.grey),
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
                                        const Icon(Icons.straight,
                                            size: 14, color: Colors.grey),
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
                                        const Icon(Icons.grid_on,
                                            size: 14, color: Colors.grey),
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
                                        const Icon(Icons.local_florist,
                                            size: 14, color: Colors.grey),
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
                                        const Icon(Icons.calendar_today,
                                            size: 14, color: Colors.grey),
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
                                      icon: const Icon(Icons.more_vert,
                                          color: Colors.grey),
                                      onSelected: (value) async {
                                        if (value == 'edit') {
                                          flowController
                                              .modalDetalleCargaController
                                              .editDetalleCarga(product, index);
                                          ModalDetalleCarga.show(
                                            context,
                                            onDetalleAgregado: () {
                                              controller.loadDetalleCargas();
                                            },
                                            controller: flowController
                                                .modalDetalleCargaController,
                                            isEditing: true,
                                          );
                                        } else if (value == 'delete') {
                                          await controller.deleteDetalle(
                                              context, index);
                                        }
                                      },
                                      itemBuilder: (BuildContext context) => [
                                        const PopupMenuItem(
                                          value: 'edit',
                                          child: Row(
                                            children: [
                                              Icon(Icons.edit,
                                                  color: Colors.blue, size: 20),
                                              SizedBox(width: 8),
                                              Text('Editar'),
                                            ],
                                          ),
                                        ),
                                        const PopupMenuItem(
                                          value: 'delete',
                                          child: Row(
                                            children: [
                                              Icon(Icons.delete,
                                                  color: Colors.red, size: 20),
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
                            ),
                          ),
                          const SizedBox(height: 16),
                          CustomButton(
                            text: 'Siguiente',
                            progress: progress.toDouble(),
                            isCompleted: isCompleted,
                            onPressed: () {
                              if (products.isNotEmpty) {
                                final nextStep =
                                    flowController.getNextIncompleteStep();
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
                                      builder: (context) =>
                                          ChangeNotifierProvider.value(
                                        value: flowController,
                                        child: page,
                                      ),
                                    ),
                                  );
                                }
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                        'Debe agregar al menos un detalle de carga'),
                                    backgroundColor: Colors.red,
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
                    Positioned(
                      bottom: MediaQuery.of(context).size.height * 0.18,
                      left: MediaQuery.of(context).size.width * 0.72,
                      right: 0,
                      child: Center(
                        child: FloatingActionButton(
                          onPressed: () {
                            ModalDetalleCarga.show(
                              context,
                              onDetalleAgregado: () {
                                controller.loadDetalleCargas();
                              },
                              controller:
                                  flowController.modalDetalleCargaController,
                            );
                          },
                          backgroundColor: AppColors.primary,
                          child: const Icon(Icons.add, color: AppColors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}
