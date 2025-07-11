import 'package:laatte/views/chat/chat_screen.dart';
import 'package:laatte/views/employee/add_employee.dart';
import 'package:laatte/views/employee/employee.dart';
import 'package:laatte/views/home/welcome_screen.dart';
import 'package:laatte/views/home_controller.dart';
import 'package:laatte/views/intro_screen/intro_screen.dart';
import 'package:laatte/views/irl/irl.dart';
import 'package:laatte/views/login/create_account.dart';
import 'package:laatte/views/login/login.dart';
import 'package:laatte/views/profile/profile_update.dart';
import 'package:laatte/views/relate/add_relate.dart';
import 'package:laatte/views/relate/matching_screen.dart';
import 'package:laatte/views/relate/relate_comments.dart';
import 'package:laatte/views/settings/feedback.dart';
import 'package:laatte/views/splash_screen.dart';
import 'views/login/forgot_password.dart';
import 'views/login/otp_screen.dart';
import 'views/profile/profile.dart';
import 'views/profile/update_intro/intro_update.dart';
import 'views/relate/relate.dart';

class Routes {
  static const String main = SplashScreen.route;
  static const String introScreen = IntroScreen.route;
  static const String homeController = HomeController.route;
  static const String login = Login.route;
  static const String createAccount = CreateAccount.route;
  static const String forgotPassword = ForgotPassword.route;
  static const String otpScreen = OtpScreen.route;
  static const String welcomeScreen = WelcomeScreen.route;
  // static const String rentHistory = RentHistory.route;
  static const String profileScreen = ProfileScreen.route;
  // static const String successFailedScreen = SuccessFailedScreen.route;
  static const String employee = Employee.route;
  static const String addEmployee = AddEmployee.route;
  static const String profileUpdateIntro = ProfileUpdateIntro.route;
  static const String relateScreen = RelateScreen.route;
  static const String addRelate = AddRelate.route;
  static const String relateComment = RelateComment.route;
  static const String chatMessages = ChatMessages.route;
  static const String irlScreen = IrlScreen.route;
  static const String matchingScreen = MatchingScreen.route;
  static const String profileUpdateScreen = ProfileUpdateScreen.route;
  static const String feedbackScreen = FeedbackScreen.route;
}
