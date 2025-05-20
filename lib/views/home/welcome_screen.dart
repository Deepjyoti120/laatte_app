import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:laatte/common_libs.dart';
import 'package:laatte/ui/blur_button.dart';
import 'package:laatte/ui/controls/buttons.dart';
import 'package:laatte/utils/assets_names.dart';
import 'package:laatte/utils/design_colors.dart';
import 'package:laatte/utils/extensions.dart';
import 'package:laatte/viewmodel/bloc/my_prompts_bloc.dart';
import 'package:laatte/viewmodel/cubit/app_cubit.dart';
import 'package:laatte/viewmodel/model/prompt.dart';
import 'package:laatte/views/home/comment_sheet.dart';
import 'package:laatte/views/irl/irl.dart';
import 'package:laatte/views/relate/relate_card.dart';
import '../../ui/theme/text.dart';

class WelcomeScreen extends StatefulWidget {
  static const String route = "/WelcomeScreen";
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final CardSwiperController _swiperController = CardSwiperController();

  bool isEnd = false;
  // List<Prompt> listPrompt = [];
  // bool isEmpty = false;
  int selectedIndex = 0;
  bool showFullPreview = false;

  @override
  void initState() {
    super.initState();
    runInit();
  }

  runInit() async {
    // await ApiService().getPrompts().then((value) {
    //   listPrompt = value;
    //   isEmpty = listPrompt.isEmpty;
    //   if (mounted) {
    //     setState(() {});
    //   }
    // });
    context.read<MyPromptsBloc>().add(const ListPromptsFetched());
  }

  @override
  Widget build(BuildContext context) {
    // final user = context.watch<UserReportBloc>().state;
    final prompt = context.watch<MyPromptsBloc>().state;
    final appState = context.watch<AppStateCubit>();
    if (appState.goIrl) {
      return const IrlScreen();
    }
    return SizedBox(
      // color: Colors.black,
      width: double.infinity,
      child: Stack(
        children: [
          Image.asset(
            AssetsName.pngBg,
            fit: BoxFit.fill,
            height: double.infinity,
            width: double.infinity,
          ),
          SizedBox(
            height: 0,
            width: 0,
            child: Column(
              children: prompt.listPrompt.map((e) {
                if (e.bgPicture != null) {
                  return CachedNetworkImage(
                    imageUrl: e.bgPicture!,
                    height: 0,
                    width: 0,
                  );
                }
                return const SizedBox();
              }).toList(),
            ),
          ),
          if (prompt.listPrompt.isNotEmpty &&
              prompt.listPrompt[selectedIndex].bgPicture != null &&
              !prompt.isEmpty)
            Stack(
              children: [
                if (!isEnd)
                  Positioned.fill(
                    child: CachedNetworkImage(
                      imageUrl: prompt.listPrompt[selectedIndex].bgPicture!,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Center(
                        child: Container(
                          color: Colors.black,
                          child: const Center(
                            child: CircularProgressIndicator(
                              color: DesignColor.primary,
                            ),
                          ),
                        ),
                      ),
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
          if (!showFullPreview)
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
              child: Column(
                children: [
                  const Spacer(),
                  if (prompt.isEmpty)
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
                  if (prompt.listPrompt.isNotEmpty)
                    Flexible(
                      flex: 2,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          if (isEnd)
                            SizedBox(
                              width: double.infinity,
                              child: Column(
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
                            ),
                          if (!isEnd)
                            CardSwiper(
                              controller: _swiperController,
                              cardsCount: prompt.listPrompt.length,
                              numberOfCardsDisplayed:
                                  prompt.listPrompt.length < 3
                                      ? prompt.listPrompt.length
                                      : 3,
                              cardBuilder: (context, index, percentThresholdX,
                                  percentThresholdY) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Spacer(flex: 2),
                                    RelateCard(
                                      prompt: prompt.listPrompt[index],
                                    ),
                                    const Spacer(),
                                  ],
                                );
                              },
                              allowedSwipeDirection:
                                  const AllowedSwipeDirection.only(
                                up: true,
                                right: true,
                              ),
                              onSwipe: (previousIndex, currentIndex,
                                  direction) async {
                                selectedIndex = currentIndex ?? 0;
                                setState(() {});
                                if (direction == CardSwiperDirection.right) {
                                  return await acceptSwipe(previousIndex,
                                      prompt: prompt.listPrompt[previousIndex]);
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
          if (appState.irl != null)
            Positioned(
              top: 90,
              left: 30,
              child: Row(
                children: [
                  const Icon(
                    // FontAwesomeIcons.locationPin, need border
                    FontAwesomeIcons.locationDot,
                    color: Colors.white,
                    size: 16,
                  ),
                  6.width,
                  DesignText(
                    appState.irl?.name ?? '',
                    color: Colors.white,
                  )
                ],
              ),
            ),
          if (prompt.listPrompt.isNotEmpty)
            Positioned(
              top: 50,
              left: 18,
              child: Transform.scale(
                scale: 0.7,
                child: Switch(
                  value: showFullPreview,
                  onChanged: (value) {
                    setState(() {
                      showFullPreview = value;
                      // prompt.isEmpty = false;
                      context
                          .read<MyPromptsBloc>()
                          .add(const ListPromptsSetEmpty(isEmpty: false));
                      isEnd = false;
                    });
                  },
                ),
              ),
            ),
          // if (prompt.listPrompt.isNotEmpty)
          Positioned(
            top: 60,
            right: 30,
            child: BlurBtn(
              title: appState.irl == null ? "Go IRL" : "Go Normal",
              icon: appState.irl == null
                  ? FontAwesomeIcons.locationArrow
                  : FontAwesomeIcons.xmark,
              onTap: () {
                // context.push(Routes.irlScreen);
                appState.goIrl = !appState.goIrl;
              },
            ),
          )
        ],
      ),
    );
  }

  Future<bool> acceptSwipe(int index, {required Prompt prompt}) async {
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
              prompt: prompt,
            );
          },
        ) ??
        false;
  }
}
