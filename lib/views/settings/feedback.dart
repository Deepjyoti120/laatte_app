import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:laatte/common_libs.dart';
import 'package:laatte/routes.dart';
import 'package:laatte/services/api_services.dart';
import 'package:laatte/services/token_handler.dart';
import 'package:laatte/ui/custom/custom_text_form.dart';
import 'package:laatte/ui/theme/buttons.dart';
import 'package:laatte/ui/theme/text.dart';
import 'package:laatte/utils/design_colors.dart';
import 'package:laatte/utils/extensions.dart';
import 'package:laatte/utils/utlis.dart';
import 'package:laatte/viewmodel/cubit/app_cubit.dart';

class FeedbackScreen extends StatefulWidget {
  static const String route = "/FeedbackScreen";
  const FeedbackScreen({super.key});

  @override
  State<FeedbackScreen> createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool isloading = false;
  final TextEditingController feedback = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final appState = context.watch<AppStateCubit>();
    return Form(
      key: formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      onChanged: () {
        formKey.currentState!.validate();
      },
      child: Scaffold(
        backgroundColor: DesignColor.latteBackground,
        appBar: AppBar(
          backgroundColor: DesignColor.latteBackground,
          elevation: 0,
          title: const DesignText.title(
            "Feedback",
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
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  const DesignText.title(
                    "We value your feedback! Please let us know how we can improve.",
                    fontWeight: 400,
                    color: DesignColor.grey900,
                    textAlign: TextAlign.center,
                  ),
                  20.height,
                  DesignFormField(
                    controller: feedback,
                    labelText: "Your Feedback",
                    maxLines: 10,
                    fillColor: DesignColor.latteBackground,
                    minLines: 6,
                    autofocus: true,
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 16, horizontal: 12),
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
                            final goRouter = GoRouter.of(context);
                            ApiService()
                                .feedback(feedback.text)
                                .then((v) async {
                              setState(() => isloading = false);
                              if (v) {
                                Utils.flutterToast(
                                    "Feedback submitted successfully!");
                                goRouter.pop();
                              }
                            });
                          }
                        },
                        textLabel: "Feedback",
                        child: const DesignText(
                          "Feedback",
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

  Widget settingsCard({
    required String title,
    VoidCallback? onTap,
    // Widget? leadingIcon,
    Widget? trailingIcon,
  }) {
    return Material(
      borderRadius: BorderRadius.circular(8),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              DesignText.body(
                title,
                fontWeight: 600,
                color: DesignColor.grey900,
              ),
              SizedBox(
                width: 24,
                height: 24,
                child: trailingIcon ??
                    const Icon(
                      Icons.arrow_forward_ios,
                      color: DesignColor.grey500,
                    ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void close() async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const DesignText(
            "Logout",
            fontSize: 16,
            fontWeight: 600,
            color: null,
          ),
          content: const DesignText(
            "Are you sure you want to logout?",
            fontSize: 14,
            fontWeight: 400,
            color: null,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const DesignText(
                "Cancel",
                fontSize: 14,
                fontWeight: 400,
                color: null,
              ),
            ),
            TextButton(
              onPressed: () {
                final goRouter = GoRouter.of(context);
                TokenHandler.resetJwt().then((value) {
                  goRouter.go(Routes.login);
                });
              },
              child: const DesignText(
                "Logout",
                fontSize: 14,
                fontWeight: 400,
                color: null,
              ),
            ),
          ],
        );
      },
    );
  }
}
