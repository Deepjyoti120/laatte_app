import 'dart:ui';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:flutter_svg/svg.dart';
import 'package:laatte/common_libs.dart';
import 'package:laatte/services/api_services.dart';
import 'package:laatte/utils/assets_names.dart';
import 'package:laatte/utils/design_colors.dart';
import 'package:laatte/views/home/comment_sheet.dart';
import 'package:laatte/views/relate/relate_card.dart';
import '../../ui/theme/text.dart';
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
  bool isEmpty = false;
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    runInit();
  }

  runInit() async {
    await ApiService().getPrompts().then((value) {
      listPrompt = value;
      isEmpty = listPrompt.isEmpty;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    // final user = context.watch<UserReportBloc>().state;
    // final appState = context.watch<AppStateCubit>();
    return Stack(
      children: [
        if (listPrompt.isNotEmpty &&
            listPrompt[selectedIndex].bgPicture != null &&
            !isEmpty)
          Stack(
            children: [
              Positioned.fill(
                child: Image.network(
                  listPrompt[selectedIndex].bgPicture!,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              // Positioned.fill(
              //   child: BackdropFilter(
              //       filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
              //       child: Container(
              //         color: DesignColor.primary.withOpacity(0.1),
              //       )),
              // ),
            ],
          ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
          child: Column(
            children: [
              const Spacer(),
              if (isEmpty)
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Row(),
                    SvgPicture.asset(
                      AssetsName.svgEmpty,
                      width: 100,
                      height: 100,
                    ),
                    const DesignText(
                      "Please come back later",
                      color: Colors.white,
                    ),
                  ],
                ),
              if (listPrompt.isNotEmpty)
                Flexible(
                  flex: 2,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            AssetsName.svgEmpty,
                            width: 100,
                            height: 100,
                          ),
                          const DesignText(
                            "Please come back later",
                            color: Colors.white,
                          ),
                        ],
                      ),
                      CardSwiper(
                        controller: _swiperController,
                        cardsCount: listPrompt.length,
                        numberOfCardsDisplayed:
                            listPrompt.length < 3 ? listPrompt.length : 3,
                        cardBuilder: (context, index, percentThresholdX,
                            percentThresholdY) {
                          return RelateCard(
                            prompt: listPrompt[index],
                          );
                        },
                        allowedSwipeDirection: const AllowedSwipeDirection.only(
                          up: true,
                          right: true,
                        ),
                        onSwipe:
                            (previousIndex, currentIndex, direction) async {
                          selectedIndex = currentIndex ?? 0;
                          setState(() {});
                          if (direction == CardSwiperDirection.right) {
                            return await acceptSwipe(previousIndex);
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
        ),
      ],
    );
  }

  Future<bool> acceptSwipe(int index) async {
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
