import 'package:flutter/material.dart';
import '../../../../core/constants/app.colors.dart';
import '../../../widgets/custom.modal.dart';

class VerificationCodeModal extends StatefulWidget {
  final Function(String) onSubmit;

  const VerificationCodeModal({
    super.key,
    required this.onSubmit,
  });

  static Future<void> show(
    BuildContext context, {
    required Function(String) onSubmit,
  }) {
    return showDialog(
      context: context,
      builder: (context) => VerificationCodeModal(onSubmit: onSubmit),
    );
  }

  @override
  State<VerificationCodeModal> createState() => _VerificationCodeModalState();
}

class _VerificationCodeModalState extends State<VerificationCodeModal> {
  final List<TextEditingController> _controllers =
      List.generate(4, (_) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(4, (_) => FocusNode());

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

  void _onCodeComplete() {
    final code = _controllers.map((c) => c.text).join();
    if (code.length == 4) {
      widget.onSubmit(code);
      Navigator.pop(context);
    }
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
            (index) => SizedBox(
              width: 40,
              child: TextField(
                controller: _controllers[index],
                focusNode: _focusNodes[index],
                textAlign: TextAlign.center,
                keyboardType: TextInputType.number,
                maxLength: 1,
                onChanged: (value) {
                  if (value.isNotEmpty && index < 3) {
                    _focusNodes[index + 1].requestFocus();
                  }
                  if (_controllers.every((c) => c.text.isNotEmpty)) {
                    _onCodeComplete();
                  }
                },
                decoration: const InputDecoration(
                  counterText: '',
                  filled: true,
                  fillColor: AppColors.grey,
                ),
              ),
            ),
          ),
        ),
      ),
      primaryButtonText: 'Verificar',
      onPrimaryButtonPressed: _onCodeComplete,
    );
  }
}
