import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:laatte/common_libs.dart';
import 'package:laatte/routes.dart';
import 'package:laatte/services/api_services.dart';
import 'package:laatte/ui/custom/custom_text_form.dart';
import 'package:laatte/ui/theme/text.dart';
import 'package:laatte/ui/widgets/interactiveview.dart';
import 'package:laatte/utils/design_colors.dart';
import 'package:laatte/utils/extensions.dart';
import 'package:laatte/utils/utlis.dart';
import 'package:laatte/viewmodel/bloc/socket_bloc.dart';
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
    return Form(
      key: formKey,
      child: Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(
              onTap: () {
                context.pop();
              },
              child: Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(60)),
                  child: Container(
                    alignment: Alignment.center,
                    child: const Icon(Icons.close, color: Colors.white),
                  )),
            ),
            const SizedBox(height: 12),
            Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(16),
                ),
                color: DesignColor.backgroundColor,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(30, 14, 30, 14),
                    child: Column(
                      children: [
                        const DesignText.title(
                          "Match now",
                          textAlign: TextAlign.center,
                          color: DesignColor.primary,
                        ),
                        const SizedBox(height: 10),
                        DesignFormField(
                          controller: relate,
                          labelText: "Relate",
                          maxLines: 10,
                          minLines: 6,
                          readOnly: isConfirm,
                          autofocus: true,
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 16, horizontal: 12),
                        ),
                        if (isConfirm) const SizedBox(height: 10),
                        if (isConfirm)
                          SizedBox(
                            height: 100,
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: (widget.comment.user?.photos ?? [])
                                    .asMap()
                                    .entries
                                    .map((entry) {
                                  int index = entry.key;
                                  var e = entry.value;
                                  return Padding(
                                    padding: const EdgeInsets.all(4),
                                    child: GestureDetector(
                                      onTap: index == 0
                                          ? () {
                                              if (e.url != null) {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        InteractiveView(
                                                            preview:
                                                                e.url ?? ''),
                                                  ),
                                                );
                                              }
                                            }
                                          : null, // Disable tap for other images
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: index == 0
                                            ? CachedNetworkImage(
                                                imageUrl: e.url!,
                                                fit: BoxFit.cover,
                                              )
                                            : ImageFiltered(
                                                imageFilter: ImageFilter.blur(
                                                    sigmaX: 5,
                                                    sigmaY: 5), // Blur effect
                                                child: CachedNetworkImage(
                                                  imageUrl: e.url!,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                        // SizedBox(
                        //   height: 100,
                        //   child: SingleChildScrollView(
                        //     scrollDirection: Axis.horizontal,
                        //     child: Row(
                        //       children: (widget.comment.user?.photos ?? [])
                        //           .map((e) => Padding(
                        //                 padding: const EdgeInsets.all(4),
                        //                 child: ClipRRect(
                        //                   borderRadius:
                        //                       BorderRadius.circular(8),
                        //                   child: Image.network(
                        //                     e.url!,
                        //                     fit: BoxFit.cover,
                        //                   ),
                        //                 ),
                        //               ))
                        //           .toList(),
                        //     ),
                        //   ),
                        // ),
                        if (isConfirm) const SizedBox(height: 10),
                        if (isConfirm)
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
                                isTappedNotifier:
                                    ValueNotifier<bool>(isLoading),
                                onPressed: () async {
                                  if (formKey.currentState?.validate() ??
                                      false) {
                                    final goRouter = GoRouter.of(context);
                                    ApiService()
                                        .chatStart(
                                      receiverId: widget.comment.user?.id ?? '',
                                      prompt: widget.prompt,
                                      comment: widget.comment,
                                    )
                                        .then((v) {
                                      if (!context.mounted) return;
                                      final isSuccess = v != null;
                                      if (isSuccess) {
                                        goRouter.pop(isSuccess);
                                        context.push(Routes.matchingScreen,
                                            extra: v);
                                        // Utils.showSnackBar(context, "Matched");
                                      } else {
                                        Utils.showSnackBar(
                                            context, "Failed to match");
                                      }
                                    });
                                  }
                                },
                                textLabel: "",
                                child: const DesignText(
                                  "Confirm",
                                  fontSize: 16,
                                  fontWeight: 500,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          )
                        else
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
                                isTappedNotifier:
                                    ValueNotifier<bool>(isLoading),
                                onPressed: () async {
                                  isConfirm = true;
                                  setState(() {});
                                },
                                textLabel: "",
                                child: const DesignText(
                                  "Match",
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
                  10.height,
                  // if (Utils.isIOS) 30.height,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
