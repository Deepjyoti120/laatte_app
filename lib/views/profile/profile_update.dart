import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:laatte/common_libs.dart';
import 'package:laatte/services/api_services.dart';
import 'package:laatte/ui/custom/custom_text_form.dart';
import 'package:laatte/ui/theme/buttons.dart';
import 'package:laatte/ui/theme/container.dart';
import 'package:laatte/ui/theme/text.dart';
import 'package:laatte/utils/assets_names.dart';
import 'package:laatte/utils/design_colors.dart';
import 'package:laatte/utils/enums.dart';
import 'package:laatte/utils/extensions.dart';
import 'package:laatte/utils/utlis.dart';
import 'package:laatte/viewmodel/bloc/user_report_bloc.dart';
import 'package:laatte/viewmodel/cubit/profile_update_cubit.dart';
import 'package:laatte/viewmodel/model/file_link_pair.dart';
import 'package:file_picker/file_picker.dart' as fp;

class ProfileUpdateScreen extends StatefulWidget {
  static const String route = "/ProfileUpdateScreen";
  const ProfileUpdateScreen({super.key});

  @override
  State<ProfileUpdateScreen> createState() => _ProfileUpdateScreenState();
}

class _ProfileUpdateScreenState extends State<ProfileUpdateScreen> {
  bool isloading = false;
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    // context.read<UserReportBloc>().add(UserReportFetched());
    runInit();
  }

  void runInit() async {
    final user = context.read<UserReportBloc>().state.userReport;
    final profile = context.read<ProfileUpdateCubit>();
    profile.setUpdateData(user);
  }

  @override
  Widget build(BuildContext context) {
    // final user = context.watch<UserReportBloc>().state.userReport;
    final profile = context.watch<ProfileUpdateCubit>();
    return Form(
      key: formKey,
      child: Scaffold(
        backgroundColor: DesignColor.latteBackground,
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
            icon: const Icon(
              FontAwesomeIcons.arrowLeft,
              color: DesignColor.primary,
            ),
            onPressed: () {
              context.pop();
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
                  8.height,
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
                        bool ishavePhoto = profile.photos.length > index;
                        if (ishavePhoto && profile.photos[index] != null) {
                          return Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(16),
                                child: profile.photos[index]?.link != null
                                    ? CachedNetworkImage(
                                        imageUrl: profile.photos[index]!.link!,
                                        fit: BoxFit.fill,
                                      )
                                    : Image.file(
                                        profile.photos[index]!.file!,
                                        fit: BoxFit.fill,
                                      ),
                              ),
                              Positioned(
                                right: 4,
                                top: 1,
                                child: GestureDetector(
                                  onTap: () {
                                    // appState.removePhoto(appState.photos[index]!);
                                    profile.removePhoto(profile.photos[index]!);
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
                            Utils.pickFiles(type: fp.FileType.image)
                                .then((value) {
                              if (value.isNotEmpty) {
                                profile.addPhoto(FileLinkPair(
                                  file: value.first,
                                  link: null,
                                ));
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
                  8.height,
                  DesignFormField(
                    controller: profile.name,
                    labelText: "Name",
                    fillColor: DesignColor.latteBackground,
                    // autofocus: true,
                    prefixIcon: const Icon(
                      FontAwesomeIcons.circleUser,
                      color: DesignColor.grey400,
                    ),
                    contentPadding: const EdgeInsets.symmetric(vertical: 16),
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
                  16.height,
                  DesignFormField(
                    controller: profile.occupation,
                    labelText: "Occupation",
                    autofocus: true,
                    fillColor: DesignColor.latteBackground,
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 16, horizontal: 12),
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
                  16.height,
                  DesignFormField(
                    controller: profile.education,
                    labelText: "Education",
                    autofocus: true,
                    fillColor: DesignColor.latteBackground,
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 16, horizontal: 12),
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
                  16.height,
                  DesignFormField(
                    controller: profile.bio,
                    labelText: "Bio",
                    maxLines: 10,
                    fillColor: DesignColor.latteBackground,
                    minLines: 6,
                    autofocus: true,
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 16, horizontal: 12),
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
                  16.height,
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          GestureDetector(
                            onTap: () {
                              profile.gender = GenderTypes.male; //#9CD322
                            },
                            child: Column(
                              children: [
                                DesignContainer(
                                  height: 100,
                                  width: 100,
                                  borderRadius: BorderRadius.circular(15),
                                  blurRadius: 20,
                                  child: Padding(
                                    padding: const EdgeInsets.all(22.0),
                                    child: SvgPicture.asset(
                                      AssetsName.svgGenderMale,
                                      colorFilter: ColorFilter.mode(
                                        profile.gender == GenderTypes.male
                                            ? DesignColor.primary
                                            : DesignColor.backgroundBlack,
                                        BlendMode.srcIn,
                                      ),
                                    ),
                                  ),
                                ),
                                8.height,
                                const DesignText(
                                  "Male",
                                  fontSize: 12,
                                  fontWeight: 600,
                                )
                              ],
                            ),
                          ),
                          Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  profile.gender = GenderTypes.female;
                                },
                                child: DesignContainer(
                                  height: 100,
                                  width: 100,
                                  blurRadius: 20,
                                  borderRadius: BorderRadius.circular(15),
                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: SvgPicture.asset(
                                      AssetsName.svgGenderFemale,
                                      colorFilter: ColorFilter.mode(
                                        profile.gender == GenderTypes.female
                                            ? DesignColor.primary
                                            : DesignColor.backgroundBlack,
                                        BlendMode.srcIn,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              8.height,
                              const DesignText("Female",
                                  fontSize: 12, fontWeight: 600),
                            ],
                          ),
                        ],
                      ),
                      10.height,
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                profile.gender = GenderTypes.other;
                              },
                              child: DesignContainer(
                                height: 100,
                                width: 100,
                                borderRadius: BorderRadius.circular(15),
                                blurRadius: 20,
                                child: Padding(
                                  padding: const EdgeInsets.all(14.0),
                                  child: SvgPicture.asset(
                                    AssetsName.svgGenderIntersex,
                                    colorFilter: ColorFilter.mode(
                                      profile.gender == GenderTypes.other
                                          ? DesignColor.primary
                                          : DesignColor.backgroundBlack,
                                      BlendMode.srcIn,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            8.height,
                            const DesignText("Other",
                                fontSize: 12, fontWeight: 600),
                          ],
                        ),
                      ),
                    ],
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
                  30.height,
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: Hero(
                      tag: Constants.keyLoginButton,
                      child: DesignButtons(
                        color: DesignColor.primary,
                        elevation: 0,
                        fontSize: 16,
                        fontWeight: 500,
                        colorText: Colors.white,
                        isTappedNotifier: ValueNotifier<bool>(isloading),
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            setState(() => isloading = true);
                            final profileCtx = context.read<UserReportBloc>();
                            ApiService().editProfile(profile).then((v) async {
                              profileCtx.add(UserReportFetched());
                              setState(() => isloading = false);
                              if (v) {
                                Utils.flutterToast(
                                  "Profile updated successfully",
                                );
                              }
                            });
                          }
                        },
                        textLabel: "Update",
                        child: const DesignText(
                          "Update",
                          fontSize: 16,
                          fontWeight: 500,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
