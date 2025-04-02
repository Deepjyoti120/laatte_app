import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:laatte/common_libs.dart';
import 'package:laatte/services/api_services.dart';
import 'package:laatte/ui/custom/custom_text_form.dart';
import 'package:laatte/ui/theme/text.dart';
import 'package:laatte/ui/widgets/interactiveview.dart';
import 'package:laatte/utils/design_colors.dart';
import 'package:laatte/utils/extensions.dart';
import 'package:laatte/viewmodel/model/prompt.dart';
import '../../ui/theme/buttons.dart';

class CommentSheet extends StatefulWidget {
  const CommentSheet({
    Key? key,
    required this.prompt,
  }) : super(key: key);
  final Prompt prompt;
  @override
  State<CommentSheet> createState() => _CommentSheetState();
}

class _CommentSheetState extends State<CommentSheet> {
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
                          "Relate",
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
                                children: (widget.prompt.user?.photos ?? [])
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
                                        .addComment(
                                      comment: relate.text,
                                      prompt: widget.prompt,
                                    )
                                        .then((v) {
                                      goRouter.pop(v);
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
                                  "Sent",
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
