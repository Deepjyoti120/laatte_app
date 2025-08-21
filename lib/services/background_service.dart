import 'dart:async';

import 'package:laatte/services/api_services.dart';
import 'package:laatte/utils/constants.dart';

class BackgroundService {
  // static Future setBackgroundWorker() async {
  //   Workmanager().executeTask((task, inputData) async {
  //     if (task == Constants.workerstoreSheduleTaskName) {
  //       await ApiService().irlVisit();
  //     }
  //     return Future.value(true);
  //   });
  // }
  static Future<bool> handleTask(String task) async {
    if (task == Constants.workerstoreSheduleTaskName) {
      await ApiService().storeLocation();
    }
    return Future.value(true);
  }
}
