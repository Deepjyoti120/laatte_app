import 'package:flutter/material.dart';
import 'package:laatte/ui/theme/text.dart';
import 'package:laatte/utils/design_colors.dart';
import 'package:laatte/viewmodel/model/prompt.dart';

class RelateCard extends StatelessWidget {
  const RelateCard({super.key, required this.prompt});
  final Prompt prompt;
  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: DesignColor.white,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(),
                DesignText.title(
                  (prompt.prompt ?? ""),
                ),
                const Spacer(),
                Wrap(
                  children: (prompt.tags ?? [])
                      .map(
                        (tag) => Padding(
                          padding: const EdgeInsets.fromLTRB(4, 0, 4, 0),
                          child: Chip(
                            padding: const EdgeInsets.all(4.0),
                            label: DesignText.body(tag),
                          ),
                        ),
                      )
                      .toList(),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
