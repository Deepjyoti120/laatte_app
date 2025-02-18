import 'dart:convert';
import 'package:laatte/common_libs.dart';
import 'package:laatte/routes.dart';
import 'package:laatte/views/employee/add_employee.dart';
import 'package:laatte/views/employee/employee.dart';
import 'package:laatte/views/home/welcome_screen.dart';
import 'package:laatte/views/home_controller.dart';
import 'package:laatte/views/intro_screen/intro_screen.dart'; 
import 'package:laatte/views/login/create_account.dart';
import 'package:laatte/views/login/login.dart';
import 'package:laatte/views/login/otp_screen.dart';
import 'package:laatte/views/rents/history.dart';
import 'package:laatte/views/rents/success_failed_screen.dart';
import 'package:laatte/views/splash_screen.dart';
import 'main.dart';
import 'views/login/forgot_password.dart';
import 'views/profile/profile.dart';

final GoRouter goRouter = GoRouter(
  navigatorKey: navigatorKey,
  routes: <RouteBase>[
    GoRoute(
      path: Routes.main,
      builder: (context, GoRouterState state) {
        return const SplashScreen();
      },
    ),
    GoRoute(
      path: Routes.introScreen,
      builder: (context, GoRouterState state) {
        return const IntroScreen();
      },
    ),
    GoRoute(
      path: Routes.homeController,
      builder: (context, GoRouterState state) {
        return const HomeController();
      },
    ),
    GoRoute(
      path: Routes.login,
      builder: (context, GoRouterState state) {
        return const Login();
      },
      pageBuilder: (context, state) {
        const pageContent = Login();
        return CustomTransitionPage(
          key: state.pageKey,
          child: pageContent,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(opacity: animation, child: child);
          },
        );
      },
    ),
    GoRoute(
      path: Routes.createAccount,
      builder: (context, GoRouterState state) {
        return const CreateAccount();
      },
    ),
    GoRoute(
      path: Routes.otpScreen,
      builder: (context, GoRouterState state) {
        Map<String, String> queryParameters = state.uri.queryParameters;
        return OtpScreen(
          phone: queryParameters['phone'] ?? '',
        );
      },
    ),
    GoRoute(
      path: Routes.forgotPassword,
      builder: (context, GoRouterState state) {
        return const ForgotPassword();
      },
    ),
    GoRoute(
      path: Routes.welcomeScreen,
      builder: (context, GoRouterState state) {
        return const WelcomeScreen();
      },
    ),
    GoRoute(
      path: Routes.rentHistory,
      builder: (context, GoRouterState state) {
        return const RentHistory();
      },
    ),
    GoRoute(
      path: Routes.profileScreen,
      builder: (context, GoRouterState state) {
        return const ProfileScreen();
      },
    ),
    GoRoute(
      path: Routes.successFailedScreen,
      builder: (context, GoRouterState state) {
        Map<String, String> queryParameters = state.uri.queryParameters;
        return SuccessFailedScreen(
          data: queryParameters['data'] == null
              ? null
              : jsonDecode(queryParameters['data']!),
          isSuccess: queryParameters['isSuccess'] == 'true',
          message: queryParameters['message'] ?? '',
        );
      },
    ),
    GoRoute(
      path: Routes.employee,
      builder: (context, GoRouterState state) {
        return const Employee();
      },
    ),
    GoRoute(
      path: Routes.addEmployee,
      builder: (context, GoRouterState state) {
        return const AddEmployee();
      },
    ),
  ],
  // errorBuilder: (context, state) {
  //   debugPrint("state ${state.uri}");
  //   return const HomeScreen();
  // },
);
