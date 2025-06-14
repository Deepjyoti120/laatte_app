import 'dart:ui';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:laatte/common_libs.dart';
import 'package:laatte/ui/blur_button.dart';
import 'package:laatte/ui/blur_container.dart';
import 'package:laatte/ui/theme/text.dart';
import 'package:laatte/utils/assets_names.dart';
import 'package:laatte/utils/design_colors.dart';
import 'package:laatte/utils/enums.dart';
import 'package:laatte/utils/extensions.dart';
import 'package:laatte/viewmodel/bloc/user_report_bloc.dart';

class FilterDialog extends StatefulWidget {
  const FilterDialog({
    Key? key,
  }) : super(key: key);
  @override
  State<FilterDialog> createState() => _FilterDialogState();
}

class _FilterDialogState extends State<FilterDialog> {
  bool isLoading = false;
  RangeValues _filterAges = const RangeValues(21, 35);
  GenderTypes _genderType = GenderTypes.male;
  double _radius = 10;

  @override
  void initState() {
    super.initState();
    runInit();
  }

  runInit() async {
    final user =  context.read<UserReportBloc>().state.userReport;
    // _radius = user.r.toDouble();
  }

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
                        6.height,
                        const DesignText.title(
                          "Filters",
                          textAlign: TextAlign.center,
                          color: DesignColor.primary,
                        ),
                        16.height,
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
                                    thumbColor: Colors.white,
                                    overlayShape: const RoundSliderOverlayShape(
                                      overlayRadius: 16,
                                    ),
                                    activeTrackColor: DesignColor.primary,
                                  ),
                                  child: RangeSlider(
                                    values: _filterAges,
                                    min: 21,
                                    max: 50,
                                    inactiveColor:
                                        Colors.white.withOpacity(0.4),
                                    labels: RangeLabels(
                                      _filterAges.start.round().toString(),
                                      _filterAges.end.round().toString(),
                                    ),
                                    onChanged: (RangeValues values) {
                                      setState(() {
                                        _filterAges = values;
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
                                    value: _radius,
                                    max: 150,
                                    activeColor: DesignColor.primary,
                                    inactiveColor:
                                        Colors.white.withOpacity(0.4),
                                    thumbColor: Colors.white,
                                    label: _radius.round().toString(),
                                    onChanged: (double value) {
                                      setState(() {
                                        _radius = value;
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        16.height,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              children: [
                                BlurContainer(
                                  onTap: () {
                                    setState(() {
                                      _genderType = GenderTypes.male;
                                    });
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: SvgPicture.asset(
                                      AssetsName.svgGenderMale,
                                      width: 24,
                                      colorFilter: ColorFilter.mode(
                                        _genderType == GenderTypes.male
                                            ? Colors.white
                                            : Colors.white.withOpacity(0.4),
                                        BlendMode.srcIn,
                                      ),
                                    ),
                                  ),
                                ),
                                2.height,
                                DesignText(
                                  "Male",
                                  fontSize: 12,
                                  fontWeight: 600,
                                  color: _genderType == GenderTypes.male
                                      ? Colors.white
                                      : Colors.white.withOpacity(0.4),
                                )
                              ],
                            ),
                            Column(
                              children: [
                                BlurContainer(
                                    onTap: () {
                                      setState(() {
                                        _genderType = GenderTypes.female;
                                      });
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: SvgPicture.asset(
                                        AssetsName.svgGenderFemale,
                                        width: 24,
                                        colorFilter: ColorFilter.mode(
                                          _genderType == GenderTypes.female
                                              ? Colors.white
                                              : Colors.white.withOpacity(0.4),
                                          BlendMode.srcIn,
                                        ),
                                      ),
                                    )),
                                2.height,
                                DesignText(
                                  "Female",
                                  fontSize: 12,
                                  fontWeight: 600,
                                  color: _genderType == GenderTypes.female
                                      ? Colors.white
                                      : Colors.white.withOpacity(0.4),
                                )
                              ],
                            ),
                            Column(
                              children: [
                                BlurContainer(
                                    onTap: () {
                                      setState(() {
                                        _genderType = GenderTypes.other;
                                      });
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: SvgPicture.asset(
                                        AssetsName.svgGenderIntersex,
                                        width: 24,
                                        colorFilter: ColorFilter.mode(
                                          _genderType == GenderTypes.other
                                              ? Colors.white
                                              : Colors.white.withOpacity(0.4),
                                          BlendMode.srcIn,
                                        ),
                                      ),
                                    )),
                                2.height,
                                DesignText(
                                  "Other",
                                  fontSize: 12,
                                  fontWeight: 600,
                                  color: _genderType == GenderTypes.other
                                      ? Colors.white
                                      : Colors.white.withOpacity(0.4),
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
                              _filterAges.start.round();
                              _filterAges.end.round();
                              context.pop();
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  20.height,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
