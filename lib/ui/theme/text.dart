import 'package:flutter/material.dart';
import 'package:laatte/ui/theme/text_style.dart';

import '../../utils/design_colors.dart';
import '../../views/responsive.dart';

class DesignText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final int? fontWeight;
  final bool muted, xMuted;
  final double? letterSpacing;
  final Color? color;
  final bool iscolor;
  final bool iscolorSecond;
  final bool isDesignButton;
  final TextDecoration decoration;
  final double? height;
  final double wordSpacing;
  final double? fontSize;
  final DesignTextType textType;
  final TextAlign? textAlign;
  final int? maxLines;
  final Locale? locale;
  final TextOverflow? overflow;
  final String? semanticsLabel;
  final bool? softWrap;
  final StrutStyle? strutStyle;
  final TextDirection? textDirection;
  final TextHeightBehavior? textHeightBehavior;
  final double? textScaleFactor;
  final TextWidthBasis? textWidthBasis;

  const DesignText(this.text,
      {Key? key,
      this.style,
      this.fontWeight = 600,
      this.fontSize = 14,
      this.muted = false,
      this.xMuted = false,
      this.letterSpacing = 0.15,
      this.color = DesignColor.textBlack,
      this.iscolor = false,
      this.iscolorSecond = false,
      this.isDesignButton = false,
      this.decoration = TextDecoration.none,
      this.height,
      this.wordSpacing = 0,
      this.textType = DesignTextType.b1,
      this.textAlign,
      this.maxLines,
      this.locale,
      this.overflow,
      this.semanticsLabel,
      this.softWrap,
      this.strutStyle,
      this.textDirection,
      this.textHeightBehavior,
      this.textScaleFactor,
      this.textWidthBasis})
      : super(key: key);
  const DesignText.title(this.text,
      {Key? key,
      this.style,
      this.fontWeight = 700,
      this.fontSize = 18,
      this.muted = false,
      this.xMuted = false,
      this.letterSpacing = 0.15,
      this.color = DesignColor.textBlack,
      this.iscolor = false,
      this.iscolorSecond = false,
      this.isDesignButton = false,
      this.decoration = TextDecoration.none,
      this.height,
      this.wordSpacing = 0,
      this.textType = DesignTextType.b1,
      this.textAlign,
      this.maxLines,
      this.locale,
      this.overflow,
      this.semanticsLabel,
      this.softWrap,
      this.strutStyle,
      this.textDirection,
      this.textHeightBehavior,
      this.textScaleFactor,
      this.textWidthBasis})
      : super(key: key);
  const DesignText.titleSemiBold(this.text,
      {Key? key,
      this.style,
      this.fontWeight = 600,
      this.fontSize = 20,
      this.muted = false,
      this.xMuted = false,
      this.letterSpacing = 0.15,
      this.color = DesignColor.midnightBlue,
      this.iscolor = false,
      this.iscolorSecond = false,
      this.isDesignButton = false,
      this.decoration = TextDecoration.none,
      this.height,
      this.wordSpacing = 0,
      this.textType = DesignTextType.b1,
      this.textAlign,
      this.maxLines,
      this.locale,
      this.overflow,
      this.semanticsLabel,
      this.softWrap,
      this.strutStyle,
      this.textDirection,
      this.textHeightBehavior,
      this.textScaleFactor,
      this.textWidthBasis})
      : super(key: key);
  const DesignText.titleSemi(this.text,
      {Key? key,
      this.style,
      this.fontWeight = 600,
      this.fontSize = 14,
      this.muted = false,
      this.xMuted = false,
      this.letterSpacing = 0.15,
      this.color = DesignColor.midnightBlue,
      this.iscolor = false,
      this.iscolorSecond = false,
      this.isDesignButton = false,
      this.decoration = TextDecoration.none,
      this.height,
      this.wordSpacing = 0,
      this.textType = DesignTextType.b1,
      this.textAlign,
      this.maxLines,
      this.locale,
      this.overflow,
      this.semanticsLabel,
      this.softWrap,
      this.strutStyle,
      this.textDirection,
      this.textHeightBehavior,
      this.textScaleFactor,
      this.textWidthBasis})
      : super(key: key);
  const DesignText.body(this.text,
      {Key? key,
      this.style,
      this.fontWeight = 500,
      this.fontSize = 14,
      this.muted = false,
      this.xMuted = false,
      this.letterSpacing = 0.15,
      this.color = DesignColor.textbody,
      this.iscolor = false,
      this.iscolorSecond = false,
      this.isDesignButton = false,
      this.decoration = TextDecoration.none,
      this.height,
      this.wordSpacing = 0,
      this.textType = DesignTextType.b1,
      this.textAlign,
      this.maxLines,
      this.locale,
      this.overflow,
      this.semanticsLabel,
      this.softWrap,
      this.strutStyle,
      this.textDirection,
      this.textHeightBehavior,
      this.textScaleFactor,
      this.textWidthBasis})
      : super(key: key);
  const DesignText.body1(this.text,
      {Key? key,
      this.style,
      this.fontWeight = 600,
      this.fontSize = 12,
      this.muted = false,
      this.xMuted = false,
      this.letterSpacing = 0.15,
      this.color = DesignColor.textbody,
      this.iscolor = false,
      this.iscolorSecond = false,
      this.isDesignButton = false,
      this.decoration = TextDecoration.none,
      this.height,
      this.wordSpacing = 0,
      this.textType = DesignTextType.b1,
      this.textAlign,
      this.maxLines,
      this.locale,
      this.overflow,
      this.semanticsLabel,
      this.softWrap,
      this.strutStyle,
      this.textDirection,
      this.textHeightBehavior,
      this.textScaleFactor,
      this.textWidthBasis})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: style ??
          DesignTextStyle.designStyle(
            textStyle: style,
            color: color ?? DesignColor.title,
            fontWeight: fontWeight ??
                DesignTextStyle.defaultTextFontWeight[textType] ??
                500,
            muted: muted,
            letterSpacing: letterSpacing ??
                DesignTextStyle.defaultLetterSpacing[textType] ??
                0.15,
            height: height,
            xMuted: xMuted,
            decoration: decoration,
            wordSpacing: wordSpacing,
            fontSize: fontSize ?? DesignTextStyle.defaultTextSize[textType],
          ),
      textAlign: textAlign,
      maxLines: maxLines,
      locale: locale,
      overflow: overflow,
      semanticsLabel: semanticsLabel,
      softWrap: softWrap,
      strutStyle: strutStyle,
      textDirection: TextDirection.ltr,
      textHeightBehavior: textHeightBehavior,
      textScaleFactor: textScaleFactor,
      textWidthBasis: textWidthBasis,
      key: key,
    );
  }
}

class DesignTextDashBoard extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final int? fontWeight;
  final bool muted, xMuted;
  final double? letterSpacing;
  final Color? color;
  final bool iscolor;
  final bool iscolorSecond;
  final bool isDesignButton;
  final TextDecoration decoration;
  final double? height;
  final double wordSpacing;
  final double? fontSize;
  final DesignTextType textType;
  final TextAlign? textAlign;
  final int? maxLines;
  final Locale? locale;
  final TextOverflow? overflow;
  final String? semanticsLabel;
  final bool? softWrap;
  final StrutStyle? strutStyle;
  final TextDirection? textDirection;
  final TextHeightBehavior? textHeightBehavior;
  final double? textScaleFactor;
  final TextWidthBasis? textWidthBasis;

  const DesignTextDashBoard(this.text,
      {Key? key,
      this.style,
      this.fontWeight = 600,
      this.muted = false,
      this.xMuted = false,
      this.letterSpacing = 0.15,
      this.color,
      this.iscolor = false,
      this.iscolorSecond = false,
      this.isDesignButton = false,
      this.decoration = TextDecoration.none,
      this.height,
      this.wordSpacing = 0,
      this.fontSize,
      this.textType = DesignTextType.b1,
      this.textAlign,
      this.maxLines,
      this.locale,
      this.overflow,
      this.semanticsLabel,
      this.softWrap,
      this.strutStyle,
      this.textDirection,
      this.textHeightBehavior,
      this.textScaleFactor,
      this.textWidthBasis})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: style ??
          DesignTextStyle.designStyle(
            textStyle: style,
            color: color,
            fontWeight: fontWeight ??
                DesignTextStyle.defaultTextFontWeight[textType] ??
                500,
            muted: muted,
            letterSpacing: letterSpacing ??
                DesignTextStyle.defaultLetterSpacing[textType] ??
                0.15,
            height: height,
            xMuted: xMuted,
            decoration: decoration,
            wordSpacing: wordSpacing,
            fontSize: Responsive.isTablet(context)
                ? (fontSize ?? 10) + MediaQuery.sizeOf(context).width * 0.008
                : fontSize ?? 13,
          ),
      textAlign: textAlign,
      maxLines: maxLines,
      locale: locale,
      overflow: overflow,
      semanticsLabel: semanticsLabel,
      softWrap: softWrap,
      strutStyle: strutStyle,
      textDirection: TextDirection.ltr,
      textHeightBehavior: textHeightBehavior,
      textScaleFactor: textScaleFactor,
      textWidthBasis: textWidthBasis,
      key: key,
    );
  }
}
