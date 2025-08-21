import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:laatte/app.dart';
import 'package:laatte/firebase_options.dart';
import 'package:laatte/services/api_services.dart';
import 'package:laatte/services/background_service.dart';
import 'package:laatte/services/location_tracker.dart';
import 'package:laatte/services/storage.dart';
import 'package:laatte/viewmodel/bloc/bloc_observer.dart';
import 'package:laatte/viewmodel/cubit/app_cubit.dart';
import 'package:laatte/viewmodel/model/basic_info.dart';
import 'package:laatte/viewmodel/model/country_state.dart';
import 'package:laatte/viewmodel/model/department.dart';
import 'package:laatte/viewmodel/model/designation.dart';
import 'package:laatte/viewmodel/model/photo_model.dart';
import 'package:laatte/viewmodel/model/user_reports.dart';
import 'package:workmanager/workmanager.dart';
import 'utils/constants.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    debugPrint("task: $task");
    return await BackgroundService.handleTask(task);
  });
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // await ApiService().feedback("This is Bckground Notification");
  Workmanager().initialize(
    callbackDispatcher,
    isInDebugMode: true,
  );
  Workmanager().registerPeriodicTask(
    "task-identifier15",
    Constants.workerstoreSheduleTaskName,
    frequency: const Duration(minutes: 15),
  );
  await Hive.initFlutter();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  Bloc.observer = SimpleBlocObserver();
  await Constants.setAppInfo();
  Hive.registerAdapter(BasicInfoAdapter());
  Hive.registerAdapter(PermissionsAdapter());
  Hive.registerAdapter(UserReportAdapter());
  Hive.registerAdapter(DepartmentAdapter());
  Hive.registerAdapter(DesignationAdapter());
  Hive.registerAdapter(CountryAdapter());
  Hive.registerAdapter(CountryStateAdapter());
  Hive.registerAdapter(PhotoAdapter());
  await Storage.init();
  // await LocationTracker.start();
  runApp(
    BlocProvider<AppStateCubit>(
      create: (context) => AppStateCubit(context: context),
      child: const App(),
    ),
  );
}
