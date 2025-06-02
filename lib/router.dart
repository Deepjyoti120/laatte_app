import 'package:laatte/common_libs.dart';
import 'package:laatte/routes.dart';
import 'package:laatte/viewmodel/model/chat_start.dart';
import 'package:laatte/viewmodel/model/prompt.dart';
import 'package:laatte/views/chat/chat_screen.dart';
import 'package:laatte/views/employee/add_employee.dart';
import 'package:laatte/views/employee/employee.dart';
import 'package:laatte/views/home/welcome_screen.dart';
import 'package:laatte/views/home_controller.dart';
import 'package:laatte/views/intro_screen/intro_screen.dart';
import 'package:laatte/views/irl/irl.dart';
import 'package:laatte/views/login/create_account.dart';
import 'package:laatte/views/login/login.dart';
import 'package:laatte/views/login/otp_screen.dart';
import 'package:laatte/views/profile/profile_update.dart';
import 'package:laatte/views/relate/matching_screen.dart';
import 'package:laatte/views/relate/relate_comments.dart';
import 'package:laatte/views/splash_screen.dart';
import 'main.dart';
import 'views/login/forgot_password.dart';
import 'views/profile/profile.dart';
import 'views/profile/update_intro/intro_update.dart';
import 'views/relate/add_relate.dart';
import 'views/relate/relate.dart';

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
      path: Routes.profileScreen,
      builder: (context, GoRouterState state) {
        return const ProfileScreen();
      },
    ),
    GoRoute(
      path: Routes.relateComment,
      builder: (context, GoRouterState state) {
        return RelateComment(
          prompt: state.extra as Prompt,
        );
      },
    ),
    // GoRoute(
    //   path: Routes.successFailedScreen,
    //   builder: (context, GoRouterState state) {
    //     Map<String, String> queryParameters = state.uri.queryParameters;
    //     return SuccessFailedScreen(
    //       data: queryParameters['data'] == null
    //           ? null
    //           : jsonDecode(queryParameters['data']!),
    //       isSuccess: queryParameters['isSuccess'] == 'true',
    //       message: queryParameters['message'] ?? '',
    //     );
    //   },
    // ),
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
    GoRoute(
      path: Routes.profileUpdateIntro,
      builder: (context, GoRouterState state) {
        return const ProfileUpdateIntro();
      },
    ),
    GoRoute(
      path: Routes.relateScreen,
      builder: (context, GoRouterState state) {
        return const RelateScreen();
      },
    ),
    GoRoute(
      path: Routes.addRelate,
      builder: (context, GoRouterState state) {
        return const AddRelate();
      },
    ),
    GoRoute(
      path: Routes.chatMessages,
      builder: (context, GoRouterState state) {
        return ChatMessages(chatId: state.extra.toString());
      },
    ),
    GoRoute(
      path: Routes.irlScreen,
      builder: (context, GoRouterState state) {
        return const IrlScreen();
      },
    ),
    GoRoute(
      path: Routes.matchingScreen,
      builder: (context, GoRouterState state) {
        return MatchingScreen(chatStart: state.extra as ChatStart);
      },
    ),
    GoRoute(
      path: Routes.profileUpdateScreen,
      builder: (context, GoRouterState state) {
        return const ProfileUpdateScreen();
      },
    ),
  ],
  // errorBuilder: (context, state) {
  //   debugPrint("state ${state.uri}");
  //   return const HomeScreen();
  // },
);
