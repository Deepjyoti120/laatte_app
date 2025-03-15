import 'package:laatte/common_libs.dart';
import 'package:laatte/services/api_services.dart';
import 'package:laatte/ui/custom/custom_text_form.dart';
import 'package:laatte/ui/theme/text.dart';
import 'package:laatte/utils/design_colors.dart';
import 'package:laatte/utils/extensions.dart';
import 'package:laatte/utils/utlis.dart';
import 'package:laatte/viewmodel/model/prompt.dart';
import '../../ui/theme/buttons.dart';

class MatchingSheet extends StatefulWidget {
  const MatchingSheet({
    Key? key,
    required this.comment,
  }) : super(key: key);
  final Comments comment;
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
                                    .map((e) => Padding(
                                          padding: const EdgeInsets.all(4),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            child: Image.network(
                                              e.url!,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ))
                                    .toList(),
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
                                        .chatStart(
                                      receiverId: widget.comment.user?.id ?? '',
                                    )
                                        .then((v) {
                                      if (!context.mounted) return;
                                      if (v) {
                                        goRouter.pop(v);
                                        Utils.showSnackBar(context, "Matched");
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
