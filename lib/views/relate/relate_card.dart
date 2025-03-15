import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:laatte/ui/theme/text.dart';
import 'package:laatte/utils/design_colors.dart';
import 'package:laatte/viewmodel/model/prompt.dart';

class RelateCard extends StatelessWidget {
  const RelateCard({super.key, required this.prompt});
  final Prompt prompt;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: DesignColor.white,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: DesignText(
            prompt.prompt ?? "",
          ),
        ),
      ],
    );
  }
}
