import 'dart:ui';
import 'package:laatte/common_libs.dart';
import 'package:laatte/ui/blur_button.dart';
import 'package:laatte/ui/theme/text.dart';
import 'package:laatte/utils/design_colors.dart';
import 'package:laatte/utils/extensions.dart';

class SelectIrl extends StatefulWidget {
  const SelectIrl({super.key});

  @override
  State<SelectIrl> createState() => _SelectIrlState();
}

class _SelectIrlState extends State<SelectIrl> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: () {
            context.pop();
          },
          child: Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.7),
                  borderRadius: BorderRadius.circular(60)),
              child: Container(
                alignment: Alignment.center,
                child: const Icon(Icons.close, color: Colors.white),
              )),
        ),
        const SizedBox(height: 12),
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: Colors.white.withOpacity(0.2),
                ),
              ),
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
                          "Relate",
                          textAlign: TextAlign.center,
                          color: DesignColor.primary,
                        ),
                        const SizedBox(height: 10),
                        10.height,
                        SizedBox(
                          height: 48,
                          child: BlurBtn(
                            title: "Sent",
                            onTap: () {},
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
      ],
    );
  }
}
