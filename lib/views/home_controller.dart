import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:laatte/services/api_services.dart';
import 'package:laatte/ui/awesome_bottom_bar/src/bottom_bar_floating.dart';
import 'package:laatte/ui/awesome_bottom_bar/tab_item.dart';
import 'package:laatte/utils/design_colors.dart';
import 'package:laatte/viewmodel/bloc/socket_bloc.dart';
import 'package:laatte/viewmodel/bloc/user_report_bloc.dart';
import 'package:laatte/viewmodel/cubit/app_cubit.dart';
import 'package:laatte/views/chat/chat.dart';
import 'package:laatte/views/home/welcome_screen.dart';
import 'package:laatte/views/relate/add_relate.dart';
import 'package:laatte/views/relate/relate.dart';
import 'package:laatte/views/settings/setting.dart';
import '../ui/custom/bottom_bar.dart';
import '../ui/responsive/show_drawer_responsive.dart';

class HomeController extends StatefulWidget {
  static const String route = "/HomeController";
  const HomeController({super.key});

  @override
  State<HomeController> createState() => _HomeControllerState();
}

class _HomeControllerState extends State<HomeController> {
  // final socketService = SocketService();
  @override
  void initState() {
    super.initState();
    // GlobalContext.init(context);
    runInit();
  }

  runInit() async {
    // socketService.connect();
    // socketService.listenForMessages((message) {
    //   if (mounted) {
    //     print(message);
    //   }
    // });

    // final appState = context.read<AppStateCubit>();
    // appState.basicInfo = await ApiService().getBasicInfo(appState);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      // context.read<UserReportBloc>().add(UserReportFetched());
      context.read<UserReportBloc>().add(UserReportFetched());
      context.read<SocketBloc>().add(const SocketFetched());
      ApiService().irlVisit();
    });
  }

  @override
  Widget build(BuildContext context) {
    final appState = context.watch<AppStateCubit>();
    return ResponsiveDrawer(
      child: Scaffold(
        // bottomNavigationBar: _buildBottomBar(appState),
        // Container(
        //   padding:
        //       const EdgeInsets.only(bottom: 30, right: 32, left: 32),
        //   child: BottomBarFloating(
        //     items: const [
        //       TabItem(icon: FontAwesomeIcons.house, title: "Home"),
        //       TabItem(icon: FontAwesomeIcons.heart, title: "Relate"),
        //       TabItem(icon: FontAwesomeIcons.plus, title: "Add"),
        //       TabItem(icon: FontAwesomeIcons.comment, title: "Chat"),
        //       TabItem(icon: FontAwesomeIcons.user, title: "Profile"),
        //     ],
        //     backgroundColor: Colors.green,
        //     color: Colors.white,
        //     colorSelected: Colors.orange,
        //     indexSelected: appState.currentPage,
        //     paddingVertical: 24,
        //     onTap: (int index) => setState(
        //       () {
        //         appState.currentPage = index;
        //       },
        //     ),
        //   ),
        // )
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
        body: Stack(
          children: [
            getBody(appState),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.only(bottom: 30, right: 12, left: 12),
                // border radius: BorderRadius.circular(20),
                child: BottomBarFloating(
                  items: const [
                    TabItem(icon: FontAwesomeIcons.house, title: "Home"),
                    TabItem(icon: FontAwesomeIcons.heart, title: "Relate"),
                    TabItem(icon: FontAwesomeIcons.plus, title: "Add"),
                    TabItem(icon: FontAwesomeIcons.comment, title: "Chat"),
                    TabItem(icon: FontAwesomeIcons.user, title: "Profile"),
                  ],
                  backgroundColor: DesignColor.latteOrangeLight,
                  color: DesignColor.grey700,
                  borderRadius: BorderRadius.circular(40),
                  colorSelected: DesignColor.latteOrangeDark,
                  indexSelected: appState.currentPage,
                  paddingVertical: 20,
                  animated: true,
                  curve: Curves.linear,
                  onTap: (int index) => setState(
                    () {
                      appState.currentPage = index;
                    },
                  ),
                ),
              ),
            )
          ],
        ),
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
      backgroundColor: DesignColor.latteOrangeLight,
      bottomColor: DesignColor.latteOrangeLight,
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
          // GlobalController.nestedScrollViewController.animateTo(
          //   0,
          //   duration: const Duration(milliseconds: 400),
          //   curve: Curves.linearToEaseOut,
          // );
        }
      },
      items: [
        BottomBarItem(
          icon: const Icon(FontAwesomeIcons.house),
          title: Text(
            'Home',
            style: TextStyle(
              fontSize: 12,
              color: appState.isDarkMode ? DesignColor.backgroundColor : null,
            ),
          ),
          activeColor: appState.isDarkMode
              ? DesignColor.backgroundColor
              : DesignColor.primary,
          inactiveColor: DesignColor.inActive,
        ),
        BottomBarItem(
          icon: const Icon(FontAwesomeIcons.heart),
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
          icon: const Icon(FontAwesomeIcons.plus),
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
          icon: const Icon(FontAwesomeIcons.comment),
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
          icon: const Icon(FontAwesomeIcons.gear),
          title: Text('Settings',
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
      RelateScreen(),
      AddRelate(),
      ChatScreen(),
      SettingScreen(),
      // ProfileScreen(),
    ];
    return pages[appState.currentPage];
    // return IndexedStack(
    //   index: appState.currentPage,
    //   children: pages,
    // );
  }
}
