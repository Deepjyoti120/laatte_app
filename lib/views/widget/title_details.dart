import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:laatte/utils/extensions.dart';

import '../../ui/theme/text.dart';
import '../../utils/design_colors.dart';

class TitleDetailsCard extends StatelessWidget {
  const TitleDetailsCard({
    Key? key,
    required this.title,
    required this.text,
    this.isCrossAxisAlignmentStart = true,
    this.color,
    this.colorTitle,
    this.titleFontSize,
    this.textFontSize,
    this.colorBGHighlight,
    this.isColumn = true,
    this.icon,
  }) : super(key: key);

  final String title;
  final String? text;
  final bool isCrossAxisAlignmentStart;
  final Color? color;
  final Color? colorTitle;
  final Color? colorBGHighlight;
  final double? titleFontSize;
  final double? textFontSize;
  final bool isColumn;
  final Widget? icon;

  @override
  Widget build(BuildContext context) {
    if (isColumn) {
      return Column(
        crossAxisAlignment: isCrossAxisAlignmentStart
            ? CrossAxisAlignment.start
            : CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (title.isNotEmpty) const SizedBox(height: 6),
          if (title.isNotEmpty)
            DesignText(
              title,
              fontSize: 14,
              fontWeight: 400,
              color: colorTitle ?? DesignColor.grey500,
            ),
          Container(
            decoration: colorBGHighlight != null
                ? BoxDecoration(
                    color: colorBGHighlight,
                    borderRadius: BorderRadius.circular(4),
                  )
                : null,
            child: Padding(
              padding: colorBGHighlight != null
                  ? const EdgeInsets.fromLTRB(3, 0, 3, 0)
                  : EdgeInsets.zero,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (icon != null) icon!,
                  if (icon != null) 6.width,
                  DesignText.body(
                    text ?? "",
                    fontSize: 14,
                    fontWeight: 500,
                    color: color ?? DesignColor.grey900,
                    // color: color ??
                    //     (appState.isDarkMode
                    //         ? DesignColor.darkVisibleText1
                    //         : DesignColor.grey2),
                  ),
                ],
              ),
            ),
          ),
        ],
      );
    } else {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          DesignText(
            "$title: ",
          ),
          Container(
            decoration: colorBGHighlight != null
                ? BoxDecoration(
                    color: colorBGHighlight,
                    borderRadius: BorderRadius.circular(4),
                  )
                : null,
            child: Padding(
              padding: colorBGHighlight != null
                  ? const EdgeInsets.fromLTRB(3, 0, 3, 0)
                  : EdgeInsets.zero,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (icon != null) icon!,
                  if (icon != null) 6.width,
                  DesignText.body(
                    text ?? "",
                  ),
                ],
              ),
            ),
          ),
        ],
      );
    }
  }
}
