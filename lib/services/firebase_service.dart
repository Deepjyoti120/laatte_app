import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:laatte/common_libs.dart';

class FirebaseService {
  final firebaseMessaging = FirebaseMessaging.instance;
  Future<String?> get getDeviceToken async {
    try {
      return await firebaseMessaging.getToken();
    } catch (e) {
      return null;
    }
  }

  Future<void> requestNotificationPermission() async {
    try {
      NotificationSettings settings = await firebaseMessaging.requestPermission(
        alert: true,
        badge: true,
        sound: true,
      );
      if (settings.authorizationStatus == AuthorizationStatus.authorized) {
        debugPrint('User granted permission');
      } else if (settings.authorizationStatus ==
          AuthorizationStatus.provisional) {
        debugPrint('User granted provisional permission');
      } else {
        debugPrint('User declined or has not accepted permission');
      }
    } catch (e) {
      debugPrint('Error requesting notification permission: $e');
    }
  }
}
