import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:laatte/common_libs.dart';
import 'package:laatte/ui/theme/container.dart';
import 'package:laatte/ui/theme/text.dart';
import 'package:laatte/utils/design_colors.dart';
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
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Hero(
                //   tag: chatUser?.id ?? "",
                //   child: GestureDetector(
                //     onTap: () {},
                //     child: Container(
                //       decoration: BoxDecoration(
                //         shape: BoxShape.circle,
                //         border: Border.all(
                //           color: DesignColor.yellow,
                //           width: 2,
                //         ),
                //       ),
                //       width: 54,
                //       height: 54,
                //       child: ClipRRect(
                //         clipBehavior: Clip.antiAlias,
                //         borderRadius: BorderRadius.circular(60),
                //         child: Image.network(
                //           chatUser?.profilePicture ?? "",
                //           alignment: Alignment.center,
                //           fit: BoxFit.fill,
                //         ),
                //       ),
                //     ),
                //   ),
                // ),
                DesignContainer(
                  // width: double.infinity,
                  clipBehavior: Clip.antiAlias,
                  color: DesignColor.latteDarkCard,
                  isColor: true,
                  child: Row(
                    children: [
                      SizedBox(
                        height: 100,
                        child: Hero(
                          tag: chatUser?.id ?? "",
                          child: CachedNetworkImage(
                            imageUrl: chatUser?.profilePicture ?? "",
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Container(
                        height: 100,
                        alignment: Alignment.topLeft,
                        color: DesignColor.latteDarkCard,
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              DesignText.title(
                                chatUser?.name ?? "",
                                color: DesignColor.latteYellowSmall,
                                fontSize: 16,
                                textAlign: TextAlign.center,
                              ),
                              Flexible(
                                child: DesignText.body(
                                  chatUser?.bio ?? "",
                                  color: DesignColor.latteYellowSmall,
                                  fontSize: 16,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
