import 'dart:async';
import 'package:flutter/material.dart';

import 'digital_clock/clock_model.dart';
import 'digital_clock/colon_helper.dart';
import 'digital_clock/spinner_text.dart';

class DigitalClock extends StatefulWidget {
  const DigitalClock({
    super.key,
    this.is24HourTimeFormat,
    this.showSecondsDigit,
    this.colon,
    this.colonDecoration,
    this.areaWidth,
    this.areaHeight,
    this.areaDecoration,
    this.areaAligment,
    this.hourDigitDecoration,
    this.minuteDigitDecoration,
    this.secondDigitDecoration,
    this.digitAnimationStyle,
    this.hourMinuteDigitTextStyle,
    this.secondDigitTextStyle,
    this.amPmDigitTextStyle,
  });

  /// am or pm
  final bool? is24HourTimeFormat;

  /// if you want use seconds this variable should be true
  final bool? showSecondsDigit;

  /// use ":"  or create your widget
  final Widget? colon;
  // colon area decoraiton
  final BoxDecoration? colonDecoration;

  /// clock area width
  final double? areaWidth;

  ///clock area height
  final double? areaHeight;

  /// clock area decoration
  final BoxDecoration? areaDecoration;

  final AlignmentDirectional? areaAligment;

  /// hour decoration
  final BoxDecoration? hourDigitDecoration;

  /// minute decoration
  final BoxDecoration? minuteDigitDecoration;

  /// seconds decoration
  final BoxDecoration? secondDigitDecoration;

  /// animation style
  final Curve? digitAnimationStyle;

  /// hour text style
  final TextStyle? hourMinuteDigitTextStyle;

  /// seconds text style,
  final TextStyle? secondDigitTextStyle;

  /// am-pm text style
  final TextStyle? amPmDigitTextStyle;

  @override
  State<DigitalClock> createState() => _DigitalClockState();
}

class _DigitalClockState extends State<DigitalClock> {
  late DateTime _dateTime;
  late ClockModel _clockModel;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _dateTime = DateTime.now();
    _clockModel = ClockModel();
    _clockModel.is24HourFormat = widget.is24HourTimeFormat ?? true;

    _dateTime = DateTime.now();
    _clockModel.hour = _dateTime.hour;
    _clockModel.minute = _dateTime.minute;
    _clockModel.second = _dateTime.second;

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _dateTime = DateTime.now();
      _clockModel.hour = _dateTime.hour;
      _clockModel.minute = _dateTime.minute;
      _clockModel.second = _dateTime.second;

      setState(() {});
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: SizedBox(
        width: widget.areaWidth,
        height: widget.areaHeight,
        child: Container(
          alignment: widget.areaAligment ?? AlignmentDirectional.bottomCenter,
          decoration: widget.areaDecoration,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              _hour(),
              Container(
                alignment: AlignmentDirectional.center,
                margin: const EdgeInsets.all(1.0),
                padding: const EdgeInsets.all(2.0),
                decoration: widget.colonDecoration,
                child: ColonWidget(
                  colon: widget.colon,
                ),
              ),
              _minute,
              _second,
              _amPm,
            ],
          ),
        ),
      ),
    );
  }

  Widget _hour() => Container(
        padding: const EdgeInsets.all(2),
        alignment: AlignmentDirectional.center,
        decoration: widget.hourDigitDecoration,
        child: SpinnerText(
          text: _clockModel.is24HourTimeFormat
              ? hTOhh_24hTrue(_clockModel.hour)
              : hTOhh_24hFalse(_clockModel.hour)[0],
          animationStyle: widget.digitAnimationStyle,
          textStyle: widget.hourMinuteDigitTextStyle ??
              Theme.of(context).textTheme.bodyLarge,
        ),
      );

  Widget get _minute => Container(
        padding: const EdgeInsets.all(2),
        alignment: AlignmentDirectional.center,
        decoration: widget.minuteDigitDecoration,
        child: SpinnerText(
          text: mTOmm(_clockModel.minute),
          animationStyle: widget.digitAnimationStyle,
          textStyle: widget.hourMinuteDigitTextStyle ??
              Theme.of(context).textTheme.titleSmall,
        ),
      );

  Widget get _second => widget.showSecondsDigit != false
      ? Container(
          margin: const EdgeInsets.all(1),
          padding: const EdgeInsets.all(2),
          alignment: AlignmentDirectional.center,
          decoration: widget.secondDigitDecoration,
          child: SpinnerText(
              text: sTOss(_clockModel.second),
              animationStyle: widget.digitAnimationStyle,
              textStyle: widget.secondDigitTextStyle ??
                  Theme.of(context)
                      .textTheme
                      .titleSmall
                      ?.copyWith(fontSize: 10)),
        )
      : const SizedBox();

  Widget get _amPm => _clockModel.is24HourTimeFormat
      ? const SizedBox()
      : Container(
          padding: const EdgeInsets.all(2),
          alignment: AlignmentDirectional.center,
          child: Text(
            " " + hTOhh_24hFalse(_clockModel.hour)[1],
            style: widget.amPmDigitTextStyle ??
                Theme.of(context)
                    .textTheme
                    .titleSmall!
                    .copyWith(fontSize: 10, fontWeight: FontWeight.bold),
          ),
        );
}
