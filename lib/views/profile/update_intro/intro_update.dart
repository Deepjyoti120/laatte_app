import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:laatte/utils/extensions.dart';
import 'package:laatte/viewmodel/cubit/intro_profile_cubit.dart';
import 'package:laatte/views/home_controller.dart';
import 'package:laatte/views/profile/update_intro/gender_form.dart';
import '../../../utils/design_colors.dart';
import '../../../viewmodel/cubit/app_cubit.dart';

class ProfileUpdateIntro extends StatefulWidget {
  static const String route = '/ProfileUpdateIntro';
  const ProfileUpdateIntro({super.key});

  @override
  State<ProfileUpdateIntro> createState() => _ProfileUpdateIntroState();
}

class _ProfileUpdateIntroState extends State<ProfileUpdateIntro> {
  // final PageController _controller = PageController();

  List screens = [
    const GenderForm(),
    HomeController(),
    HomeController(),
    HomeController(),
  ];
  @override
  void initState() {
    super.initState();
    setInit();
  }

  void setInit() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // final appState = Provider.of<AppState>(context, listen: false);
    });
  }

  @override
  Widget build(BuildContext context) {
    // return Scaffold();
    final appState = context.watch<IntroProfileCubit>();
    // PageController controller =
    //     PageController(initialPage: currentPage);
    return Scaffold(
      // backgroundColor: DesignColor.backgroundColor,
      bottomNavigationBar: BottomAppBar(
        child: SafeArea(
            child: Container(
          height: 50,
          color: DesignColor.backgroundColor,
          child: Row(
            mainAxisAlignment: appState.currentPage != 0
                ? MainAxisAlignment.spaceBetween
                : MainAxisAlignment.end,
            children: [
              if (appState.currentPage != 0)
                TextButton(
                  onPressed: () {
                    appState.controller.previousPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeIn,
                    );
                  },
                  child: Row(
                    children: [
                      Container(
                        height: 24,
                        width: 24,
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(60),
                          color: DesignColor.primary,
                        ),
                        child: const Icon(
                          FontAwesomeIcons.caretLeft,
                          color: Colors.white,
                          size: 16,
                        ),
                      ),
                      6.width,
                      const Text(
                        'Previous',
                        style: TextStyle(
                          color: DesignColor.primary,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              TextButton(
                onPressed: () {
                  appState.controller.nextPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeIn,
                  );
                },
                child: Row(
                  children: [
                    const Text(
                      'Next',
                      style: TextStyle(
                        color: DesignColor.primary,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    6.width,
                    Container(
                      height: 24,
                      width: 24,
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(60),
                        color: DesignColor.primary,
                      ),
                      child: const Icon(
                        FontAwesomeIcons.caretRight,
                        color: Colors.white,
                        size: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        )),
      ),
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              10.height,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  screens.length,
                  (index) => buildDot(index: index),
                ),
              ),
              // const Spacer(),
              Expanded(
                flex: 3,
                child: PageView.builder(
                  controller: appState.controller,
                  physics: const NeverScrollableScrollPhysics(),
                  onPageChanged: (value) {
                    appState.currentPage = value;
                  },
                  itemCount: screens.length,
                  itemBuilder: (context, index) {
                    return screens[index];
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  AnimatedContainer buildDot({int? index}) {
    final appState = context.watch<IntroProfileCubit>().state;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.only(right: 4),
      height: 2,
      width: appState.currentPage == index ? 14 : 6,
      decoration: BoxDecoration(
        color: appState.currentPage == index
            ? const Color(0xFF6F6CD9)
            : const Color(0xFFCDD9E3),
        borderRadius: BorderRadius.circular(6),
      ),
    );
  }
}
