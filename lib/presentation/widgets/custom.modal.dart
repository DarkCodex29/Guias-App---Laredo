import 'package:app_guias/core/constants/app.colors.dart';
import 'package:app_guias/presentation/widgets/custom.button.dart';
import 'package:flutter/material.dart';

class CustomModal extends StatelessWidget {
  final String title;
  final String? message;
  final String? primaryButtonText;
  final String? secondaryButtonText;
  final VoidCallback? onPrimaryButtonPressed;
  final VoidCallback? onSecondaryButtonPressed;
  final Widget? content;
  final bool showCloseIcon;
  final double? width;

  const CustomModal({
    required this.title,
    this.message,
    this.primaryButtonText,
    this.secondaryButtonText,
    this.onPrimaryButtonPressed,
    this.onSecondaryButtonPressed,
    this.content,
    this.showCloseIcon = false,
    this.width,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final double maxHeight = MediaQuery.of(context).size.height * 0.8;

    return Dialog(
      backgroundColor: AppColors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ConstrainedBox(
        constraints: BoxConstraints(maxHeight: maxHeight),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (showCloseIcon)
                Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    icon: const Icon(Icons.close, color: AppColors.greyText),
                    onPressed: () => Navigator.pop(context),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                ),
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.black,
                ),
              ),
              if (message != null) ...[
                const SizedBox(height: 10),
                Text(
                  message!,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 14,
                    color: AppColors.greyText,
                  ),
                ),
              ],
              if (content != null) ...[
                const SizedBox(height: 12),
                Flexible(
                  child: SingleChildScrollView(
                    child: content!,
                  ),
                ),
              ],
              const SizedBox(height: 16),
              Row(
                children: [
                  if (secondaryButtonText != null)
                    Expanded(
                      child: CustomButton(
                        text: secondaryButtonText!,
                        onPressed: onSecondaryButtonPressed ??
                            () => Navigator.pop(context),
                        isOutlined: true,
                      ),
                    ),
                  if (primaryButtonText != null && secondaryButtonText != null)
                    const SizedBox(width: 8),
                  if (primaryButtonText != null)
                    Expanded(
                      child: CustomButton(
                        text: primaryButtonText!,
                        onPressed: onPrimaryButtonPressed ??
                            () => Navigator.pop(context),
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
