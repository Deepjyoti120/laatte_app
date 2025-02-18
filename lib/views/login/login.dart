import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:laatte/services/api_services.dart';
import 'package:laatte/ui/theme/text.dart';
import 'package:laatte/utils/assets_names.dart';
import 'package:laatte/utils/design_colors.dart';
import 'package:laatte/utils/extensions.dart';
import '../../routes.dart';
import '../../ui/custom/custom_text_form.dart';
import '../../ui/theme/buttons.dart';
import '../../ui/widgets/progress_circle.dart';
import '../../utils/constants.dart';
import '../../utils/utlis.dart';

class Login extends StatefulWidget {
  static const String route = "/Login";
  const Login({super.key});
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final email = TextEditingController();
  final password = TextEditingController();
  bool obscureText = true;
  bool isloading = false;
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    setDummyLoginDetails();
  }

  setDummyLoginDetails() {
    if (kDebugMode) {
      email.text = 'deepjyoti120281@gmail.com';
      password.text = 'Deepjyoti120218@';
    }
  }

  @override
  void dispose() {
    super.dispose();
    email.dispose();
    password.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
              child: Center(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Hero(
                          tag: AssetsName.appLogo,
                          child: SvgPicture.asset(
                            AssetsName.appLogo,
                            height: 160,
                          ),
                        ),
                        30.height,
                        const DesignText.titleSemiBold(
                          "Welcome to",
                        ),
                        6.height,
                        const DesignText.body(
                          Constants.appFullName,
                        ),
                        30.height,
                        DesignFormField(
                          controller: email,
                          labelText: "Email",
                          prefixIcon: const Icon(
                            FontAwesomeIcons.envelope,
                            color: DesignColor.grey400,
                          ),
                          // keyboardType: TextInputType.number,
                          // inputFormatters: [
                          //   LengthLimitingTextInputFormatter(10),
                          //   FilteringTextInputFormatter.digitsOnly,
                          // ],
                        ),
                        10.height,
                        DesignFormField(
                          controller: password,
                          labelText: "Password",
                          prefixIcon: const Icon(
                            FontAwesomeIcons.lock,
                            color: DesignColor.grey400,
                          ),
                          obscureText: obscureText,
                          suffixIcon: IconButton(
                            onPressed: () {
                              obscureText = !obscureText;
                              setState(() {});
                            },
                            constraints: const BoxConstraints(),
                            padding: EdgeInsets.zero,
                            icon: Icon(
                              obscureText
                                  ? FontAwesomeIcons.eye
                                  : FontAwesomeIcons.eyeSlash,
                              color: DesignColor.grey400,
                            ),
                          ),
                        ),
                        6.height,
                        Container(
                          alignment: Alignment.centerRight,
                          child: SizedBox(
                            height: 20,
                            child: TextButton(
                              onPressed: () {
                                context.push(Routes.forgotPassword);
                              },
                              style: TextButton.styleFrom(
                                padding: EdgeInsets.zero,
                              ),
                              child: const DesignText.body(
                                "  Forgot Password?  ",
                                fontWeight: 400,
                                color: DesignColor.blue,
                              ),
                            ),
                          ),
                        ),
                        15.height,
                        SizedBox(
                          width: double.infinity,
                          height: 48,
                          child: Hero(
                            tag: Constants.keyLoginButton,
                            child: DesignButtons(
                              color: DesignColor.backgroundBlack,
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
                                      .login(
                                          email: email.text, pwd: password.text)
                                      .then((v) {
                                    setState(() => isloading = false);
                                    if (v) {
                                      goRouter.go(Routes.homeController);
                                    }
                                  });
                                }
                              },
                              textLabel: "Login",
                              // isloading: isloading,
                              child: const DesignText(
                                "Login",
                                fontSize: 16,
                                fontWeight: 500,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        20.height,
                        SizedBox(
                          height: 20,
                          child: TextButton(
                            onPressed: () {
                              context.push(Routes.createAccount);
                            },
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.zero,
                            ),
                            child: const Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                DesignText.body(
                                  "  Don't have an account yet? ",
                                ),
                                DesignText.body(
                                  "Create Account  ",
                                  fontWeight: 400,
                                  color: DesignColor.blue,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            DesignText.body(
              "v${Constants.packageInfo?.version ?? ""}",
              // fontSize: 32,
              fontWeight: 500,
            ),
            if (Utils.isIOS) 30.height else 20.height
          ],
        ),
      ),
    );
  }
}
