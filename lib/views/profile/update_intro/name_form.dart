import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:laatte/ui/theme/text_style.dart';
import 'package:laatte/utils/extensions.dart';
import 'package:laatte/viewmodel/cubit/intro_profile_cubit.dart';
import 'package:provider/provider.dart';
import '../../../ui/custom/custom_text_form.dart';
import '../../../ui/theme/text.dart';
import '../../../utils/design_colors.dart';

class NameForm extends StatelessWidget {
  const NameForm({super.key});
  @override
  Widget build(BuildContext context) {
    final appState = context.watch<IntroProfileCubit>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        30.height,
        Column(
          children: [
            const DesignText.title(
              "What’s your name?",
              textAlign: TextAlign.center,
              color: DesignColor.latteyellowDark3,
              fontSize: 24,
            ),
            6.height,
            const DesignText.body(
              "Please enter your name to continue.",
              fontSize: 18,
              textAlign: TextAlign.center,
              color: DesignColor.latteyellowDark3,
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
          child: DesignFormField(
            controller: appState.name,
            labelText: "Name",
            fillColor: DesignColor.latteBackground,
            // autofocus: true,
            prefixIcon: const Icon(
              FontAwesomeIcons.circleUser,
              color: DesignColor.grey400,
            ),
            contentPadding: const EdgeInsets.symmetric(vertical: 16),
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
        ),
      ],
    );
  }
}
