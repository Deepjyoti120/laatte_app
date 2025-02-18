import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:laatte/ui/theme/text.dart';
import 'package:laatte/utils/extensions.dart';
import 'package:lottie/lottie.dart';
import '../../utils/design_colors.dart';

class SplashContent extends StatelessWidget {
  final String text, title;
  final String? json;
  final String? image;
  final bool isAnimate;
  const SplashContent({
    Key? key,
    required this.text,
    required this.title,
    this.image,
    this.json,
    this.isAnimate = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final orientation =
    //     MediaQuery.of(context).orientation == Orientation.landscape;
    return Column(
      children: [
        const Spacer(),
        image != null
            ? Image.asset(
                image!,
                fit: BoxFit.fill,
              )
            : LottieBuilder.asset(
                json!,
                fit: BoxFit.fill,
              ),
        const Spacer(),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              DesignText.title(
                title,
                textAlign: TextAlign.center,
                color: DesignColor.success600,
              )
                  .animate()
                  .fadeIn(
                    duration: Duration(milliseconds: isAnimate ? 300 : 0),
                    curve: Curves.easeIn,
                    delay: Duration(milliseconds: isAnimate ? 200 : 0),
                  )
                  .slideX(
                    duration: Duration(seconds: isAnimate ? 1 : 0),
                    curve: Curves.fastLinearToSlowEaseIn,
                    begin: isAnimate ? 2 : 0,
                  ),
              4.height,
              DesignText.body(
                text,
                textAlign: TextAlign.center,
              )
                  .animate()
                  .fadeIn(
                    duration: Duration(milliseconds: isAnimate ? 500 : 0),
                    curve: Curves.easeIn,
                    delay: Duration(milliseconds: isAnimate ? 400 : 0),
                  )
                  .slideX(
                    duration: Duration(seconds: isAnimate ? 1 : 0),
                    curve: Curves.fastLinearToSlowEaseIn,
                    begin: isAnimate ? 2 : 0,
                  ),
            ],
          ),
        ),
      ],
    );
  }
}
