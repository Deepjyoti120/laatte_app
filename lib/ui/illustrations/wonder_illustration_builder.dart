import 'package:laatte/common_libs.dart';
import 'package:laatte/ui/illustrations/wonder_illustration_config.dart';
import 'package:laatte/viewmodel/model/wonder_type.dart';

class WonderIllustrationBuilder extends StatefulWidget {
  const WonderIllustrationBuilder({
    super.key,
    required this.config,
    required this.fgBuilder,
    required this.mgBuilder,
    required this.bgBuilder,
    required this.wonderType,
  });

  final List<Widget> Function(BuildContext context, Animation<double> animation)
      fgBuilder;
  final List<Widget> Function(BuildContext context, Animation<double> animation)
      mgBuilder;
  final List<Widget> Function(BuildContext context, Animation<double> animation)
      bgBuilder;
  final WonderIllustrationConfig config;
  final WonderType wonderType;

  @override
  State<WonderIllustrationBuilder> createState() =>
      WonderIllustrationBuilderState();
}

class WonderIllustrationBuilderState extends State<WonderIllustrationBuilder>
    with SingleTickerProviderStateMixin {
  late final anim = AnimationController(
      vsync: this, duration: const Duration(milliseconds: 600) * .75)
    ..addListener(() => setState(() {}));

  bool get isShowing => widget.config.isShowing;

  @override
  void initState() {
    super.initState();
    if (isShowing) anim.forward(from: 0);
  }

  @override
  void dispose() {
    anim.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant WonderIllustrationBuilder oldWidget) {
    if (isShowing != oldWidget.config.isShowing) {
      isShowing ? anim.forward(from: 0) : anim.reverse(from: 1);
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    if (anim.value == 0 && widget.config.enableAnims)
      return const SizedBox.expand();
    Animation<double> animation =
        widget.config.enableAnims ? anim : const AlwaysStoppedAnimation(1);

    return Stack(
      children: [
        if (widget.config.enableBg) ...widget.bgBuilder(context, animation),
        if (widget.config.enableMg) ...widget.mgBuilder(context, animation),
        if (widget.config.enableFg) ...widget.fgBuilder(context, animation),
      ],
    );
  }
}
