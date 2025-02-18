import 'package:laatte/common_libs.dart';
import 'package:laatte/ui/controls/app_icons.dart';
import 'package:laatte/ui/controls/buttons.dart';
import 'package:laatte/utils/design_colors.dart';

class CircleBtn extends StatelessWidget {
  const CircleBtn({
    super.key,
    required this.child,
    required this.onPressed,
    this.border,
    this.bgColor,
    this.size,
    required this.semanticLabel,
  });

  static double defaultSize = 48;

  final VoidCallback? onPressed;
  final Color? bgColor;
  final BorderSide? border;
  final Widget child;
  final double? size;
  final String semanticLabel;

  @override
  Widget build(BuildContext context) {
    double sz = size ?? defaultSize;
    return AppBtn(
      onPressed: onPressed,
      semanticLabel: semanticLabel,
      minimumSize: Size(sz, sz),
      padding: EdgeInsets.zero,
      circular: true,
      bgColor: bgColor,
      border: border,
      child: child,
    );
  }
}

class CircleIconBtn extends StatelessWidget {
  const CircleIconBtn({
    super.key,
    required this.icon,
    required this.onPressed,
    this.border,
    this.bgColor,
    this.color,
    this.size,
    this.iconSize,
    this.flipIcon = false,
    required this.semanticLabel,
  });

  //TODO: Reduce size if design re-exports icon-images without padding
  static double defaultSize = 28;

  final AppIcons icon;
  final VoidCallback? onPressed;
  final BorderSide? border;
  final Color? bgColor;
  final Color? color;
  final String semanticLabel;
  final double? size;
  final double? iconSize;
  final bool flipIcon;

  @override
  Widget build(BuildContext context) {
    Color defaultColor = DesignColor.grey900;
    Color iconColor = color ?? DesignColor.offWhite;
    return CircleBtn(
      onPressed: onPressed,
      border: border,
      size: size,
      bgColor: bgColor ?? defaultColor,
      semanticLabel: semanticLabel,
      child: Transform.scale(
        scaleX: flipIcon ? -1 : 1,
        child: AppIcon(icon, size: iconSize ?? defaultSize, color: iconColor),
      ),
    );
  }

  Widget safe() => _SafeAreaWithPadding(child: this);
}

class BackBtn extends StatelessWidget {
  const BackBtn({
    super.key,
    this.icon = AppIcons.prev,
    this.onPressed,
    this.semanticLabel,
    this.bgColor,
    this.iconColor,
  });

  final Color? bgColor;
  final Color? iconColor;
  final AppIcons icon;
  final VoidCallback? onPressed;
  final String? semanticLabel;

  BackBtn.close(
      {Key? key, VoidCallback? onPressed, Color? bgColor, Color? iconColor})
      : this(
            key: key,
            icon: AppIcons.close,
            onPressed: onPressed,
            semanticLabel: 'close',
            bgColor: bgColor,
            iconColor: iconColor);

  bool _handleKeyDown(BuildContext context, KeyDownEvent event) {
    if (event.logicalKey == LogicalKeyboardKey.escape) {
      _handleOnPressed(context);
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return FullscreenKeyboardListener(
      onKeyDown: (event) => _handleKeyDown(context, event),
      child: CircleIconBtn(
        icon: icon,
        bgColor: bgColor,
        color: iconColor,
        onPressed: onPressed ??
            () {
              final nav = Navigator.of(context);
              if (nav.canPop()) {
                Navigator.pop(context);
              } else {
                // context.go(ScreenPaths.home);
              }
            },
        semanticLabel: semanticLabel ?? 'Back',
      ),
    );
  }

  Widget safe() => _SafeAreaWithPadding(child: this);

  void _handleOnPressed(BuildContext context) {
    if (onPressed != null) {
      onPressed?.call();
    } else {
      if (context.canPop()) {
        context.pop();
      } else {
        // context.go(ScreenPaths.home);
      }
    }
  }
}

class _SafeAreaWithPadding extends StatelessWidget {
  const _SafeAreaWithPadding({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Padding(
        padding: EdgeInsets.all(8),
        child: child,
      ),
    );
  }
}
