import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:laatte/common_libs.dart';
import 'package:laatte/ui/theme/buttons.dart';
import 'package:laatte/ui/theme/container.dart';
import 'package:laatte/ui/theme/text.dart';
import 'package:laatte/utils/assets_names.dart';
import 'package:laatte/utils/design_colors.dart';
import 'package:laatte/utils/extensions.dart';
import 'package:laatte/viewmodel/cubit/app_cubit.dart';
import 'package:laatte/views/home/profile_card.dart';
import '../../viewmodel/bloc/user_report_bloc.dart';

class WelcomeScreen extends StatefulWidget {
  static const String route = "/WelcomeScreen";
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  void initState() {
    super.initState();
    // runInit();
  }

  runInit() async {
    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
    //   final appState = context.read<AppStateCubit>();
    //   appState.basicInfo = await ApiService().getBasicInfo(appState);
    // });
  }

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserReportBloc>().state;
    final appState = context.watch<AppStateCubit>();
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Padding(
            //   padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     children: [
            //       DAnimation(
            //         visible: true,
            //         child: Column(
            //           crossAxisAlignment: CrossAxisAlignment.start,
            //           children: [
            //             const SizedBox(height: 4),
            //             const DesignText.titleSemi(
            //               'Welcome back',
            //             ).animate().fadeIn(duration: 600.ms).then(delay: 200.ms),
            //             4.height,
            //             DesignText.title(
            //               (user.userReport?.name ?? '').capitalizeFirstLetter(),
            //             ).animate().fadeIn(duration: 600.ms).slide(
            //                   delay: 200.ms,
            //                   curve: Curves.easeInOutBack,
            //                 ),
            //           ],
            //         ),
            //       ),
            //       const DAnimation(
            //         visible: true,
            //         child: ShowTodayCard(),
            //       ),
            //     ],
            //   ),
            // ),
            // const Divider(color: DesignColor.grey,),
            // 20.height,
            // const PaymentsScreen(),
            ProfileCard(user: user.userReport),
            16.height,
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: DesignButtons(
                    color: DesignColor.success600,
                    elevation: 0,
                    fontSize: 16,
                    fontWeight: 500,
                    colorText: Colors.white,
                    isTappedNotifier: ValueNotifier<bool>(false),
                    onPressed: () async {},
                    textLabel: "",
                    pdbottom: 14,
                    pdtop: 14,
                    bottomLeft: 8,
                    bottomRight: 8,
                    topLeft: 8,
                    topRight: 8,
                    borderSide: true,
                    colorBorderSide: DesignColor.success600,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          AssetsName.svgFingerPrint,
                          height: 24,
                          width: 24,
                        ),
                        12.width,
                        const DesignText.body(
                          "Check IN",
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ),
                12.width,
                Expanded(
                  child: DesignButtons(
                    color: DesignColor.success600,
                    elevation: 0,
                    fontSize: 16,
                    fontWeight: 500,
                    colorText: Colors.white,
                    isTappedNotifier: ValueNotifier<bool>(false),
                    onPressed: () async {},
                    textLabel: "",
                    pdbottom: 14,
                    pdtop: 14,
                    bottomLeft: 8,
                    bottomRight: 8,
                    topLeft: 8,
                    topRight: 8,
                    borderSide: true,
                    colorBorderSide: DesignColor.success600,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          AssetsName.svgDoneClick,
                          height: 24,
                          width: 24,
                        ),
                        12.width,
                        const DesignText.body(
                          "Apply Leave",
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            if (appState.activeHomeItems.isNotEmpty) 16.height,
            if (appState.activeHomeItems.isNotEmpty)
              DesignContainer(
                blurRadius: 0,
                borderAllColor: DesignColor.grey300,
                bordered: true,
                isColor: true,
                color: DesignColor.grey50,
                borderRadius: BorderRadius.circular(12),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
                  child: GridView.builder(
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 25,
                      mainAxisSpacing: 0,
                      childAspectRatio: 0.8,
                    ),
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: appState.activeHomeItems.length,
                    itemBuilder: (context, index) {
                      final item = appState.activeHomeItems[index];
                      return GestureDetector(
                        onTap: () {
                          context.push(item.route);
                        },
                        child: Column(
                          children: [
                            DesignContainer(
                              blurRadius: 0,
                              borderAllColor: item.color,
                              bordered: true,
                              isColor: true,
                              width: double.infinity,
                              height: 80,
                              color: item.colorLight,
                              borderRadius: BorderRadius.circular(12),
                              // child: item.icon,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    item.icon,
                                  ],
                                ),
                              ),
                            ),
                            4.height,
                            DesignText.body(
                              item.name,
                              color: item.color,
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ).animate().fadeIn(duration: 600.ms),
                      );
                    },
                  ),
                ),
              ).animate().fadeIn(duration: 600.ms)
          ],
        ),
      ),
    );
  }
}
