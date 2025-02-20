import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:laatte/utils/design_colors.dart';
import '../theme/buttons.dart';
import '../theme/text.dart';
import '../widgets/progress_circle.dart';

class ConformDialog extends StatefulWidget {
  const ConformDialog({
    Key? key,
    required this.title,
    required this.deleteText,
    required this.onTap,
  }) : super(key: key);
  final String title;
  final String deleteText;
  final Future<bool> Function() onTap;
  @override
  State<ConformDialog> createState() => ConformDialogState();
}

class ConformDialogState extends State<ConformDialog>
    with SingleTickerProviderStateMixin {
  AnimationController? controller;
  Animation<double>? scaleAnimation;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 450));
    scaleAnimation =
        CurvedAnimation(parent: controller!, curve: Curves.elasticInOut);

    controller!.addListener(() {
      setState(() {});
    });

    controller!.forward();
  }

  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
        scale: scaleAnimation!,
        child: AlertDialog(
          scrollable: true,
          contentPadding: EdgeInsets.zero,
          content: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30),
            child: Column(
              children: [
                // SvgPicture.asset(
                //   AssetsName.svgAstronautQuestion,
                //   height: 200,
                // ),
                const SizedBox(height: 10),
                const DesignText(
                  "Confirmation ?",
                  fontSize: 22,
                  // color: DesignColor.dszBlueDark,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 6),
                DesignText(
                  widget.title,
                  // color: DesignColor.dszTextFill2,
                  fontSize: 16,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 30),
                Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: DesignButtons(
                            color: DesignColor.primary,
                            elevation: 0,
                            fontSize: 16,
                            fontWeight: 500,
                            colorText: Colors.white,
                            isTappedNotifier: ValueNotifier<bool>(isLoading),
                            onPressed: () async {
                              setState(() => isLoading = true);
                              widget.onTap().then(
                                  (value) => Navigator.pop(context, value));
                            },
                            textLabel: widget.deleteText,
                            pdbottom: 16,
                            pdtop: 16,
                            child: isLoading
                                ? const DesignProgress(
                                    color: Colors.white,
                                    size: 18,
                                  )
                                : DesignText(
                                    widget.deleteText,
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: 700,
                                  ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        Expanded(
                          child: DesignButtons(
                            isTappedNotifier: ValueNotifier<bool>(false),
                            onPressed: () async {
                              Navigator.pop(context, false);
                            },
                            textLabel: "Cancel",
                            fontSize: 12,
                            fontWeight: 700,
                            elevation: 0,
                            pdbottom: 16,
                            color: Colors.transparent,
                            pdtop: 16,
                            borderSide: true,
                            // colorBorderSide: DesignColor.dszBlue,
                          ),
                        ),
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
        ));
  }
}
