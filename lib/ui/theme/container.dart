import 'package:flutter/material.dart';
import 'package:laatte/utils/design_colors.dart';

class DesignContainer extends StatelessWidget {
  final Widget child;
  final BorderRadius? borderRadius;
  final double? allBorderRadius, allPadding, allMargin, blurRadius;
  final EdgeInsetsGeometry? padding, margin;
  final Color? color;
  final Color? blurRadiuscolor;
  final Color? borderAllColor;
  final bool isColor;
  final bool bordered;
  final Border? border;
  final Clip? clipBehavior;
  final BoxShape shape;
  final double? width, height;
  final AlignmentGeometry? alignment;
  final bool enableBorderRadius;

  const DesignContainer({
    Key? key,
    required this.child,
    this.borderRadius,
    this.padding,
    this.allBorderRadius,
    this.allPadding,
    this.border,
    this.bordered = false,
    this.isColor = false,
    this.clipBehavior,
    this.color,
    this.blurRadiuscolor,
    this.shape = BoxShape.rectangle,
    this.width,
    this.height,
    this.alignment,
    this.enableBorderRadius = true,
    this.allMargin,
    this.margin,
    this.borderAllColor,
    this.blurRadius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget container = Container(
      width: width,
      height: height,
      alignment: alignment,
      margin: margin ?? EdgeInsets.all(allMargin ?? 0),
      decoration: BoxDecoration(
          boxShadow: blurRadius != null
              ? [
                  BoxShadow(
                    color: blurRadiuscolor ??
                        DesignColor.inActive.withOpacity(0.3),
                    blurRadius: blurRadius ?? 12.0,
                  ),
                ]
              : null,
          color: isColor ? color : const Color(0xffffffff),
          shape: shape,
          borderRadius: enableBorderRadius
              ? (shape == BoxShape.rectangle
                  ? borderRadius ??
                      BorderRadius.all(Radius.circular(allBorderRadius ?? 6))
                  : null)
              : null,
          border: bordered
              ? border ??
                  Border.all(
                      color: borderAllColor ?? Colors.grey.withOpacity(0.3),
                      width: 1)
              : null),
      padding: padding ?? EdgeInsets.all(allPadding ?? 0),
      clipBehavior: clipBehavior ?? Clip.none,
      child: child,
    );
    return container;
  }
}
