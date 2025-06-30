import 'package:cached_network_image/cached_network_image.dart';
import 'package:laatte/common_libs.dart';
import 'package:laatte/ui/blur_button.dart';
import 'package:laatte/ui/theme/container.dart';
import 'package:laatte/ui/theme/text.dart';
import 'package:laatte/utils/design_colors.dart';
import 'package:laatte/utils/extensions.dart';
import 'package:laatte/utils/utils.dart';
import 'package:laatte/viewmodel/model/user_reports.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

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
    return Stack(
      children: [
        PageView.builder(
          itemCount: widget.userReport.photos?.length,
          onPageChanged: (index) {
            setState(() {
              currentIndex = index;
            });
          },
          itemBuilder: (context, index) {
            final data = widget.userReport.photos?[index];
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
                tag: widget.userReport.id ?? "",
                transitionOnUserGestures: false,
                child: CachedNetworkImage(
                  imageUrl: data.url ?? "",
                  fit: BoxFit.cover,
                  placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
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
                  clipBehavior: Clip.antiAlias,
                  color: Colors.black,
                  isColor: true,
                  alignment: Alignment.topLeft,
                  borderRadius: BorderRadius.circular(50),
                  child: Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            DesignText.title(
                              widget.userReport.name ?? "",
                              color: DesignColor.latteyellowText,
                              fontSize: 26,
                              textAlign: TextAlign.center,
                            ),
                            DesignText.title(
                              ", ${Utils.dateOfAge(widget.userReport.dob).toString()}",
                              color: DesignColor.latteyellowText,
                              fontSize: 26,
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                        4.height,
                        DesignText.body(
                          widget.userReport.bio ?? "",
                          color: DesignColor.latteyellowText,
                          fontSize: 16,
                          textAlign: TextAlign.justify,
                        ),
                      ],
                    ),
                  ),
                ),
                6.height,
                DesignText(
                  "${currentIndex + 1} of ${widget.userReport.photos?.length ?? 0}",
                  color: Colors.white,
                  fontSize: 14,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        Positioned(
          top: 10,
          left: 30,
          child: SafeArea(
              child: BlurBtn(
            icon: PhosphorIcons.arrowLeft(),
            onTap: () {
              context.pop();
            },
            borderRadius: BorderRadius.circular(60),
            padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
          )),
        )
      ],
    );
  }
}
