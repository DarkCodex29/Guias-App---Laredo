import 'package:flutter/material.dart';
import 'package:app_guias/presentation/widgets/custom.modal.dart';

class ResultadoModal extends StatelessWidget {
  final String title;
  final String message;
  final bool isSuccess;
  final String? detailText;
  final List<Widget>? details;
  final String buttonText;
  final VoidCallback? onButtonPressed;

  const ResultadoModal({
    super.key,
    required this.title,
    required this.message,
    required this.isSuccess,
    this.detailText,
    this.details,
    this.buttonText = 'ACEPTAR',
    this.onButtonPressed,
  });

  static Future<void> showSuccess(
    BuildContext context, {
    required String title,
    required String message,
    String? detailText,
    List<Widget>? details,
    String buttonText = 'Aceptar',
    VoidCallback? onButtonPressed,
  }) {
    return showDialog<void>(
      context: context,
      builder: (dialogContext) => ResultadoModal(
        title: title,
        message: message,
        isSuccess: true,
        detailText: detailText,
        details: details,
        buttonText: buttonText,
        onButtonPressed: onButtonPressed ?? () => Navigator.pop(dialogContext),
      ),
    );
  }

  static Future<void> showError(
    BuildContext context, {
    required String title,
    required String message,
    String? detailText,
    List<Widget>? details,
    String buttonText = 'Cerrar',
    VoidCallback? onButtonPressed,
  }) {
    return showDialog<void>(
      context: context,
      builder: (dialogContext) => ResultadoModal(
        title: title,
        message: message,
        isSuccess: false,
        detailText: detailText,
        details: details,
        buttonText: buttonText,
        onButtonPressed: onButtonPressed ?? () => Navigator.pop(dialogContext),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomModal(
      title: title,
      message: message,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Icon(
              isSuccess ? Icons.check_circle : Icons.error_outline,
              color: isSuccess ? Colors.green : Colors.red,
              size: 48,
            ),
          ),
          const SizedBox(height: 16),
          if (detailText != null) ...[
            Text(
              detailText!,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
          ],
          if (details != null) ...details!,
        ],
      ),
      primaryButtonText: buttonText,
      onPrimaryButtonPressed: onButtonPressed,
    );
  }
}
