import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../ui/theme/text.dart';
import '../../utils/design_colors.dart';
import '../../utils/utlis.dart';
import 'digital_clock.dart';

class ShowTodayCard extends StatefulWidget {
  const ShowTodayCard({
    super.key,
  });

  @override
  State<ShowTodayCard> createState() => _ShowTodayCardState();
}

class _ShowTodayCardState extends State<ShowTodayCard> {
  String showToday = "";

  @override
  void initState() {
    super.initState();
    setToday();
  }

  Future setToday() async {
    showToday = await Utils.getTodayString();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6),
          child: DesignText(
            showToday,
            fontSize: 14,
            fontWeight: 500,
            color: DesignColor.textBlack1,
          ),
        ).animate().fadeIn(duration: 600.ms),
        DigitalClock(
          areaAligment: AlignmentDirectional.centerEnd,
          is24HourTimeFormat: false,
          showSecondsDigit: false,
          amPmDigitTextStyle: const TextStyle(color: DesignColor.textBlack1),
          hourMinuteDigitTextStyle: Theme.of(context)
              .textTheme
              .titleMedium!
              .copyWith(color: DesignColor.textBlack1),
          secondDigitTextStyle: Theme.of(context)
              .textTheme
              .bodySmall!
              .copyWith(color: DesignColor.textBlack1),
          colon: Text(
            ":",
            style: Theme.of(context)
                .textTheme
                .titleSmall!
                .copyWith(color: DesignColor.textBlack1),
          ),
        )
      ],
    );
  }
}
