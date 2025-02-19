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
  static const String apiUrl = kDebugMode
      ? "http://localhost:5001/"
      : "https://assamstateshousingboard.com/";
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
  static String basicInfoBox = 'topicBox$buildNumber';
  static String basicInfoKey = 'basicInfoKey';
  static String profileBox = 'profileBox$buildNumber';
  static String profileKey = 'profileKey';
  // for Hive end
}
