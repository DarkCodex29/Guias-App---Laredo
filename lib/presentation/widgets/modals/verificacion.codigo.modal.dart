import 'package:flutter/material.dart';
import 'package:app_guias/core/constants/app.colors.dart';
import 'package:app_guias/presentation/widgets/custom.modal.dart';

class VerificacionCodigoModal extends StatelessWidget {
  const VerificacionCodigoModal({super.key});

  static Future<void> show(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) => const VerificacionCodigoModal(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomModal(
      title: 'Ya casi terminamos...',
      message: 'Ingrese el código de 4 dígitos que se envió',
      content: SizedBox(
        height: 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(
            4,
            (index) => const SizedBox(
              width: 40,
              child: TextField(
                textAlign: TextAlign.center,
                keyboardType: TextInputType.number,
                maxLength: 1,
                decoration: InputDecoration(
                  counterText: '',
                  filled: true,
                  fillColor: AppColors.grey,
                ),
              ),
            ),
          ),
        ),
      ),
      primaryButtonText: 'Aceptar',
    );
  }
}
