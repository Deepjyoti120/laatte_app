import 'package:laatte/common_libs.dart';
import 'package:laatte/ui/custom/custom_text_form.dart';
import 'package:laatte/ui/theme/text.dart';
import 'package:laatte/utils/design_colors.dart';
import 'package:laatte/utils/extensions.dart';
import '../../ui/theme/buttons.dart';

class CommentSheet extends StatefulWidget {
  const CommentSheet({
    Key? key,
  }) : super(key: key);

  @override
  State<CommentSheet> createState() => _CommentSheetState();
}

class _CommentSheetState extends State<CommentSheet> {
  bool isLoading = false;
  TextEditingController relate = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
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
                        autofocus: true,
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 16, horizontal: 12),
                      ),
                      const SizedBox(height: 10),
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
                            isTappedNotifier: ValueNotifier<bool>(isLoading),
                            // onPressed: () async => onPressed!(),
                            onPressed: () async {},
                            textLabel: "",
                            child: const DesignText(
                              "Relate",
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
    );
  }
}
