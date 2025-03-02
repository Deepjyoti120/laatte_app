import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:flutter_svg/svg.dart';
import 'package:laatte/common_libs.dart';
import 'package:laatte/routes.dart';
import 'package:laatte/services/api_services.dart';
import 'package:laatte/services/token_handler.dart';
import 'package:laatte/utils/assets_names.dart';
import 'package:laatte/viewmodel/cubit/app_cubit.dart';
import 'package:laatte/views/home/comment_sheet.dart';
import '../../ui/theme/text.dart';
import '../../viewmodel/bloc/user_report_bloc.dart';
import '../../viewmodel/model/prompt.dart';

class WelcomeScreen extends StatefulWidget {
  static const String route = "/WelcomeScreen";
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final CardSwiperController _swiperController = CardSwiperController();
  bool isEnd = false;
  List<Prompt> listPrompt = [];

  @override
  void initState() {
    super.initState();
    runInit();
  }

  runInit() async {
    await ApiService().getPrompts().then((value) {
      listPrompt = value;
      setState(() {});
    });
  }


  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserReportBloc>().state;
    final appState = context.watch<AppStateCubit>();
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
      child: Column(
        children: [
          const Spacer(),
          if (listPrompt.isNotEmpty)
            Flexible(
              flex: 2,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        AssetsName.svgEmpty,
                        width: 100,
                        height: 100,
                      ),
                      const DesignText("Please come back later"),
                    ],
                  ),
                  CardSwiper(
                    controller: _swiperController,
                    cardsCount: listPrompt.length,
                    numberOfCardsDisplayed:
                        listPrompt.length < 3 ? listPrompt.length : 3,
                    cardBuilder:
                        (context, index, percentThresholdX, percentThresholdY) {
                      return Container(
                        alignment: Alignment.center,
                        color: Colors.blue,
                        child: const Text('1'),
                      );
                    },
                    allowedSwipeDirection: const AllowedSwipeDirection.only(
                      left: true,
                      right: true,
                    ),
                    onSwipe: (previousIndex, currentIndex, direction) async {
                      if (direction == CardSwiperDirection.right) {
                        return await acceptTermAndCondition(previousIndex);
                      }
                      return true;
                    },
                    isLoop: false,
                    onEnd: () {
                      setState(() {
                        isEnd = true;
                      });
                    },
                  ),
                ],
              ),
            ),
          const Spacer(),
        ],
      ),
    );
  }

  Future<bool> acceptTermAndCondition(int index) async {
    return await showModalBottomSheet<bool>(
          context: context,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(6))),
          isScrollControlled: true,
          isDismissible: false,
          // enableDrag: false,
          // add linear bounce in animation curve
          backgroundColor: Colors.transparent,
          builder: (context) {
            return CommentSheet(
              prompt: listPrompt[index],
            );
          },
        ) ??
        false;
  }
}
