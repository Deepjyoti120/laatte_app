import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseService {
  final firebaseMessaging = FirebaseMessaging.instance;
   Future<String?> get getDeviceToken async {
    try {
      return await firebaseMessaging.getToken();
    } catch (e) {
      return null;
    }
  }

}