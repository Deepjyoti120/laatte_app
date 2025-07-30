// import 'dart:async';
// import 'package:background_location/background_location.dart';
// import 'package:laatte/services/api_services.dart';
// import 'package:permission_handler/permission_handler.dart';

// class LocationTracker {
//   static Future<void> start() async {
//     await Permission.locationAlways.request();
//     await BackgroundLocation.setAndroidNotification(
//       title: "Finding Nearby IRL Matches",
//       message: "We’re updating your location to show nearby people & IRL",
//       icon: "@mipmap/ic_launcher",
//     );
//     await BackgroundLocation.startLocationService(
//       distanceFilter: 1000,
//     );
//     BackgroundLocation.getLocationUpdates((location) async {
//       unawaited(ApiService().irlVisit(isWorkManager: true, location: location));
//     });
//   }

//   static Future<void> stop() async {
//     await BackgroundLocation.stopLocationService();
//   }
// }
