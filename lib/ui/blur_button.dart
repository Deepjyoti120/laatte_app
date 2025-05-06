import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:laatte/ui/theme/text.dart';
import 'package:laatte/utils/extensions.dart';

class BlurBtn extends StatelessWidget {
  const BlurBtn({super.key, required this.title, this.onTap, this.icon});
  // add title and onTap
  final String title;
  final VoidCallback? onTap;
  final IconData? icon;

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
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: Colors.white.withOpacity(0.2),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(8, 2, 8, 2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  DesignText.titleSemi(
                    title,
                    color: Colors.white,
                  ),
                  if (icon != null) 8.width,
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
