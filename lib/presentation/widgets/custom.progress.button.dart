import 'package:flutter/material.dart';
import 'package:app_guias/core/constants/app.colors.dart';

enum OptionStatus { none, completed, inProgress }

class CustomProgressButton extends StatelessWidget {
  final String text;
  final IconData? icon;
  final VoidCallback? onTap;
  final bool showArrow;
  final OptionStatus status;
  final double? progressValue;
  final bool enabled;

  const CustomProgressButton({
    required this.text,
    required this.onTap,
    this.icon,
    this.showArrow = true,
    this.status = OptionStatus.none,
    this.progressValue,
    this.enabled = true,
    super.key,
  });

  Widget _buildStatusIndicator() {
    switch (status) {
      case OptionStatus.completed:
        return Container(
          width: 30,
          height: 30,
          alignment: Alignment.center,
          child: const Icon(
            Icons.check_circle,
            color: Colors.white,
            size: 24,
          ),
        );
      case OptionStatus.inProgress:
        return Container(
          width: 30,
          height: 30,
          alignment: Alignment.center,
          child: Stack(
            alignment: Alignment.center,
            children: [
              CircularProgressIndicator(
                value: progressValue,
                valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
                strokeWidth: 2,
              ),
              if (progressValue != null)
                Text(
                  '${(progressValue! * 100).toInt()}%',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
            ],
          ),
        );
      case OptionStatus.none:
        return Container(
          width: 30,
          height: 30,
          alignment: Alignment.center,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: enabled ? AppColors.primary : AppColors.primary.withOpacity(0.5),
      borderRadius: BorderRadius.circular(8),
      child: InkWell(
        onTap: enabled ? onTap : null,
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildStatusIndicator(),
              const SizedBox(width: 12),
              if (icon != null) ...[
                Icon(icon!,
                    color: enabled
                        ? AppColors.white
                        : AppColors.white.withOpacity(0.5),
                    size: 20),
                const SizedBox(width: 12),
              ],
              Expanded(
                child: Text(
                  text,
                  style: TextStyle(
                    color: enabled
                        ? AppColors.white
                        : AppColors.white.withOpacity(0.5),
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              if (showArrow)
                Icon(
                  Icons.arrow_forward_ios,
                  color: enabled
                      ? AppColors.white
                      : AppColors.white.withOpacity(0.5),
                  size: 16,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
