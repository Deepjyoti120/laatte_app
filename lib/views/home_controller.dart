import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:laatte/routes.dart';
import 'package:laatte/services/api_services.dart';
import 'package:laatte/utils/constants.dart';
import 'package:laatte/utils/design_colors.dart';
import 'package:laatte/utils/extensions.dart';
import 'package:laatte/viewmodel/cubit/app_cubit.dart';
import 'package:laatte/views/home/welcome_screen.dart';
import 'package:laatte/views/responsive.dart';
import '../services/token_handler.dart';
import '../ui/custom/bottom_bar.dart';
import '../ui/responsive/show_drawer_responsive.dart';
import '../ui/theme/text.dart';
import '../utils/assets_names.dart';
import '../viewmodel/controller/global_context.dart';
import '../viewmodel/controller/global_controller.dart';
import 'home/dwawer/app_drawer.dart';

class HomeController extends StatefulWidget {
  static const String route = "/HomeController";
  const HomeController({super.key});

  @override
  State<HomeController> createState() => _HomeControllerState();
}

class _HomeControllerState extends State<HomeController> {
  @override
  void initState() {
    super.initState();
    GlobalContext.init(context);
    runInit();
  }

  runInit() async {
    final appState = context.read<AppStateCubit>();
    appState.basicInfo = await ApiService().getBasicInfo(appState);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      // context.read<UserReportBloc>().add(UserReportFetched());
    });
  }

  @override
  Widget build(BuildContext context) {
    final appState = context.watch<AppStateCubit>();
    return ResponsiveDrawer(
      child: Scaffold(
        bottomNavigationBar: _buildBottomBar(appState),
        // floatingActionButton: FloatingActionButton(
        //   onPressed: () async {
        //     // context.read<ModuleBloc>().add(ModuleFetched());
        //     debugPrint(modules.items.length.toString());
        //     GoRouter.of(context).push(Routes.mapScreen);
        //     // GoRouter.of(context).push(Routes.roadCuttingAgency);
        //     // Utils.getDeviceIpAddress()
        //     //     .then((value) => Utils.logPrint(value ?? "error"));
        //   },
        //   backgroundColor: appState.isDarkMode
        //       ? DesignColor.darkCard
        //       : DesignColor.colorPrimary,
        //   // child: const Icon(FontAwesomeIcons.handHoldingDollar),
        //   child: SvgPicture.asset(
        //     AssetsName.svgRupeeSave,
        //     colorFilter: ColorFilter.mode(
        //       appState.isDarkMode ? Colors.white : Colors.white,
        //       BlendMode.srcIn,
        //     ),
        //     height: 28,
        //     width: 28,
        //   ),
        // ),
        // drawer: const AppDrawer(),
        body: getBody(appState),
        // body: SafeArea(
        //   child: NestedScrollView(
        //     controller: GlobalController.nestedScrollViewController,
        //     physics: appState.currentPage == 1
        //         ? const NeverScrollableScrollPhysics()
        //         : null,
        //     headerSliverBuilder: (context, innerBoxIsScrolled) {
        //       return [
        //         SliverAppBar(
        //           floating: true,
        //           pinned: false,
        //           snap: true,
        //           scrolledUnderElevation: 0,
        //           automaticallyImplyLeading: false,
        //           elevation: Constants.elevation,
        //           leading: Builder(
        //             builder: (context) => IconButton(
        //               icon: Icon(
        //                 FontAwesomeIcons.barsStaggered,
        //                 size: 18,
        //                 color: appState.isDarkMode
        //                     ? Colors.white
        //                     : DesignColor.grey900,
        //               ),
        //               onPressed: () {
        //                 if (Responsive.isTablet(context)) {
        //                   appState.isOpenDrawer = !appState.isOpenDrawer;
        //                 } else {
        //                   Scaffold.of(context).openDrawer();
        //                 }
        //               },
        //             ),
        //           ),
        //           title: Container(
        //             alignment: Alignment.centerLeft,
        //             child: Hero(
        //                 tag: AssetsName.appLogo,
        //                 child: Row(
        //                   children: [
        //                     // Image.asset(AssetsName.appLogo, height: 30),
        //                     // 8.width,
        //                     // if (!Responsive.isMobile(context))
        //                     DesignText(
        //                       Constants.appName,
        //                       fontSize: 15,
        //                       fontWeight: 600,
        //                       color: appState.isDarkMode
        //                           ? Colors.white
        //                           : DesignColor.grey900,
        //                     )
        //                         .animate()
        //                         .fadeIn(duration: 300.ms)
        //                         .then(delay: 200.ms) // baseline=800ms
        //                         .slide()
        //                   ],
        //                 )),
        //           ),
        //           actions: [
        //             // IconButton(
        //             //   onPressed: () {
        //             //     // context.push(Routes.mapScreen);
        //             //   },
        //             //   icon: const Icon(
        //             //     FontAwesomeIcons.mapLocationDot,
        //             //     color: DesignColor.success600,
        //             //     size: 20,
        //             //   ),
        //             // )
        //             //     .animate()
        //             //     .fadeIn(
        //             //       duration: const Duration(milliseconds: 200),
        //             //       curve: Curves.easeIn,
        //             //       delay: const Duration(milliseconds: 300),
        //             //     )
        //             //     .slideX(
        //             //       duration: const Duration(milliseconds: 800),
        //             //       curve: Curves.fastLinearToSlowEaseIn,
        //             //       begin: 2,
        //             //     ),
        //             IconButton(
        //                 onPressed: () {
        //                   showDialog(
        //                     context: context,
        //                     builder: (BuildContext context) {
        //                       return AlertDialog(
        //                         title: DesignText(
        //                           "Logout",
        //                           fontSize: 16,
        //                           fontWeight: 600,
        //                           color:
        //                               appState.isDarkMode ? Colors.white : null,
        //                         ),
        //                         content: DesignText(
        //                           "Are you sure you want to logout?",
        //                           fontSize: 14,
        //                           fontWeight: 400,
        //                           color:
        //                               appState.isDarkMode ? Colors.white : null,
        //                         ),
        //                         actions: [
        //                           TextButton(
        //                             onPressed: () {
        //                               Navigator.of(context).pop();
        //                             },
        //                             child: DesignText(
        //                               "Cancel",
        //                               fontSize: 14,
        //                               fontWeight: 400,
        //                               color: appState.isDarkMode
        //                                   ? Colors.white
        //                                   : null,
        //                             ),
        //                           ),
        //                           TextButton(
        //                             onPressed: () {
        //                               final goRouter = GoRouter.of(context);
        //                               TokenHandler.resetJwt().then((value) {
        //                                 goRouter.go(Routes.login);
        //                               });
        //                             },
        //                             child: DesignText(
        //                               "Logout",
        //                               fontSize: 14,
        //                               fontWeight: 400,
        //                               color: appState.isDarkMode
        //                                   ? Colors.white
        //                                   : null,
        //                             ),
        //                           ),
        //                         ],
        //                       );
        //                     },
        //                   );
        //                 },
        //                 icon: Icon(
        //                   FontAwesomeIcons.arrowRightFromBracket,
        //                   size: 18,
        //                   color: appState.isDarkMode
        //                       ? Colors.white
        //                       : DesignColor.grey900,
        //                 )),
        //             12.width
        //           ],
        //         ),
        //       ];
        //     },
        //     body: getBody(appState),
        //   ),
        // ),
      ),
    );
  }

  Widget _buildBottomBar(AppStateCubit appState) {
    return CustomBottomBar(
      backgroundColor: appState.isDarkMode
          ? DesignColor.greenDarkDarkMode
          : DesignColor.grey900,
      bottomColor: appState.isDarkMode ? DesignColor.grey900 : Colors.white,
      containerHeight: 60,
      selectedIndex: appState.currentPage,
      showElevation: true,
      itemCornerRadius: 8,
      iconSize: 18,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      curve: Curves.linear,
      // onItemSelected: (index) => appState.currentPage = index,
      onItemSelected: (value) {
        if (mounted) {
          appState.currentPage = value;
          // if (value == 0) {
          // GlobalController.tabController.animateTo(
          //   0,
          //   duration: const Duration(milliseconds: 600),
          //   curve: Curves.linearToEaseOut,
          // );
          // }
          GlobalController.nestedScrollViewController.animateTo(
            0,
            duration: const Duration(milliseconds: 400),
            curve: Curves.linearToEaseOut,
          );
        }
      },
      items: [
        BottomBarItem(
          icon: const Icon(FontAwesomeIcons.house),
          title: Text('Home',
              style: TextStyle(
                fontSize: 12,
                color: appState.isDarkMode ? DesignColor.backgroundColor : null,
              )),
          activeColor: appState.isDarkMode
              ? DesignColor.backgroundColor
              : DesignColor.primary,
          inactiveColor: DesignColor.inActive,
        ),
        BottomBarItem(
          icon: const Icon(FontAwesomeIcons.moneyBill),
          title: Text('Realte',
              style: TextStyle(
                fontSize: 12,
                color: appState.isDarkMode ? DesignColor.grey900 : null,
              )),
          activeColor: appState.isDarkMode
              ? DesignColor.backgroundColor
              : DesignColor.primary,
          inactiveColor: DesignColor.inActive,
        ),
        BottomBarItem(
          icon: const Icon(FontAwesomeIcons.user),
          title: Text('Add',
              style: TextStyle(
                fontSize: 12,
                color: appState.isDarkMode ? DesignColor.backgroundColor : null,
              )),
          activeColor: appState.isDarkMode
              ? DesignColor.backgroundColor
              : DesignColor.primary,
          inactiveColor: DesignColor.inActive,
        ),
        BottomBarItem(
          icon: const Icon(FontAwesomeIcons.user),
          title: Text('Chat',
              style: TextStyle(
                fontSize: 12,
                color: appState.isDarkMode ? DesignColor.backgroundColor : null,
              )),
          activeColor: appState.isDarkMode
              ? DesignColor.backgroundColor
              : DesignColor.primary,
          inactiveColor: DesignColor.inActive,
        ),
        BottomBarItem(
          icon: const Icon(FontAwesomeIcons.user),
          title: Text('Profile',
              style: TextStyle(
                fontSize: 12,
                color: appState.isDarkMode ? DesignColor.backgroundColor : null,
              )),
          activeColor: appState.isDarkMode
              ? DesignColor.backgroundColor
              : DesignColor.primary,
          inactiveColor: DesignColor.inActive,
        ),
      ],
    );
  }

  Widget getBody(AppStateCubit appState) {
    List<Widget> pages = const [
      WelcomeScreen(),
      WelcomeScreen(),
      WelcomeScreen(),
      WelcomeScreen(),
      WelcomeScreen(),
    ];
    // return pages[appState.currentPage];
    return IndexedStack(
      index: appState.currentPage,
      children: pages,
    );
  }
}
