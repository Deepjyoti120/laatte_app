import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:laatte/router.dart';
import 'package:laatte/theme.dart';
import 'package:laatte/ui/theme/text.dart';
import 'package:laatte/utils/constants.dart';
import 'package:laatte/viewmodel/bloc/employee_bloc.dart';
import 'package:laatte/viewmodel/bloc/socket_bloc.dart';
import 'package:laatte/viewmodel/bloc/user_report_bloc.dart';
import 'package:laatte/viewmodel/bloc/visit_irl_bloc.dart';
import 'package:laatte/viewmodel/cubit/app_cubit.dart';
import 'package:laatte/viewmodel/cubit/intro_profile_cubit.dart';
import 'viewmodel/bloc/my_prompts_bloc.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);
  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> with WidgetsBindingObserver {
  final scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();
  late SnackBar noInternetSnackBar;
  late AppStateCubit cubit;

  @override
  void initState() {
    super.initState();
    final dispatcher = SchedulerBinding.instance.platformDispatcher;
    dispatcher.onPlatformBrightnessChanged = () {
      Brightness brightness = dispatcher.platformBrightness;
      cubit.setSystemThemeMode(brightness);
    };
    WidgetsBinding.instance.addObserver(this);
    cubit = context.read<AppStateCubit>();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final platformBrightness =
          View.of(context).platformDispatcher.platformBrightness;
      cubit.toggleDarkModeInit(platformBrightness);
      noInternetSnackBar = SnackBar(
        content: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.info,
              color: Colors.white,
            ),
            SizedBox(width: 6),
            DesignText(
              'No Internet Connection',
              fontSize: 12,
              fontWeight: 600,
              color: Colors.white,
            )
          ],
        ),
        duration: const Duration(seconds: 30),
        backgroundColor: Colors.black.withOpacity(0.85),
        behavior: SnackBarBehavior.floating,
      );
      // Connectivity().onConnectivityChanged.listen((result) {
      //   if (result.contains(ConnectivityResult.none)) {
      //     scaffoldMessengerKey.currentState?.showSnackBar(noInternetSnackBar);
      //   } else {
      //     scaffoldMessengerKey.currentState?.hideCurrentSnackBar();
      //   }
      // });
    });
  }

  @override
  void didChangePlatformBrightness() {
    super.didChangePlatformBrightness();
    final platformBrightness =
        View.of(context).platformDispatcher.platformBrightness;
    cubit.setSystemThemeMode(platformBrightness);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final appState = context.watch<AppStateCubit>().state;
    //MultiBlocProvider
    return BlocBuilder<AppStateCubit, AppStateInitial>(
        builder: (context, state) {
      return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => UserReportBloc()..add(UserReportStorage()),
          ),
          BlocProvider(
            create: (context) => EmployeeBloc(),
          ),
          BlocProvider(
            create: (context) => MyPromptsBloc(),
          ),
          BlocProvider(
            create: (context) => IntroProfileCubit(),
          ),
          BlocProvider(
            create: (context) => SocketBloc(context),
          ),
          BlocProvider(
            create: (context) => VisitIrlBloc(),
          ),
        ],
        child: MaterialApp.router(
          // navigatorKey: GlobalController.navigatorKey,
          routerConfig: goRouter,
          // add others property
          scaffoldMessengerKey: scaffoldMessengerKey,
          debugShowCheckedModeBanner: false,
          title: Constants.appName,
          // routes: appRoutes,
          // home: Audioooo(
          //   // onStop: (path) => "www.wav",
          // ),
          // themeMode: state.isDarkMode ? ThemeMode.dark : ThemeMode.light,
          themeMode: ThemeMode.light,
          theme: theme,
          darkTheme: darkTheme,
          // builder: (context, child) => ResponsiveBreakpoints.builder(
          //   child: child!,
          //   breakpoints: [
          //     const Breakpoint(start: 0, end: 450, name: MOBILE),
          //     const Breakpoint(start: 451, end: 800, name: TABLET),
          //     const Breakpoint(start: 801, end: 1920, name: DESKTOP),
          //     const Breakpoint(start: 1921, end: double.infinity, name: '4K'),
          //   ],
          // ),
          scrollBehavior: const MaterialScrollBehavior().copyWith(
            dragDevices: {
              PointerDeviceKind.mouse,
              PointerDeviceKind.touch,
              PointerDeviceKind.stylus,
              PointerDeviceKind.unknown,
            },
            multitouchDragStrategy: MultitouchDragStrategy.sumAllPointers,
          ),
        ),
      );
    });
  }
}
