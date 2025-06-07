import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:intl/intl.dart';
import 'package:laatte/ui/theme/container.dart';
import 'package:laatte/utils/extensions.dart';
import 'package:laatte/viewmodel/cubit/intro_profile_cubit.dart';
import 'package:provider/provider.dart';
import '../../../ui/theme/text.dart';
import '../../../utils/design_colors.dart';

class SelectDob extends StatelessWidget {
  const SelectDob({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = context.watch<IntroProfileCubit>();
    return Column(
      children: [
        30.height,
        Column(
          children: [
            const DesignText.title(
              "When is your date of birth?",
              textAlign: TextAlign.center,
              color: DesignColor.latteyellowDark3,
              fontSize: 24,
            ),
            6.height,
            const DesignText.body(
              "We need your date of birth to calculate your body metrics.",
              fontSize: 18,
              color: DesignColor.latteyellowDark3,
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
        GestureDetector(
          onTap: () async {
            DateTime? pickedDate = await showDatePicker(
              context: context,
              initialDate: appState.dateOfBirth,
              firstDate: DateTime(1900),
              lastDate: DateTime.now(),
            );
            if (pickedDate != null) {
              appState.dateOfBirth = pickedDate;
            }
          },
          child: DesignContainer(
            height: 60,
            width: 250,
            borderRadius: BorderRadius.circular(15),
            blurRadius: 1,
            child: Center(
              child: DesignText(
                appState.dateOfBirth != null
                    ? DateFormat('d MMM, y').format(appState.dateOfBirth!)
                    : "Select Date of Birth",
                fontSize: 18,
                fontWeight: 600,
                color: DesignColor.latteyellowDark3,
              ),
            ),
          ),
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
    );
  }
}
