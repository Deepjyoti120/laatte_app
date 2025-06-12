import 'dart:ui';
import 'package:flutter_svg/svg.dart';
import 'package:laatte/common_libs.dart';
import 'package:laatte/ui/blur_button.dart';
import 'package:laatte/ui/blur_container.dart';
import 'package:laatte/ui/theme/text.dart';
import 'package:laatte/utils/assets_names.dart';
import 'package:laatte/utils/design_colors.dart';
import 'package:laatte/utils/extensions.dart';

class FilterDialog extends StatefulWidget {
  const FilterDialog({
    Key? key,
  }) : super(key: key);
  @override
  State<FilterDialog> createState() => _FilterDialogState();
}

class _FilterDialogState extends State<FilterDialog> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: Colors.white.withOpacity(0.4),
              ),
            ),
            child: IntrinsicHeight(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(30, 14, 30, 14),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const DesignText.title(
                          "Filters",
                          textAlign: TextAlign.center,
                          color: DesignColor.primary,
                        ),
                        16.height,
                        // age, gender, Radius,
                        BlurContainer(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                const DesignText.body(
                                  "Age",
                                  color: Colors.white,
                                ),
                                SliderTheme(
                                  data: SliderTheme.of(context).copyWith(
                                    trackHeight: 2,
                                    overlayShape: const RoundSliderOverlayShape(
                                      overlayRadius: 16,
                                    ),
                                  ),
                                  child: Slider(
                                    value: 1,
                                    max: 100,
                                    activeColor: DesignColor.primary,
                                    inactiveColor:
                                        Colors.white.withOpacity(0.4),
                                    thumbColor: Colors.white,
                                    // divisions: 5,
                                    label: "_currentDiscreteSliderValue"
                                        .toString(),
                                    onChanged: (double value) {
                                      setState(() {
                                        // _currentDiscreteSliderValue = value;
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        10.height,
                        BlurContainer(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                const DesignText.body(
                                  "Radius",
                                  color: Colors.white,
                                ),
                                SliderTheme(
                                  data: SliderTheme.of(context).copyWith(
                                    trackHeight: 2,
                                    overlayShape: const RoundSliderOverlayShape(
                                      overlayRadius: 16,
                                    ),
                                  ),
                                  child: Slider(
                                    value: 1,
                                    max: 100,
                                    activeColor: DesignColor.primary,
                                    inactiveColor:
                                        Colors.white.withOpacity(0.4),
                                    thumbColor: Colors.white,
                                    // divisions: 5,
                                    label: "_currentDiscreteSliderValue"
                                        .toString(),
                                    onChanged: (double value) {
                                      setState(() {
                                        // _currentDiscreteSliderValue = value;
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        10.height,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              children: [
                                BlurContainer(
                                    child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: SvgPicture.asset(
                                    AssetsName.svgGenderMale,
                                    width: 24,
                                    colorFilter: ColorFilter.mode(
                                      // appState.gender == GenderTypes.male
                                      //     ? DesignColor.primary
                                      // :
                                      Colors.white,
                                      BlendMode.srcIn,
                                    ),
                                  ),
                                )),
                                2.height,
                                const DesignText(
                                  "Male",
                                  fontSize: 12,
                                  fontWeight: 600,
                                  color: Colors.white,
                                )
                              ],
                            ),
                            Column(
                              children: [
                                BlurContainer(
                                    child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: SvgPicture.asset(
                                    AssetsName.svgGenderFemale,
                                    width: 24,
                                    colorFilter: ColorFilter.mode(
                                      // appState.gender == GenderTypes.male
                                      //     ? DesignColor.primary
                                      // :
                                      Colors.white,
                                      BlendMode.srcIn,
                                    ),
                                  ),
                                )),
                                2.height,
                                const DesignText(
                                  "Female",
                                  fontSize: 12,
                                  fontWeight: 600,
                                  color: Colors.white,
                                )
                              ],
                            ),
                            Column(
                              children: [
                                BlurContainer(
                                    child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: SvgPicture.asset(
                                    AssetsName.svgGenderIntersex,
                                    width: 24,
                                    colorFilter: ColorFilter.mode(
                                      // appState.gender == GenderTypes.male
                                      //     ? DesignColor.primary
                                      // :
                                      Colors.white.withOpacity(0.4),
                                      BlendMode.srcIn,
                                    ),
                                  ),
                                )),
                                2.height,
                                DesignText(
                                  "Other",
                                  fontSize: 12,
                                  fontWeight: 600,
                                  color: Colors.white.withOpacity(0.4),
                                )
                              ],
                            ),
                          ],
                        ),
                        16.height,
                        SizedBox(
                          height: 48,
                          child: BlurBtn(
                            title: "Apply",
                            onTap: () {
                              context.pop();
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  10.height,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
