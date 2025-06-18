import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:laatte/common_libs.dart';
import 'package:laatte/ui/theme/container.dart';
import 'package:laatte/ui/theme/text.dart';
import 'package:laatte/utils/design_colors.dart';
import 'package:laatte/utils/extensions.dart';
import 'package:laatte/utils/utlis.dart';
import 'package:laatte/viewmodel/bloc/socket_bloc.dart';
import 'package:laatte/viewmodel/model/user_reports.dart';

class ProfileScreen extends StatefulWidget {
  static const String route = "/ProfileScreen";
  const ProfileScreen({super.key, required this.userReport});
  final UserReport userReport;
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool showbottomCard = true;
  int currentIndex = 0;
  @override
  void initState() {
    super.initState();
    // context.read<UserReportBloc>().add(UserReportFetched());
  }

  @override
  Widget build(BuildContext context) {
    final chatUser = context.watch<SocketBloc>().state.chatUser;
    return Scaffold(
      appBar: AppBar(
        title: const DesignText(
          "Profile",
          // color: DesignColor.latteYellowSmall,
          // fontSize: 18,
        ),
        // centerTitle: true,
        // backgroundColor: DesignColor.latteDarkCard,
        // elevation: 0,
      ),
      body: SafeArea(
        child: Stack(
          children: [
            PageView.builder(
              itemCount: chatUser?.photos?.length,
              onPageChanged: (index) {
                setState(() {
                  currentIndex = index;
                });
              },
              itemBuilder: (context, index) {
                final data = chatUser?.photos?[index];
                if (data == null) {
                  return const Center(
                    child: DesignText("No photos available"),
                  );
                }
                return GestureDetector(
                  onTap: () {
                    setState(() => showbottomCard = !showbottomCard);
                  },
                  child: Hero(
                    tag: chatUser?.id ?? "",
                    transitionOnUserGestures: false,
                    child: CachedNetworkImage(
                      imageUrl: data.url ?? "",
                      fit: BoxFit.cover,
                      placeholder: (context, url) => const Center(
                        child: CircularProgressIndicator(),
                      ),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                  ),
                );
              },
            ),
            if (showbottomCard)
              Positioned(
                left: 12,
                right: 12,
                bottom: 12,
                child: Column(
                  children: [
                    DesignContainer(
                      // width: double.infinity,
                      clipBehavior: Clip.antiAlias,
                      color: Colors.black,
                      isColor: true,
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                DesignText.title(
                                  chatUser?.name ?? "",
                                  color: DesignColor.latteyellowText,
                                  fontSize: 26,
                                  textAlign: TextAlign.center,
                                ),
                                DesignText.title(
                                  ", ${Utils.dateOfAge(chatUser?.dob).toString()}",
                                  color: DesignColor.latteyellowText,
                                  fontSize: 26,
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                            4.height,
                            DesignText.body(
                              chatUser?.bio ?? "",
                              color: DesignColor.latteyellowText,
                              fontSize: 16,
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                    6.height,
                    DesignText(
                      "${currentIndex + 1} of ${chatUser?.photos?.length ?? 0}",
                      color: Colors.white,
                      fontSize: 14,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
