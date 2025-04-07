import 'package:app_guias/core/constants/app.colors.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isOutlined;
  final Color? backgroundColor;
  final Color? textColor;
  final double? width;
  final double? height;
  final double? borderRadius;
  final Widget? child;
  final double? progress;
  final bool isCompleted;
  final bool isLoading;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isOutlined = false,
    this.backgroundColor,
    this.textColor,
    this.width,
    this.height,
    this.borderRadius,
    this.child,
    this.progress,
    this.isCompleted = false,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? double.infinity,
      height: height ?? 48,
      child: Stack(
        children: [
          ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: isOutlined
                  ? Colors.white
                  : (backgroundColor ?? AppColors.primary),
              foregroundColor:
                  isOutlined ? AppColors.primary : (textColor ?? Colors.white),
              side: isOutlined
                  ? const BorderSide(color: AppColors.primary)
                  : null,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(borderRadius ?? 8),
              ),
              minimumSize: Size(width ?? double.infinity, height ?? 48),
            ),
            child: child ??
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (isLoading)
                      const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      )
                    else
                      Flexible(
                        child: Text(
                          text,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: isOutlined
                                ? AppColors.primary
                                : (textColor ?? Colors.white),
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                  ],
                ),
          ),
          if (progress != null && progress! > 0 && progress! < 100)
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: LinearProgressIndicator(
                value: progress! / 100,
                backgroundColor: Colors.transparent,
                color: Colors.white.withOpacity(0.5),
                minHeight: 3,
              ),
            ),
        ],
      ),
    );
  }
}
