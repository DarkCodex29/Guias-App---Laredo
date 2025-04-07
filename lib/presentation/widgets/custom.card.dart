import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  final String title;
  final Widget? titleWidget;
  final String? subtitle;
  final List<Widget>? subtitleWidgets;
  final List<Widget>? trailing;
  final VoidCallback? onTap;
  final Color? backgroundColor;
  final Color? titleColor;
  final EdgeInsets? contentPadding;
  final double? elevation;

  const CustomCard({
    required this.title,
    this.titleWidget,
    this.subtitle,
    this.subtitleWidgets,
    this.trailing,
    this.onTap,
    this.backgroundColor,
    this.titleColor,
    this.contentPadding,
    this.elevation,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: elevation ?? 1,
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      color: backgroundColor ?? Colors.white,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: ListTile(
          contentPadding: contentPadding ??
              const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 4,
              ),
          title: titleWidget ??
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: titleColor ?? Colors.black,
                ),
              ),
          subtitle: subtitle != null
              ? Text(
                  subtitle!,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                  ),
                )
              : subtitleWidgets != null
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: subtitleWidgets!,
                    )
                  : null,
          trailing: trailing != null
              ? Row(
                  mainAxisSize: MainAxisSize.min,
                  children: trailing!,
                )
              : null,
        ),
      ),
    );
  }
}
