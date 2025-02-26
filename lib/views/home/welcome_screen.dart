import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:laatte/common_libs.dart';
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
    runInit();
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
          ],
        ),
      ),
    );
  }
}
