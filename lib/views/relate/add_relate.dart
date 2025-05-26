import 'dart:io';
import 'dart:ui';
import 'package:file_picker/file_picker.dart' as file;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:laatte/common_libs.dart';
import 'package:laatte/ui/custom/custom_text_form.dart';
import 'package:laatte/ui/theme/buttons.dart';
import 'package:laatte/ui/theme/container.dart';
import 'package:laatte/ui/theme/text.dart';
import 'package:laatte/ui/widgets/material_icon_button.dart';
import 'package:laatte/ui/widgets/progress_circle.dart';
import 'package:laatte/utils/assets_names.dart';
import 'package:laatte/utils/design_colors.dart';
import 'package:laatte/utils/extensions.dart';
import 'package:laatte/utils/utlis.dart';
import 'package:laatte/viewmodel/cubit/app_cubit.dart';
import 'package:laatte/viewmodel/model/irl.dart';
import 'package:laatte/viewmodel/model/prompt.dart';

import '../../services/api_services.dart';

class AddRelate extends StatefulWidget {
  static const String route = "/AddRelate";
  const AddRelate({super.key});

  @override
  State<AddRelate> createState() => _AddRelateState();
}

class _AddRelateState extends State<AddRelate> with WidgetsBindingObserver {
  final _relate = TextEditingController();
  final _tag = TextEditingController();
  bool isloading = false;
  File? pickImage;
  bool haspermission = false;
  final _formKey = GlobalKey<FormState>();
  Position? _position;
  List<String> tags = [];
  bool isGenerating = false;
  Irl? _irl;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    runInit();
    verifyGPS();
  }

  runInit() async {
    // _districts = await ApiService().districts;
    setState(() {});
    // Geolocator.getPositionStream().listen((v){
    //   print("object -> ${v.latitude}");
    //   _position = v;
    // });
  }

  verifyGPS() async {
    haspermission = await Utils.isAllowGPS();
    if (!haspermission) {
      bool permissionGranted = await Utils.requestLocationPermission();
      if (permissionGranted) {
        _getCurrentLocation();
      } else {}
    } else {
      _getCurrentLocation();
    }
    setState(() {});
  }

  Future<void> _getCurrentLocation() async {
    _position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      verifyGPS();
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appState = context.watch<AppStateCubit>();
    return Form(
      key: _formKey,
      child: Scaffold(
        body: Stack(
          children: [
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                ),
                child: Image.asset(
                  AssetsName.pngBg1,
                  fit: BoxFit.fill,
                  height: double.infinity,
                  width: double.infinity,
                ),
              ),
            ),
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          10.height,
                          const DesignText(
                            "Add Prompt",
                            fontSize: 24,
                            fontWeight: 600,
                          ),
                          10.height,
                          DesignFormField(
                            controller: _relate,
                            labelText: "Something that made you smile today...",
                            maxLines: 10,
                            minLines: 6,
                            maxLength: 180,
                            autofocus: true,
                            style: const TextStyle(color: Colors.black),
                            labelStyle: const TextStyle(color: Colors.black),
                            fillColor: DesignColor.latteyellowLight3,
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 16,
                              horizontal: 12,
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Prompt is required";
                              }
                              if (value.length > 180) {
                                return "Prompt must not exceed 180 characters";
                              }
                              return null;
                            },
                          ),
                          10.height,
                          SizedBox(
                            width: double.infinity,
                            height: 48,
                            child: DesignButtons(
                              color: DesignColor.latteyellowLight3,
                              elevation: 0,
                              fontSize: 16,
                              fontWeight: 500,
                              colorText: Colors.black,
                              isTappedNotifier: ValueNotifier<bool>(false),
                              onPressed: () async {
                                setState(() {
                                  isGenerating = true;
                                });
                                _relate.text = await ApiService()
                                        .generatePrompt(text: _relate.text) ??
                                    "";
                                setState(() {
                                  isGenerating = false;
                                });
                              },
                              textLabel: 'Generate',
                              child: isGenerating
                                  ? Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const DesignProgress.ai(
                                            color: Colors.white),
                                        6.width,
                                        const DesignText(
                                          "Generating",
                                          fontSize: 16,
                                          fontWeight: 500,
                                          color: Colors.black,
                                        ),
                                      ],
                                    )
                                  : const DesignText(
                                      "Generate",
                                      fontSize: 16,
                                      fontWeight: 500,
                                      color: Colors.black,
                                    ),
                            ),
                          ),
                          10.height,
                          Stack(
                            children: [
                              DesignContainer(
                                width: double.infinity,
                                clipBehavior: Clip.antiAlias,
                                bordered: true,
                                borderAllColor: DesignColor.latteyellowLight3,
                                color: DesignColor.latteyellowLight3,
                                isColor: true,
                                child: Column(
                                  children: [
                                    6.height,
                                    const DesignText.body('Upload a Photo'),
                                    if (pickImage == null)
                                      IconButton(
                                          onPressed: () {
                                            Utils.pickFiles(
                                                    type: file.FileType.image)
                                                .then(
                                              (value) {
                                                if (value.isNotEmpty) {
                                                  pickImage = value.first;
                                                  setState(() {});
                                                }
                                              },
                                            );
                                          },
                                          icon: const Icon(
                                            FontAwesomeIcons.camera,
                                          )),
                                    if (pickImage == null)
                                      const Column(
                                        children: [
                                          DesignText.body(
                                            "Note: Image is Required",
                                            color: Colors.red,
                                          ),
                                          // DesignText.body(
                                          //   'Accepted file format include: docx, png, pdf, bmp, png',
                                          // ),
                                        ],
                                      ),
                                    6.height,
                                    if (pickImage != null)
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 4),
                                        child: DesignContainer(
                                          color: DesignColor.grey50,
                                          isColor: true,
                                          padding: const EdgeInsets.fromLTRB(
                                              6, 2, 6, 2),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              ClipRRect(
                                                clipBehavior: Clip.antiAlias,
                                                borderRadius:
                                                    BorderRadius.circular(60),
                                                child: Image.file(
                                                  pickImage!,
                                                  height: 60,
                                                  width: 60,
                                                  fit: BoxFit.cover,
                                                  errorBuilder: (context, error,
                                                      stackTrace) {
                                                    return Container();
                                                  },
                                                ),
                                              ),
                                              MaterialIconButton(
                                                onPressed: () {
                                                  pickImage = null;
                                                  setState(() {});
                                                },
                                                color: DesignColor.grey50,
                                                icon: const Icon(
                                                  Icons.close,
                                                  color: Colors.red,
                                                  size: 20,
                                                ),
                                                size: 24,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                              const Positioned(
                                top: 2,
                                left: 4,
                                child: DesignText(
                                  '*',
                                  fontSize: 16,
                                  fontWeight: 600,
                                  color: Colors.red,
                                ),
                              )
                            ],
                          ),
                          10.height,
                          SizedBox(
                            height: 120, // Adjust to fit 3 rows
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Wrap(
                                direction: Axis.vertical, // 3 items per column
                                spacing: 6,
                                runSpacing: 6,
                                children: Constants.tags.map((e) {
                                  final isSelected = tags.contains(e);
                                  return GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        if (isSelected) {
                                          tags.remove(e);
                                        } else {
                                          tags.add(e);
                                        }
                                      });
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 12, vertical: 6),
                                      margin: const EdgeInsets.only(right: 6),
                                      decoration: BoxDecoration(
                                        color: isSelected
                                            ? DesignColor.primary
                                            : Colors.grey[200],
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: DesignText.body(
                                        e,
                                        color: isSelected
                                            ? Colors.white
                                            : Colors.black,
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                          10.height,
                          Row(
                            children: [
                              const DesignText("#LastNightAt"),
                              6.width,
                              Flexible(
                                child: DesignFormField(
                                  controller: _tag,
                                  labelText: "tag",
                                  isOptional: true,
                                ),
                              ),
                            ],
                          ),
                          10.height,
                          SizedBox(
                            width: double.infinity,
                            height: 48,
                            child: DesignButtons(
                              color: DesignColor.latteyellowLight3,
                              elevation: 0,
                              fontSize: 16,
                              fontWeight: 500,
                              colorText: Colors.black,
                              isTappedNotifier: ValueNotifier<bool>(false),
                              onPressed: () async {},
                              textLabel: 'Choose IRL Location',
                              child: const DesignText(
                                "Choose IRL Location",
                                fontSize: 16,
                                fontWeight: 500,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          10.height,
                          SizedBox(
                            width: double.infinity,
                            height: 48,
                            child: DesignButtons(
                              color: DesignColor.primary,
                              elevation: 0,
                              fontSize: 16,
                              fontWeight: 500,
                              colorText: Colors.white,
                              isTappedNotifier: ValueNotifier<bool>(false),
                              onPressed: () async {
                                if (!haspermission) {
                                  await Geolocator.openLocationSettings();
                                  return;
                                }
                                // final goRouter = GoRouter.of(context);
                                if (_formKey.currentState?.validate() ??
                                    false) {
                                  _formKey.currentState?.save();
                                  if (pickImage == null) {
                                    return Utils.flutterToast(
                                        "Image is required");
                                  }
                                  if (tags.isEmpty) {
                                    return Utils.flutterToast(
                                        "Tags are required");
                                  }
                                  if (_tag.text.isNotEmpty) {
                                    tags.add("LastNightAt${_tag.text}");
                                  }
                                  setState(() => isloading = true);
                                  ApiService()
                                      .addPrompt(
                                    prompt: Prompt(
                                      bgPicture:
                                          await ApiService().upload(pickImage!),
                                      prompt: _relate.text,
                                      latitude: _position?.latitude.toString(),
                                      longitude:
                                          _position?.longitude.toString(),
                                      tags: tags,
                                      irl: _irl,
                                    ),
                                  )
                                      .then((value) {
                                    if (value) {
                                      pickImage = null;
                                      _relate.clear();
                                      tags.clear();
                                      if (mounted) {
                                        setState(() {});
                                      }
                                      Utils.flutterToast(
                                          "Prompt added successfully");
                                      // goRouter.pop(true);
                                    }
                                    setState(() => isloading = false);
                                  });
                                }
                              },
                              textLabel: 'Save',
                              child: haspermission
                                  ? const DesignText(
                                      "Open Location Settings",
                                      fontSize: 16,
                                      fontWeight: 500,
                                      color: Colors.white,
                                    )
                                  : isloading
                                      ? const DesignProgress(
                                          color: Colors.white,
                                        )
                                      : const DesignText(
                                          "Save",
                                          fontSize: 16,
                                          fontWeight: 500,
                                          color: Colors.white,
                                        ),
                            ),
                          ),
                          8.height,
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
