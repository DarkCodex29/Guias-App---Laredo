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

  static Future<void> showWarning(
    BuildContext context, {
    required String title,
    required String message,
    String? detailText,
    List<Widget>? details,
    String buttonText = 'Entendido',
    VoidCallback? onButtonPressed,
  }) {
    return showDialog<void>(
      context: context,
      builder: (dialogContext) => _WarningResultadoModal(
        title: title,
        message: message,
        detailText: detailText,
        details: details,
        buttonText: buttonText,
        onButtonPressed: onButtonPressed ?? () => Navigator.pop(dialogContext),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width > 600;
    final iconSize = isDesktop ? 60.0 : 48.0;
    final verticalPadding = isDesktop ? 24.0 : 16.0;
    final maxWidth = isDesktop ? 400.0 : double.infinity;

    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxWidth),
        child: CustomModal(
          title: title,
          message: message,
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Icon(
                  isSuccess ? Icons.check_circle_outline : Icons.error_outline,
                  color:
                      isSuccess ? Colors.green.shade600 : Colors.red.shade600,
                  size: iconSize,
                ),
              ),
              SizedBox(height: verticalPadding),
              if (detailText != null) ...[
                if (details == null)
                  Center(child: Text(detailText!, textAlign: TextAlign.center))
                else
                  Text(
                    detailText!,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                SizedBox(height: verticalPadding / 1.5),
              ],
              if (details != null) ...details!,
            ],
          ),
          primaryButtonText: buttonText,
          onPrimaryButtonPressed: onButtonPressed,
        ),
      ),
    );
  }
}

class _WarningResultadoModal extends StatelessWidget {
  final String title;
  final String message;
  final String? detailText;
  final List<Widget>? details;
  final String buttonText;
  final VoidCallback? onButtonPressed;

  const _WarningResultadoModal({
    required this.title,
    required this.message,
    this.detailText,
    this.details,
    this.buttonText = 'ENTENDIDO',
    this.onButtonPressed,
  });

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width > 600;
    final iconSize = isDesktop ? 60.0 : 48.0;
    final verticalPadding = isDesktop ? 24.0 : 16.0;
    final maxWidth = isDesktop ? 400.0 : double.infinity;

    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxWidth),
        child: CustomModal(
          title: title,
          message: message,
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Icon(
                  Icons.warning_amber_rounded,
                  color: Colors.orange.shade600,
                  size: iconSize,
                ),
              ),
              SizedBox(height: verticalPadding),
              if (detailText != null) ...[
                if (details == null)
                  Center(child: Text(detailText!, textAlign: TextAlign.center))
                else
                  Text(
                    detailText!,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                SizedBox(height: verticalPadding / 1.5),
              ],
              if (details != null) ...details!,
            ],
          ),
          primaryButtonText: buttonText,
          onPrimaryButtonPressed: onButtonPressed,
        ),
      ),
    );
  }
}
