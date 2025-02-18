import 'package:laatte/common_libs.dart';
import 'package:laatte/ui/controls/app_icons.dart';
import 'package:laatte/ui/controls/circle_buttons.dart';
import 'package:laatte/utils/design_colors.dart';
import 'package:laatte/utils/extensions.dart';
import 'package:laatte/views/home/welcome_screen.dart';

class AppHeader extends StatelessWidget {
  const AppHeader(
      {super.key,
      this.title,
      this.subtitle,
      this.showBackBtn = true,
      this.isTransparent = false,
      this.onBack,
      this.trailing,
      this.backIcon = AppIcons.prev,
      this.backBtnSemantics});
  final String? title;
  final String? subtitle;
  final bool showBackBtn;
  final AppIcons backIcon;
  final String? backBtnSemantics;
  final bool isTransparent;
  final VoidCallback? onBack;
  final Widget Function(BuildContext context)? trailing;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: isTransparent ? Colors.transparent : DesignColor.textColorBlack,
      child: SafeArea(
        bottom: false,
        child: SizedBox(
          height: 64 * 1,
          child: Stack(
            children: [
              MergeSemantics(
                child: Semantics(
                  header: true,
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (title != null)
                          Text(
                            title!.toUpperCase(),
                            textHeightBehavior: const TextHeightBehavior(
                                applyHeightToFirstAscent: false),
                            // style: $styles.text.h4.copyWith(
                            //   color: $styles.colors.offWhite,
                            //   fontWeight: FontWeight.w500,
                            // ),
                          ),
                        if (subtitle != null)
                          Text(
                            subtitle!.toUpperCase(),
                            textHeightBehavior: const TextHeightBehavior(
                                applyHeightToFirstAscent: false),
                            // style: $styles.text.title1.copyWith(color: $styles.colors.accent1),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned.fill(
                child: Center(
                  child: Row(children: [
                    16.height,
                    if (showBackBtn)
                      BackBtn(
                        onPressed: onBack,
                        icon: backIcon,
                        semanticLabel: backBtnSemantics,
                      ),
                    const Spacer(),
                    if (trailing != null) trailing!.call(context),
                    16.height,
                    //if (showBackBtn) Container(width: $styles.insets.lg * 2, alignment: Alignment.centerLeft, child: child),
                  ]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
