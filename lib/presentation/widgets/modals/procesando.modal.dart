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
    final isDesktop = MediaQuery.of(context).size.width > 600;
    final maxWidth = isDesktop ? 400.0 : double.infinity;

    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxWidth),
        child: CustomModal(
          title: title,
          message: message,
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: isDesktop ? 24 : 16),
              Center(
                child: SizedBox(
                  width: isDesktop ? 48 : 36,
                  height: isDesktop ? 48 : 36,
                  child: const CircularProgressIndicator(
                      // Podríamos ajustar strokeWidth si quisiéramos
                      // strokeWidth: isDesktop ? 4.0 : 3.0,
                      ),
                ),
              ),
              SizedBox(height: isDesktop ? 24 : 16),
            ],
          ),
          // Sin botones para evitar que el usuario cierre el modal
          primaryButtonText: null,
          secondaryButtonText: null,
        ),
      ),
    );
  }
}
