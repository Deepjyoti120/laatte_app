import 'package:laatte/common_libs.dart';
import 'package:laatte/utils/design_colors.dart';

class AppPageIndicator extends StatefulWidget {
  const AppPageIndicator({
    super.key,
    required this.count,
    required this.controller,
    this.onDotPressed,
    this.color,
    this.dotSize,
    String? semanticPageTitle,
  }) : semanticPageTitle = semanticPageTitle ?? 'Title';
  final int count;
  final PageController controller;
  final void Function(int index)? onDotPressed;
  final Color? color;
  final double? dotSize;
  final String semanticPageTitle;

  @override
  State<AppPageIndicator> createState() => _AppPageIndicatorState();
}

class _AppPageIndicatorState extends State<AppPageIndicator> {
  final _currentPage = ValueNotifier(0);

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_handlePageChanged);
  }

  int get _controllerPage => _currentPage.value;

  void _handlePageChanged() {
    _currentPage.value = widget.controller.page!.round();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
        color: Colors.transparent,
        height: 30,
        alignment: Alignment.center,
        child: ValueListenableBuilder<int>(
            valueListenable: _currentPage,
            builder: (_, value, child) {
              return Semantics(
                liveRegion: true,
                focusable: false,
                readOnly: true,
                label: (_controllerPage % (widget.count) + 1).toString(),
                child: Container(),
              );
            }),
      ),
      Positioned.fill(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            widget.count,
            (index) => buildDot(index: index),
          ),
        ),
      ),
    ]);
  }

  AnimatedContainer buildDot({int? index}) {
    final selectedIndex = (_controllerPage % (widget.count));
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.only(right: 8),
      height: 8,
      width: selectedIndex == index ? 20 : 8,
      decoration: BoxDecoration(
        color:
            selectedIndex == index ? DesignColor.grey200 : DesignColor.grey400,
        borderRadius: BorderRadius.circular(6),
      ),
    );
  }
}
