import 'package:flutter/material.dart';
import 'package:app_guias/presentation/widgets/custom.modal.dart';

class ProcesandoModal extends StatelessWidget {
  final String title;
  final String message;

  const ProcesandoModal({
    super.key,
    required this.title,
    required this.message,
  });

  static Future<void> show(
    BuildContext context, {
    required String title,
    required String message,
  }) {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) => PopScope(
        canPop: false,
        child: ProcesandoModal(
          title: title,
          message: message,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomModal(
      title: title,
      message: message,
      content: const Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 16),
          Center(child: CircularProgressIndicator()),
          SizedBox(height: 16),
        ],
      ),
      // Sin botones para evitar que el usuario cierre el modal
      primaryButtonText: null,
      secondaryButtonText: null,
    );
  }
}
