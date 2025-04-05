import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:laatte/viewmodel/cubit/intro_profile_cubit.dart';
import 'package:ntp/ntp.dart';

import '../main.dart';
import '../viewmodel/cubit/app_cubit.dart';

class TokenHandler {
  static const storage = FlutterSecureStorage();
  static Future setAccessKey(String value, {bool isRefresh = false}) async {
    await storage.write(key: isRefresh ? "keyRefresh" : "key", value: value);
  }

  static Future<String> getToken({bool isRefresh = false}) async {
    var token = await storage.read(key: isRefresh ? "keyRefresh" : "key");
    if (await isTokenExpired(token ?? "")) {
      return "";
    } else {
      return token ?? "";
    }
  }

  static Future<void> resetJwt() async {
    navigatorKey.currentContext?.read<AppStateCubit>().clear();
    navigatorKey.currentContext?.read<IntroProfileCubit>().clear();
    await Hive.deleteFromDisk();
    await storage.deleteAll();
  }
 
  // Validate Toke Start
  static Future<bool> isTokenExpired(String token) async {
    if (token.isEmpty) {
      return true; // Token is considered expired if it's empty or null
    }
    List<String> tokenParts = token.split('.');
    if (tokenParts.length != 3) {
      return true; // Invalid token format, consider it expired
    }
    String payload = tokenParts[1];
    String decodedPayload =
        String.fromCharCodes(base64Url.decode(base64Url.normalize(payload)));
    Map<String, dynamic> payloadMap = json.decode(decodedPayload);
    if (payloadMap.containsKey("exp")) {
      var expirationTimestamp = payloadMap["exp"];
      final ntp = await NTP.now();
      var currentTimestamp =
          ntp.millisecondsSinceEpoch ~/ 1000; // Convert to seconds
      if (currentTimestamp > expirationTimestamp) {
        return true; // Token is expired
      } else {
        return false; // Token is still valid
      }
    } else {
      return true; // Token doesn't contain expiration info, consider it expired
    }
  }
  // Validate Token End
}
