import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:laatte/routes.dart';
import 'package:laatte/services/api_services.dart';
import 'package:laatte/services/storage.dart';
import 'package:laatte/ui/theme/text.dart';
import 'package:laatte/utils/assets_names.dart';
import 'package:laatte/utils/design_colors.dart';
import 'package:laatte/utils/utlis.dart';
import 'package:laatte/utils/extensions.dart';
import '../services/token_handler.dart';
import '../utils/constants.dart';
import '../viewmodel/cubit/app_cubit.dart';

class SplashScreen extends StatefulWidget {
  static const String route = "/";
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    checkToken();
  }

  // final apiAccess = ApiAccess();
  void checkToken() async {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      // final appState = context.read<AppStateCubit>();
      final goRouter = GoRouter.of(context);
      ApiService().dio.options.baseUrl =
          Constants.apiUrl + Constants.apiVersion;
      final String token = await TokenHandler.getToken();
      debugPrint('token: isEmpty: ${token.isEmpty}');
      // await apiAccess.getAppOrgurlInfo().then((value) {
      // if (Constants.buildNumber >=
      //     (appState.configModel?.buildNumber ?? Constants.buildNumber)) {
      if (token.isNotEmpty) {
        // appState.basicInfo = await ApiService().getBasicInfo(appState);
        goRouter.go(Routes.homeController);
        final String? currentRoute =
            Storage.get<String>(Constants.currentRouteKey);
        if (currentRoute == null) {
          goRouter.go(Routes.homeController);
        } else {
          goRouter.go(currentRoute);
        }
      } else {
        goRouter.go(Routes.introScreen);
      }
      // } else {
      //   goRouter.go(Routes.newUpdate);
      // }
      // });
    });
  }

  @override
  Widget build(BuildContext context) {
    final appState = context.watch<AppStateCubit>();
    return Scaffold(
        backgroundColor:
            appState.isDarkMode ? DesignColor.darkCard : Colors.white,
        body: Stack(
          alignment: Alignment.center,
          children: [
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                ),
                child: Image.asset(
                  AssetsName.pngBg,
                  fit: BoxFit.fill,
                  height: double.infinity,
                  width: double.infinity,
                ),
              ),
            ),
            SafeArea(
              child: IntrinsicHeight(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(40),
                    ),
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(
                          20, 100, 20, Utils.isIOS ? 30 : 20),
                      child: SizedBox(
                        width: double.infinity,
                        child: AnimationConfiguration.synchronized(
                          duration: const Duration(seconds: 1),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const DesignText.title(
                                    "Welcome to",
                                    fontSize: 32,
                                    fontWeight: 500,
                                    color: DesignColor.primary,
                                  ).animate().fadeIn(
                                        duration:
                                            const Duration(milliseconds: 300),
                                        curve: Curves.easeIn,
                                        delay:
                                            const Duration(milliseconds: 200),
                                      ),
                                  6.height,
                                  Hero(
                                    tag: AssetsName.appLogo,
                                    child: SlideAnimation(
                                      verticalOffset: 20.0,
                                      child: Image.asset(
                                        AssetsName.appLogo,
                                        height: 80,
                                        width: 80,
                                      ),
                                    ),
                                  ),
                                  20.height,
                                  const DesignText.body(
                                    Constants.appFullName,
                                    fontWeight: 500,
                                  ).animate().fadeIn(
                                        duration:
                                            const Duration(milliseconds: 300),
                                        curve: Curves.easeIn,
                                        delay:
                                            const Duration(milliseconds: 200),
                                      ),
                                ],
                              ),
                              DesignText.body(
                                "v${Constants.packageInfo?.version ?? ""}",
                                // fontSize: 32,
                                fontWeight: 500,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
