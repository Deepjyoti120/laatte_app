import 'package:flutter/material.dart';
import 'package:laatte/ui/theme/text.dart';
import 'package:laatte/utils/design_colors.dart';
import 'package:laatte/utils/extensions.dart';
import 'package:laatte/viewmodel/model/prompt.dart';

class RelateCard extends StatelessWidget {
  const RelateCard({super.key, required this.prompt});
  final Prompt prompt;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: DesignColor.white,
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // const Spacer(),
            DesignText.titleSemi(
              (prompt.prompt ?? ""),
            ),
            6.height,
            const Spacer(),
            Wrap(
              children: (prompt.tags ?? [])
                  .map(
                    (tag) => Padding(
                      padding: const EdgeInsets.fromLTRB(2, 2, 2, 2),
                      child: Container(
                        padding: EdgeInsets.zero,
                        decoration: BoxDecoration(
                          color: DesignColor.grey400.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: DesignColor.grey400.withOpacity(0.2),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(3, 1, 3, 1),
                          child: DesignText.body(
                            tag,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}
