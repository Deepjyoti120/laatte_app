import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:laatte/app.dart';
import 'package:laatte/firebase_options.dart';
import 'package:laatte/services/storage.dart';
import 'package:laatte/viewmodel/bloc/bloc_observer.dart';
import 'package:laatte/viewmodel/cubit/app_cubit.dart';
import 'package:laatte/viewmodel/model/basic_info.dart';
import 'package:laatte/viewmodel/model/country_state.dart';
import 'package:laatte/viewmodel/model/department.dart';
import 'package:laatte/viewmodel/model/designation.dart';
import 'package:laatte/viewmodel/model/user_reports.dart';
import 'utils/constants.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
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
  await Storage.init();
  runApp(
    BlocProvider<AppStateCubit>(
      create: (context) => AppStateCubit(context: context),
      child: const App(),
    ),
  );
}
