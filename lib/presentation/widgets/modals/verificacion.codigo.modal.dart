import 'package:flutter/material.dart';
import 'package:app_guias/core/constants/app.colors.dart';
import 'package:app_guias/presentation/widgets/custom.modal.dart';

class VerificacionCodigoModal extends StatefulWidget {
  const VerificacionCodigoModal({super.key});

  static Future<String?> show(BuildContext context) {
    return showDialog<String>(
      context: context,
      builder: (context) => const VerificacionCodigoModal(),
    );
  }

  @override
  State<VerificacionCodigoModal> createState() =>
      _VerificacionCodigoModalState();
}

class _VerificacionCodigoModalState extends State<VerificacionCodigoModal> {
  final List<TextEditingController> _controllers =
      List.generate(4, (_) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(4, (_) => FocusNode());

  @override
  void initState() {
    super.initState();
    // Enfocar el primer campo al inicio
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FocusScope.of(context).requestFocus(_focusNodes[0]);
    });

    // Añadir listeners para mover el foco automáticamente
    for (int i = 0; i < 4; i++) {
      _controllers[i].addListener(() {
        if (_controllers[i].text.length == 1 && i < 3) {
          FocusScope.of(context).requestFocus(_focusNodes[i + 1]);
        }
        // Podríamos añadir lógica para mover atrás al borrar, si se desea
      });
    }
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  String get codigoIngresado {
    return _controllers.map((c) => c.text).join();
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width > 600;
    final textFieldWidth = isDesktop ? 50.0 : 40.0;
    final spacing = isDesktop ? 16.0 : 8.0;

    return CustomModal(
      title: 'Ya casi terminamos...',
      message: 'Ingrese el código de 4 dígitos que se envió',
      content: SizedBox(
        // Ajustar altura si es necesario
        height: isDesktop ? 80 : 70,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center, // Centrar los campos
          children: List.generate(
            4,
            (index) => Padding(
              padding: EdgeInsets.symmetric(horizontal: spacing / 2),
              child: SizedBox(
                width: textFieldWidth,
                child: TextField(
                  controller: _controllers[index],
                  focusNode: _focusNodes[index],
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                  maxLength: 1,
                  style: TextStyle(fontSize: isDesktop ? 20 : 16),
                  decoration: InputDecoration(
                    counterText: '',
                    filled: true,
                    fillColor: AppColors.grey.withOpacity(0.1),
                    contentPadding: EdgeInsets.symmetric(
                        vertical:
                            isDesktop ? 15 : 10), // Ajustar padding vertical
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  // Mover foco al siguiente campo
                  onChanged: (value) {
                    if (value.length == 1 && index < 3) {
                      _focusNodes[index + 1].requestFocus();
                    } else if (value.isEmpty && index > 0) {
                      _focusNodes[index - 1].requestFocus();
                    }
                  },
                ),
              ),
            ),
          ),
        ),
      ),
      primaryButtonText: 'Aceptar',
      onPrimaryButtonPressed: () {
        final codigo = codigoIngresado;
        if (codigo.length == 4) {
          Navigator.pop(context, codigo); // Devolver el código
        }
        // Podríamos mostrar un mensaje si el código no está completo
      },
    );
  }
}
