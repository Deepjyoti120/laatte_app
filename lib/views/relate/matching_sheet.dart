import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:laatte/common_libs.dart';
import 'package:laatte/routes.dart';
import 'package:laatte/services/api_services.dart';
import 'package:laatte/ui/custom/custom_text_form.dart';
import 'package:laatte/ui/theme/container.dart';
import 'package:laatte/ui/theme/text.dart';
import 'package:laatte/ui/widgets/interactiveview.dart';
import 'package:laatte/utils/design_colors.dart';
import 'package:laatte/utils/extensions.dart';
import 'package:laatte/utils/utils.dart';
import 'package:laatte/viewmodel/model/prompt.dart';
import '../../ui/theme/buttons.dart';

class MatchingSheet extends StatefulWidget {
  const MatchingSheet({
    Key? key,
    required this.comment,
    required this.prompt,
  }) : super(key: key);
  final Comment comment;
  final Prompt prompt;
  @override
  State<MatchingSheet> createState() => _MatchingSheetState();
}

class _MatchingSheetState extends State<MatchingSheet> {
  bool isLoading = false;
  TextEditingController relate = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool isConfirm = false;

  @override
  Widget build(BuildContext context) {
    final promptUser = widget.comment.user;
    return Form(
      key: formKey,
      child: Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(40, 40, 40, 10),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: Colors.white.withOpacity(0.4),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(30, 14, 30, 0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextFormField(
                                controller: relate,
                                autofocus: true,
                                onTapOutside: (event) {
                                  FocusScope.of(context).unfocus();
                                },
                                style: const TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.transparent,
                                  hintStyle: const TextStyle(
                                    color: Colors.white54,
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: BorderSide.none,
                                  ),
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 16, horizontal: 12),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Divider(
                          height: 1,
                          color: Colors.white.withOpacity(0.4),
                        ),
                        8.height,
                        Padding(
                          padding: const EdgeInsets.fromLTRB(30, 0, 30, 14),
                          child: Column(
                            children: [
                              if (isConfirm)
                                SizedBox(
                                    width: double.infinity,
                                    height: 48,
                                    child: TextButton(
                                        onPressed: () {
                                          if (formKey.currentState
                                                  ?.validate() ??
                                              false) {
                                            final goRouter =
                                                GoRouter.of(context);
                                            ApiService()
                                                .chatStart(
                                              receiverId:
                                                  widget.comment.user?.id ?? '',
                                              prompt: widget.prompt,
                                              comment: widget.comment,
                                            )
                                                .then((v) {
                                              if (!context.mounted) return;
                                              final isSuccess = v != null;
                                              if (isSuccess) {
                                                goRouter.pop(isSuccess);
                                                context.push(
                                                    Routes.matchingScreen,
                                                    extra: v);
                                              } else {
                                                Utils.showSnackBar(
                                                    context, "Failed to match");
                                              }
                                            });
                                          }
                                        },
                                        child: const DesignText.title(
                                          "Confirm",
                                          color: DesignColor.primary,
                                        )))
                              else
                                SizedBox(
                                  height: 48,
                                  child: TextButton(
                                      onPressed: () {
                                        if (formKey.currentState?.validate() ??
                                            false) {
                                          isConfirm = true;
                                          setState(() {});
                                        }
                                      },
                                      child: const DesignText.title(
                                        "Match",
                                        color: DesignColor.primary,
                                      )),
                                ),
                            ],
                          ),
                        ),
                        10.height,
                      ],
                    ),
                  ),
                ),
              ),
            ),
            if (isConfirm) 40.height,
            if (promptUser != null)
              AnimatedContainer(
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeInOut,
                height: isConfirm ? 180 : 0,
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: DesignColor.latteCream,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 10),
                      SizedBox(
                        height: 160,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: DesignContainer(
                            width: double.infinity,
                            clipBehavior: Clip.antiAlias,
                            color: DesignColor.latteDarkCard,
                            isColor: true,
                            child: Row(
                              children: [
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => InteractiveView(
                                            preview:
                                                promptUser.profilePicture ?? '',
                                          ),
                                        ),
                                      );
                                    },
                                    child: Hero(
                                      tag: promptUser.profilePicture ?? "",
                                      child: CachedNetworkImage(
                                        imageUrl:
                                            promptUser.profilePicture ?? "",
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Container(
                                    color: DesignColor.latteGreyDark,
                                    child: Padding(
                                      padding: const EdgeInsets.all(20.0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          DesignText.title(
                                            "${promptUser.name ?? ""}, ${Utils.dateOfAge(promptUser.dob).toString()}",
                                            color:
                                                DesignColor.latteGreyDarkText,
                                            // fontSize: 16,
                                            textAlign: TextAlign.center,
                                          ),
                                          DesignText(
                                            promptUser.bio ?? "",
                                            color:
                                                DesignColor.latteGreyDarkText,
                                            // fontSize: 16,
                                            textAlign: TextAlign.center,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
