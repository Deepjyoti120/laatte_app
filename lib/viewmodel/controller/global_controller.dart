import 'package:flutter/material.dart';

class GlobalController {
  static late TabController tabController;
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();
  static ScrollController nestedScrollViewController = ScrollController();
}
