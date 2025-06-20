import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:laatte/ui/theme/text.dart';
import 'package:laatte/utils/extensions.dart';

class BlurBtn extends StatelessWidget {
  final String? title;
  final VoidCallback? onTap;
  final IconData? icon;
  final Color? colorText;
  final BorderRadiusGeometry? borderRadius;
  final EdgeInsetsGeometry? padding;

  const BlurBtn({
    super.key,
    this.title,
    this.onTap,
    this.icon,
    this.colorText,
    this.borderRadius,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              borderRadius: borderRadius ?? BorderRadius.circular(12),
              border: Border.all(
                color: Colors.white.withOpacity(0.2),
              ),
            ),
            child: Padding(
              padding: padding ?? const EdgeInsets.fromLTRB(8, 2, 8, 2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (title != null)
                    DesignText.titleSemi(
                      title ?? '',
                      color: colorText ?? Colors.white,
                    ),
                  if (icon != null && title != null) 8.width,
                  if (icon != null)
                    Icon(
                      icon ?? Icons.arrow_forward,
                      color: Colors.white,
                      size: 16,
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
