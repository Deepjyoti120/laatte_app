import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:laatte/ui/theme/container.dart';

class ShimmerCard extends StatelessWidget {
  const ShimmerCard({
    required this.height,
    required this.width,
    this.baseColor,
    this.highlightColor,
    Key? key,
    this.radius,
  }) : super(key: key);
  final double height;
  final double width;
  final double? radius;
  final Color? baseColor;
  final Color? highlightColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: Shimmer.fromColors(
        baseColor: baseColor ?? Colors.grey.shade200,
        highlightColor: highlightColor ?? Colors.white,
        enabled: true,
        child: DesignContainer(
          clipBehavior: Clip.antiAlias,
          child: Container(),
        ),
      ),
    );
  }
}
