import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/svg.dart';
import 'package:laatte/ui/theme/container.dart';
import 'package:laatte/utils/enums.dart';
import 'package:laatte/utils/extensions.dart';
import 'package:laatte/viewmodel/cubit/intro_profile_cubit.dart';
import 'package:provider/provider.dart';
import '../../../ui/theme/text.dart';
import '../../../utils/assets_names.dart';
import '../../../utils/design_colors.dart';

class GenderForm extends StatelessWidget {
  const GenderForm({super.key});
  @override
  Widget build(BuildContext context) {
    final appState = context.watch<IntroProfileCubit>();
    return Column(
      children: [
        30.height,
        Column(
          children: [
            const DesignText.title(
              "What’s your biological sex?",
              textAlign: TextAlign.center,
              color: DesignColor.primary,
              fontSize: 24,
            ),
            6.height,
            const DesignText.body(
              "We support all forms of gender expression.\nHowever, we need this to calculate your body metrics.",
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () {
                      appState.gender = GenderTypes.male; //#9CD322
                    },
                    child: Column(
                      children: [
                        DesignContainer(
                          height: 100,
                          width: 100,
                          borderRadius: BorderRadius.circular(15),
                          blurRadius: 20,
                          child: Padding(
                            padding: const EdgeInsets.all(22.0),
                            child: SvgPicture.asset(
                              AssetsName.svgGenderMale,
                              colorFilter: ColorFilter.mode(
                                appState.gender == GenderTypes.male
                                    ? DesignColor.primary
                                    : DesignColor.backgroundBlack,
                                BlendMode.srcIn,
                              ),
                            ),
                          ),
                        ),
                        8.height,
                        const DesignText(
                          "Male",
                          fontSize: 12,
                          fontWeight: 600,
                        )
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          appState.gender = GenderTypes.female;
                        },
                        child: DesignContainer(
                          height: 100,
                          width: 100,
                          blurRadius: 20,
                          borderRadius: BorderRadius.circular(15),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: SvgPicture.asset(
                              AssetsName.svgGenderFemale,
                              colorFilter: ColorFilter.mode(
                                appState.gender == GenderTypes.female
                                    ? DesignColor.primary
                                    : DesignColor.backgroundBlack,
                                BlendMode.srcIn,
                              ),
                            ),
                          ),
                        ),
                      ),
                      8.height,
                      const DesignText("Female", fontSize: 12, fontWeight: 600),
                    ],
                  ),
                ],
              ),
              10.height,
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        appState.gender = GenderTypes.other;
                      },
                      child: DesignContainer(
                        height: 100,
                        width: 100,
                        borderRadius: BorderRadius.circular(15),
                        blurRadius: 20,
                        child: Padding(
                          padding: const EdgeInsets.all(14.0),
                          child: SvgPicture.asset(
                            AssetsName.svgGenderIntersex,
                            colorFilter: ColorFilter.mode(
                              appState.gender == GenderTypes.other
                                  ? DesignColor.primary
                                  : DesignColor.backgroundBlack,
                              BlendMode.srcIn,
                            ),
                          ),
                        ),
                      ),
                    ),
                    8.height,
                    const DesignText("Other", fontSize: 12, fontWeight: 600),
                  ],
                ),
              ),
            ],
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
