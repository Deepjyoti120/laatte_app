import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:laatte/ui/image_crop.dart';
import 'package:laatte/utils/extensions.dart';
import 'package:laatte/utils/utils.dart';
import 'package:laatte/viewmodel/cubit/intro_profile_cubit.dart';
import 'package:provider/provider.dart';
import '../../../ui/theme/text.dart';
import '../../../utils/design_colors.dart';

class SelectPhoto extends StatefulWidget {
  const SelectPhoto({super.key});

  @override
  State<SelectPhoto> createState() => _SelectPhotoState();
}

class _SelectPhotoState extends State<SelectPhoto> {
  @override
  Widget build(BuildContext context) {
    final appState = context.watch<IntroProfileCubit>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        30.height,
        Column(
          children: [
            const DesignText.title(
              "Being with your best photos",
              textAlign: TextAlign.center,
              color: DesignColor.latteyellowDark3,
              fontSize: 24,
            ),
            6.height,
            const DesignText.body(
              "Upload 2 photos to start. Add 4 or more to make your profile stand out.",
              fontSize: 18,
              color: DesignColor.latteyellowDark3,
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
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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
                onTap: _pickImage,
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
        // Padding(
        //   padding: const EdgeInsets.all(20.0),
        //   child: Column(
        //     children: [
        //       DottedBorder(
        //         color: Colors.black,
        //         strokeWidth: 1.5,
        //         borderType: BorderType.RRect,
        //         radius: const Radius.circular(16),
        //         child: SizedBox(
        //           height: 148,
        //           width: 148,
        //           child: Icon(
        //             FontAwesomeIcons.circlePlus,
        //             size: 40,
        //           ),
        //         ),
        //       ),
        //     ],
        //   )
        //       .animate()
        //       .fadeIn(
        //         duration: const Duration(milliseconds: 1000),
        //         curve: Curves.easeIn,
        //         delay: const Duration(milliseconds: 800),
        //       )
        //       .slideY(
        //         duration: const Duration(seconds: 2),
        //         curve: Curves.fastLinearToSlowEaseIn,
        //         begin: 2,
        //       ),
        // ),
      ],
    );
  }

  void _pickImage() async {
    final appState = context.read<IntroProfileCubit>();
    final value = await Utils.pickFiles(type: FileType.image);
    if (value.isEmpty) return;
    if (!mounted) return;
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (ctx) => ImageCropScreen(file: value.first),
      ),
    );
    if (result != null) {
      appState.addPhoto(result);
    }
  }
}
