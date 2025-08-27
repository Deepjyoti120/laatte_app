import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:laatte/common_libs.dart';
import 'package:laatte/services/api_services.dart';
import 'package:laatte/ui/blur_button.dart';
import 'package:laatte/utils/assets_names.dart';
import 'package:laatte/utils/design_colors.dart';
import 'package:laatte/utils/enums.dart';
import 'package:laatte/utils/extensions.dart';
import 'package:laatte/viewmodel/bloc/my_prompts_bloc.dart';
import 'package:laatte/viewmodel/cubit/app_cubit.dart';
import 'package:laatte/viewmodel/model/prompt.dart';
import 'package:laatte/views/home/comment_sheet.dart';
import 'package:laatte/views/home/filter_dialog.dart';
import 'package:laatte/views/irl/irl.dart';
import 'package:laatte/views/relate/relate_card.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
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
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final appState = context.read<AppStateCubit>().state;
      final myPromptsBloc = context.read<MyPromptsBloc>();
      final prompts = await ApiService()
          .getPrompts(irls: appState.isIrlMode ? appState.irlsPreLoad : []);
      myPromptsBloc.add(ListPromptsFetched(prompts: prompts));
    });
  }

  @override
  Widget build(BuildContext context) {
    // final user = context.watch<UserReportBloc>().state;
    final prompt = context.watch<MyPromptsBloc>().state;
    final appState = context.watch<AppStateCubit>();
    if (appState.goIrl) {
      return IrlScreen(
        onUpdate: () {
          isEnd = false;
          setState(() {});
        },
      );
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
              ],
            ),
          if (!showFullPreview)
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
              child: Column(
                children: [
                  const Spacer(),
                  if (prompt.listPrompt.isNotEmpty)
                    Flexible(
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
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
                                      height: 200,
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
                                Prompt data = prompt.listPrompt[previousIndex];
                                bool isAd =
                                    PromptTypes.advertise.name == data.type;
                                if (!isAd) {
                                  if (direction == CardSwiperDirection.right) {
                                    bool isAccepted = await acceptSwipe(
                                        previousIndex,
                                        prompt: data);
                                    if (isAccepted) {
                                      selectedIndex = currentIndex ?? 0;
                                      setState(() {});
                                    }
                                    return isAccepted;
                                  }
                                }
                                selectedIndex = currentIndex ?? 0;
                                setState(() {});
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
          if (appState.isIrlMode)
            Positioned(
              top: 110,
              left: 30,
              child: Row(
                children: [
                  const Icon(
                    FontAwesomeIcons.locationDot,
                    color: Colors.white,
                    size: 20,
                  ),
                  6.width,
                  if (selectedIndex < prompt.listPrompt.length && !isEnd)
                    DesignText(
                      prompt.listPrompt[selectedIndex].irl?.name ?? '',
                      color: Colors.white,
                      fontSize: 20,
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
                      context
                          .read<MyPromptsBloc>()
                          .add(const ListPromptsSetEmpty(isEmpty: false));
                      isEnd = false;
                    });
                  },
                ),
              ),
            ),
          Positioned(
            top: 60,
            right: 30,
            child: Row(
              children: [
                SizedBox(
                  height: 26,
                  child: BlurBtn(
                    icon: PhosphorIcons.sliders(),
                    onTap: () {
                      showFilter(2, prompt: Prompt());
                    },
                  ),
                ),
                6.width,
                SizedBox(
                  height: 26,
                  child: BlurBtn(
                    title: !appState.isIrlMode ? "Go IRL" : "Go Normal",
                    icon: !appState.isIrlMode
                        ? FontAwesomeIcons.locationArrow
                        : FontAwesomeIcons.xmark,
                    onTap: () {
                      appState.goIrl = !appState.goIrl;
                    },
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Future<bool> showFilter(int index, {required Prompt prompt}) async {
    return await showDialog<bool>(
          context: context,
          barrierColor: Colors.black.withOpacity(0.6),
          builder: (context) {
            return Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              backgroundColor: Colors.transparent,
              child: const FilterDialog(),
            );
          },
        ) ??
        false;
  }

  Future<bool> acceptSwipe(int index, {required Prompt prompt}) async {
    return await showModalBottomSheet<bool>(
          context: context,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(6))),
          isScrollControlled: true,
          isDismissible: true,
          // enableDrag: false,
          // add linear bounce in animation curve
          backgroundColor: Colors.transparent,
          builder: (context) {
            return CommentSheet(prompt: prompt);
          },
        ) ??
        false;
  }
}
