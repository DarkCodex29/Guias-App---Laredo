import 'package:flutter/material.dart';
import 'package:app_guias/presentation/widgets/custom.modal.dart';

class ConfirmacionModal extends StatelessWidget {
  final String title;
  final String message;
  final String? primaryButtonText;
  final String? secondaryButtonText;
  final VoidCallback? onConfirm;
  final VoidCallback? onCancel;
  final bool dismissible;

  const ConfirmacionModal({
    super.key,
    required this.title,
    required this.message,
    this.primaryButtonText,
    this.secondaryButtonText,
    this.onConfirm,
    this.onCancel,
    this.dismissible = true,
  });

  static Future<bool?> show(
    BuildContext context, {
    required String title,
    required String message,
    String? primaryButtonText,
    String? secondaryButtonText,
    VoidCallback? onConfirm,
    VoidCallback? onCancel,
    bool dismissible = true,
  }) {
    return showDialog<bool>(
      context: context,
      barrierDismissible: dismissible,
      builder: (dialogContext) => ConfirmacionModal(
        title: title,
        message: message,
        primaryButtonText: primaryButtonText,
        secondaryButtonText: secondaryButtonText,
        onConfirm: onConfirm,
        onCancel: onCancel,
        dismissible: dismissible,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width > 600;
    final maxWidth = isDesktop ? 400.0 : double.infinity;

    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxWidth),
        child: CustomModal(
          title: title,
          message: message,
          primaryButtonText: primaryButtonText,
          secondaryButtonText: secondaryButtonText,
          onPrimaryButtonPressed: primaryButtonText != null
              ? () {
                  if (context.mounted) {
                    onConfirm?.call();
                    Navigator.pop(context, true);
                  }
                }
              : null,
          onSecondaryButtonPressed: secondaryButtonText != null
              ? () {
                  if (context.mounted) {
                    onCancel?.call();
                    Navigator.pop(context, false);
                  }
                }
              : null,
        ),
      ),
    );
  }
}
