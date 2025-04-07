import 'package:app_guias/presentation/controllers/guide/forms/widgets/modal.detalle.carga.controller.dart';
import 'package:app_guias/presentation/widgets/custom.textfield.dart';
import 'package:app_guias/presentation/widgets/custom.modal.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:intl/intl.dart';
import 'package:app_guias/providers/campo.provider.dart';
import 'package:app_guias/providers/jiron.provider.dart';
import 'package:app_guias/providers/cuartel.provider.dart';

class ModalDetalleCarga extends StatelessWidget {
  const ModalDetalleCarga({super.key});

  static void show(
    BuildContext context, {
    required VoidCallback onDetalleAgregado,
    required ModalDetalleCargaController controller,
    bool isEditing = false,
  }) {
    if (!isEditing) {
      controller.clear();
    }

    final campoProvider = context.read<CampoProvider>();
    final jironProvider = context.read<JironProvider>();
    final cuartelProvider = context.read<CuartelProvider>();

    controller.setCampoProvider(campoProvider);
    controller.setJironProvider(jironProvider);
    controller.setCuartelProvider(cuartelProvider);

    showDialog(
      context: context,
      builder: (context) => ChangeNotifierProvider.value(
        value: controller,
        child: const _ModalDetalleCargaContent(),
      ),
    ).then((_) => onDetalleAgregado());
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ModalDetalleCargaController(),
      child: const _ModalDetalleCargaContent(),
    );
  }
}

class _ModalDetalleCargaContent extends StatelessWidget {
  const _ModalDetalleCargaContent();

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<ModalDetalleCargaController>();
    final double maxHeight = MediaQuery.of(context).size.height * 0.8;

    return StatefulBuilder(
      builder: (context, setState) {
        return CustomModal(
          title: controller.editingIndex == null
              ? 'Añadir bienes'
              : 'Editar bienes',
          content: SizedBox(
            height: maxHeight,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomTextField(
                      label: 'Producto',
                      hint: 'Seleccione el producto',
                      controller: controller.productoController,
                      keyboardType: TextInputType.text,
                      enableSuggestions: true,
                      suggestions: controller.productosSugeridos,
                      onSuggestionSelected: (suggestion) {
                        controller.productoController.text = suggestion;
                      },
                    ),
                    const SizedBox(height: 9),
                    Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: CustomTextField(
                            label: 'Cantidad',
                            hint: 'Ingrese la cantidad',
                            controller: controller.cantidadController,
                            keyboardType: TextInputType.number,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Expanded(
                          flex: 2,
                          child: CustomTextField(
                            label: 'UM',
                            hint: 'Seleccione UM',
                            controller: controller.unidadMedidaController,
                            enableSuggestions: true,
                            suggestions: const ['KG', 'TM'],
                            onSuggestionSelected: (suggestion) {
                              controller.unidadMedidaController.text =
                                  suggestion;
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    CustomTextField(
                      label: 'Campo',
                      hint: 'Ingrese el campo',
                      controller: controller.campoController,
                      keyboardType: TextInputType.text,
                      enableSuggestions: true,
                      maxSuggestionsHeight: 150,
                      suggestions: controller.camposSugeridos,
                      onSuggestionSelected: (suggestion) {
                        controller.campoController.text = suggestion;
                      },
                    ),
                    const SizedBox(height: 8),
                    CustomTextField(
                      label: 'Jirón',
                      hint: 'Ingrese el jirón',
                      controller: controller.jironController,
                      enabled: controller.isJironEnabled,
                      enableSuggestions: true,
                      suggestions: controller.jironesSugeridos,
                      onSuggestionSelected: (suggestion) {
                        controller.jironController.text = suggestion;
                      },
                      isLoading: controller.isLoadingJirones,
                    ),
                    const SizedBox(height: 8),
                    CustomTextField(
                      label: 'Cuartel',
                      hint: 'Ingrese el cuartel',
                      controller: controller.cuartelController,
                      enabled: controller.isCuartelEnabled,
                      enableSuggestions: true,
                      suggestions: controller.cuartelesSugeridos,
                      onSuggestionSelected: (suggestion) {
                        controller.cuartelController.text = suggestion;
                      },
                      isLoading: controller.isLoadingCuarteles,
                    ),
                    const SizedBox(height: 8),
                    CustomTextField(
                      label: 'Variedad',
                      hint: 'Ingrese la variedad',
                      controller: controller.variedadController,
                    ),
                    const SizedBox(height: 8),
                    CustomTextField(
                      label: 'Fecha de corte',
                      hint: 'Seleccionar fecha',
                      controller: controller.fechaController,
                      actionIcon: Icons.calendar_today,
                      onActionPressed: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (context) => SizedBox(
                            height: 350,
                            child: SfDateRangePicker(
                              selectionMode:
                                  DateRangePickerSelectionMode.single,
                              onSelectionChanged:
                                  (DateRangePickerSelectionChangedArgs args) {
                                if (args.value is DateTime) {
                                  setState(() {
                                    controller.fecha = args.value;
                                    controller.fechaController.text =
                                        DateFormat('dd-MM-yyyy')
                                            .format(controller.fecha!);
                                  });
                                  Navigator.pop(context);
                                }
                              },
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
          primaryButtonText:
              controller.editingIndex == null ? 'Guardar' : 'Actualizar',
          secondaryButtonText: 'Cancelar',
          onPrimaryButtonPressed: () async {
            bool success = await controller.saveDetalleCarga(context);
            if (success && context.mounted) {
              Navigator.pop(context);
            }
          },
        );
      },
    );
  }
}
