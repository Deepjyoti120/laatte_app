import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:laatte/utils/extensions.dart';
import 'package:laatte/viewmodel/cubit/intro_profile_cubit.dart';
import 'package:provider/provider.dart';
import '../../../ui/custom/custom_text_form.dart';
import '../../../ui/theme/text.dart';
import '../../../utils/design_colors.dart';

class OthersForm extends StatelessWidget {
  const OthersForm({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = context.watch<IntroProfileCubit>();
    return Column(
      children: [
        30.height,
        Column(
          children: [
            const DesignText.title(
              "Other information",
              textAlign: TextAlign.center,
              color: DesignColor.primary,
              fontSize: 24,
            ),
            6.height,
            const DesignText.body(
              "Tell us more about yourself",
              fontSize: 18,
              textAlign: TextAlign.center,
            ),
          ],
        )
            .animate()
            .fadeIn(
              duration: const Duration(milliseconds: 600),
              curve: Curves.easeIn,
              delay: const Duration(milliseconds: 500),
            )
            .slideX(
              duration: const Duration(seconds: 2),
              curve: Curves.fastLinearToSlowEaseIn,
              begin: 2,
            ),
        20.height,
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              DesignFormField(
                controller: appState.occupation,
                labelText: "Occupation",
                autofocus: true,
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
              )
                  .animate()
                  .fadeIn(
                    duration: const Duration(milliseconds: 1000),
                    curve: Curves.easeIn,
                    delay: const Duration(milliseconds: 800),
                  )
                  .slideY(
                    duration: const Duration(seconds: 2),
                    curve: Curves.fastLinearToSlowEaseIn,
                    begin: 2,
                  ),
              16.height,
              DesignFormField(
                controller: appState.education,
                labelText: "Education",
                autofocus: true,
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
              )
                  .animate()
                  .fadeIn(
                    duration: const Duration(milliseconds: 1000),
                    curve: Curves.easeIn,
                    delay: const Duration(milliseconds: 800),
                  )
                  .slideY(
                    duration: const Duration(seconds: 2),
                    curve: Curves.fastLinearToSlowEaseIn,
                    begin: 2,
                  ),
            ],
          ),
        ),
      ],
    );
  }
}
