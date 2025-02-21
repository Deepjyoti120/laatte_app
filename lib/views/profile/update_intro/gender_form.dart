import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/svg.dart';
import 'package:laatte/ui/theme/container.dart';
import 'package:laatte/utils/extensions.dart';
import 'package:provider/provider.dart';
import '../../../ui/theme/text.dart';
import '../../../utils/assets_names.dart';
import '../../../utils/design_colors.dart';
import '../../../viewmodel/cubit/app_cubit.dart';

class GenderForm extends StatelessWidget {
  const GenderForm({super.key, required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    final appState = context.watch<AppStateCubit>();
    return Column(
      children: [
        30.height,
        Column(
          children: [
            const DesignText(
              "What’s your biological sex?",
              fontSize: 24,
              fontWeight: 600,
            ),
            6.height,
            const DesignText(
              "We support all forms of gender expression.\nHowever, we need this to calculate your body metrics.",
              fontSize: 12,
              fontWeight: 600,
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
              Text((appState.introProfile?.currentPage ?? 'd').toString()),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () {
                      // appState.updateIntroProfilePage = "Male"; //#9CD322
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
                                appState.introProfile?.gender == "Male"
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
                          appState.introProfile?.gender = "Female";
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
                                appState.introProfile?.gender == "Female"
                                    ? DesignColor.inActive
                                    : DesignColor.primary,
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
                        appState.introProfile?.gender = "Other";
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
                              appState.introProfile?.gender == "Other"
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
