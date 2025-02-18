import 'package:flutter/material.dart';
class Responsive {
  static bool isMobile(BuildContext context) =>
      MediaQuery.sizeOf(context).shortestSide < 450;
  static bool isTablet(BuildContext context) {
    var shortestSide = MediaQuery.of(context).size.shortestSide;
    return shortestSide > 600;
  }
  static bool isDesktop(BuildContext context) =>
      MediaQuery.sizeOf(context).shortestSide >= 1100;
  static bool smallHeightPhone(BuildContext context) =>
      MediaQuery.sizeOf(context).shortestSide <= 780;
}
