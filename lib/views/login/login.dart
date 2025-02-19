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
import '../../common_libs.dart';
import '../../routes.dart';
import '../../ui/custom/custom_text_form.dart';
import '../../ui/theme/buttons.dart';
import '../../utils/constants.dart';
import '../../utils/utlis.dart';

class Login extends StatefulWidget {
  static const String route = "/Login";
  const Login({super.key});
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _phone = TextEditingController();
  // final password = TextEditingController();
  // bool obscureText = true;
  bool isloading = false;
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    setDummyLoginDetails();
  }

  setDummyLoginDetails() {
    if (kDebugMode) {
      _phone.text = '8811890749';
      // password.text = 'Deepjyoti120218@';
    }
  }

  @override
  void dispose() {
    super.dispose();
    _phone.dispose();
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
                        "Welcome",
                      ),
                      6.height,
                      const DesignText.body(
                        Constants.appFullName,
                      ),
                      30.height,
                      DesignFormField(
                        controller: _phone,
                        labelText: "Phone",
                        prefixIcon: const Icon(
                          FontAwesomeIcons.phone,
                          color: DesignColor.grey400,
                        ),
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(10),
                          FilteringTextInputFormatter.digitsOnly,
                        ],
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
                                    .otpRequest(phone: _phone.text)
                                    .then((v) {
                                  setState(() => isloading = false);
                                  if (v) {
                                goRouter.go(Routes.otpScreen);
                                  }
                                });
                              }
                            },
                            textLabel: "Continue",
                            child: const DesignText(
                              "Continue",
                              fontSize: 16,
                              fontWeight: 500,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      20.height,
                    ],
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
