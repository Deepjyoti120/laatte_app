import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
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
  bool isEnd = false;
  @override
  void initState() {
    super.initState();
    runInit();
  }

  runInit() async {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      //final appState = context.read<AppStateCubit>();
      //appState.basicInfo = await ApiService().getBasicInfo(appState);
    });
  }

  List<Container> cards = [
    Container(
      alignment: Alignment.center,
      child: const Text('1'),
      color: Colors.blue,
    ),
    Container(
      alignment: Alignment.center,
      child: const Text('2'),
      color: Colors.red,
    ),
    Container(
      alignment: Alignment.center,
      child: const Text('3'),
      color: Colors.purple,
    )
  ];

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserReportBloc>().state;
    final appState = context.watch<AppStateCubit>();
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
      child: Column(
        children: [
          const Spacer(),
          Text(isEnd ? 'End' : 'Not End'),
          Flexible(
            flex: 2,
            child: CardSwiper(
              cardsCount: cards.length,
              cardBuilder:
                  (context, index, percentThresholdX, percentThresholdY) =>
                      cards[index],
              isLoop: false,
              onEnd: () {
                setState(() {
                  isEnd = true;
                });
              },
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
