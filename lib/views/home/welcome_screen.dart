import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:laatte/common_libs.dart';
import 'package:laatte/routes.dart';
import 'package:laatte/services/api_services.dart';
import 'package:laatte/services/token_handler.dart';
import 'package:laatte/ui/custom/confirm_sheet.dart';
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

  void close() async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: DesignText(
            "Logout",
            fontSize: 16,
            fontWeight: 600,
            color: null,
          ),
          content: DesignText(
            "Are you sure you want to logout?",
            fontSize: 14,
            fontWeight: 400,
            color: null,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: DesignText(
                "Cancel",
                fontSize: 14,
                fontWeight: 400,
                color: null,
              ),
            ),
            TextButton(
              onPressed: () {
                final goRouter = GoRouter.of(context);
                TokenHandler.resetJwt().then((value) {
                  goRouter.go(Routes.login);
                });
              },
              child: DesignText(
                "Logout",
                fontSize: 14,
                fontWeight: 400,
                color: null,
              ),
            ),
          ],
        );
      },
    );
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
          GestureDetector(
              onTap: () {
                close();
              },
              child: Text(isEnd ? 'End' : 'Not End')),
          if (listPrompt.isNotEmpty)
            Flexible(
              flex: 2,
              child: CardSwiper(
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
