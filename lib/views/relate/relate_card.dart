import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:laatte/ui/theme/text.dart';
import 'package:laatte/viewmodel/model/prompt.dart';

class RelateCard extends StatelessWidget {
  const RelateCard({super.key, required this.prompt});
  final Prompt prompt;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.network(
            prompt.bgPicture!,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
        ),
        Positioned.fill(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: DesignText(
                prompt.prompt ?? "",
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
