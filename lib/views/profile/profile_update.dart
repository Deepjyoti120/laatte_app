import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:laatte/common_libs.dart';
import 'package:laatte/ui/theme/text.dart';
import 'package:laatte/utils/design_colors.dart';
import 'package:laatte/utils/extensions.dart';
import 'package:laatte/utils/utlis.dart';
import 'package:laatte/viewmodel/bloc/user_report_bloc.dart';
import 'package:laatte/viewmodel/cubit/intro_profile_cubit.dart';

class ProfileUpdateScreen extends StatefulWidget {
  static const String route = "/ProfileUpdateScreen";
  const ProfileUpdateScreen({super.key});

  @override
  State<ProfileUpdateScreen> createState() => _ProfileUpdateScreenState();
}

class _ProfileUpdateScreenState extends State<ProfileUpdateScreen> {
  @override
  void initState() {
    super.initState();
    // context.read<UserReportBloc>().add(UserReportFetched());
  }

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserReportBloc>().state.userReport;
    final appState = context.watch<IntroProfileCubit>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: DesignColor.latteBackground,
        elevation: 0,
        title: const DesignText.title(
          "Update Profile",
          color: DesignColor.primary,
          fontSize: 20,
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(FontAwesomeIcons.arrowLeft,
              color: DesignColor.primary),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    const DesignText.title(
                      "Being with your best photos",
                      textAlign: TextAlign.center,
                      color: DesignColor.primary,
                      fontSize: 24,
                    ),
                    6.height,
                    const DesignText.body(
                      "Upload 2 photos to start. Add 4 or more to make your profile stand out.",
                      fontSize: 18,
                      textAlign: TextAlign.center,
                    ),
                  ],
                )
                    .animate()
                    .fadeIn(
                      duration: const Duration(milliseconds: 600),
                      curve: Curves.easeIn,
                      delay: const Duration(milliseconds: 500),
                    )
                    .slideX(
                      duration: const Duration(seconds: 2),
                      curve: Curves.fastLinearToSlowEaseIn,
                      begin: 2,
                    ),
                20.height,
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: GridView.builder(
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20,
                      childAspectRatio: 1,
                    ),
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 4,
                    itemBuilder: (context, index) {
                      bool ishavePhoto = appState.photos.length > index;
                      if (ishavePhoto && appState.photos[index] != null) {
                        return Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: Image.file(
                                appState.photos[index]!,
                                fit: BoxFit.fill,
                              ),
                            ),
                            Positioned(
                              right: 4,
                              top: 1,
                              child: GestureDetector(
                                onTap: () {
                                  // appState.removePhoto(appState.photos[index]!);
                                  appState.removePhoto(appState.photos[index]!);
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: DesignColor.grey400,
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: const Icon(
                                    FontAwesomeIcons.xmark,
                                    size: 20,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      }
                      return GestureDetector(
                        onTap: () {
                          Utils.pickFiles(type: FileType.image).then((value) {
                            if (value.isNotEmpty) {
                              appState.addPhoto(value.first);
                            }
                          });
                        },
                        child: DottedBorder(
                          color: DesignColor.grey400,
                          strokeWidth: 2,
                          borderType: BorderType.RRect,
                          radius: const Radius.circular(16),
                          child: const Align(
                            alignment: Alignment.center,
                            child: Icon(
                              FontAwesomeIcons.circlePlus,
                              size: 40,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                )
                    .animate()
                    .fadeIn(
                      duration: const Duration(milliseconds: 1000),
                      curve: Curves.easeIn,
                      delay: const Duration(milliseconds: 800),
                    )
                    .slideY(
                      duration: const Duration(seconds: 2),
                      curve: Curves.fastLinearToSlowEaseIn,
                      begin: 2,
                    ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
