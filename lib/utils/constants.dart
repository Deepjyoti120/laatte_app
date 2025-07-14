import 'package:flutter/foundation.dart';
import 'package:package_info_plus/package_info_plus.dart';

class Constants {
  static final Constants _instance = Constants._internal();
  Constants._internal();
  // factory Constants() {
  //   return _instance;
  // }
  static Constants get instance => _instance;
  // For api Start
  // static const String apiUrl = "http://43.204.230.1:5001";
  static const String apiUrl =
      kDebugMode ? "http://localhost:5001" : "http://43.204.230.1:5001";
  static const String apiVersion = "/v1/api/";
  // For api End
  static PackageInfo? packageInfo;
  static int buildNumber = 0;
  // static String? deviceIpAddress;

  static setAppInfo() async {
    PackageInfo pi = await PackageInfo.fromPlatform();
    packageInfo = pi;
    buildNumber = int.parse(pi.buildNumber);
    // deviceIpAddress = await Utils.getDeviceIpAddress();
  }

  static const String appName = 'Laatte';
  // key
  static const String keyLoginButton = "keyLoginButton";
  static const int otpResendSeconds = 120;
  // key
  static const String appFullName = 'More Than a Swipe, It’s a Thought';
  static const double elevation = 0;
  static const String companyName = 'BaraxunTech';
  static const String companySite = 'https://baraxuntech.com/';
  static const String currencySymbol = '₹';
  // for Hive
  static String storageBox = 'storageBox$buildNumber';
  static String basicInfoBox = 'topicBox$buildNumber';
  static String basicInfoKey = 'basicInfoKey';
  static String profileBox = 'profileBox$buildNumber';
  static String profileKey = 'profileKey';
  static String currentRouteKey = 'currentRoute';
  static String isAllowNotificationKey = 'isAllowNotification';
  // for Hive end

  static String termAndCondition =
      'By using this app, you agree to our Terms & Conditions, which outline the rules, responsibilities, and guidelines for using our platform. These include details about user conduct, privacy, account management, and dispute resolution. We recommend reviewing the Terms & Conditions to understand your rights and obligations. Your continued use of the app signifies acceptance of these terms.';
  static String allowLocation =
      'Enabling location access helps us connect you with nearby matches, personalize your experience, and suggest local date ideas.';
  static List<String> tags = [
    "LoveIsConfusing",
    "LookingForSparks",
    "CrushChronicles",
    "HeartVsHead",
    "ButterfliesMoment",
    "FirstDateFails",
    "SmoothOrNot",
    "WhatDidISay",
    "TooManyRedFlags",
    "SwipeRightStory",
    "ReadyToVibe",
    "TalkToMeNice",
    "LaughWithMe",
    "CanWeRelate",
    "ShareYourStory",
    "SingleAndThinking",
    "MyTypeOrNot",
    "LearningToLove",
    "HappilySingleish",
    "FiguringItOut",
    "ManifestingLove",
    "SmallStepsBigFeels",
    "GoodVibesOnly",
    "NewChapter",
    "OneStepCloser",
    "SwipeLife",
    "CringeConfessions",
    "GhostedAgain",
    "DMDisasters",
    "RomanticFail"
  ];
  static const String privacyPolicy =
      'https://sites.google.com/view/laatte/privacy-policy';
  static const String helpAndSupport =
      'https://sites.google.com/view/laatte-help';
}
