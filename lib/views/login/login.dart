import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:laatte/services/api_services.dart';
import 'package:laatte/ui/custom/confirm_dialog.dart';
import 'package:laatte/ui/theme/text.dart';
import 'package:laatte/utils/assets_names.dart';
import 'package:laatte/utils/design_colors.dart';
import 'package:laatte/utils/extensions.dart';
import 'package:laatte/ui/custom/confirm_sheet.dart';
import '../../common_libs.dart';
import '../../routes.dart';
import '../../ui/custom/custom_text_form.dart';
import '../../ui/theme/buttons.dart';
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
        body: Stack(
          alignment: Alignment.center,
          children: [
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                ),
                child: Image.asset(
                  AssetsName.pngBg,
                  fit: BoxFit.fill,
                  height: double.infinity,
                  width: double.infinity,
                ),
              ),
            ),
            SafeArea(
              child: IntrinsicHeight(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: DesignColor.latteyellowLight3,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Column(
                      children: [
                        Expanded(
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  20.height,
                                  Hero(
                                    tag: AssetsName.appLogo,
                                    child: Image.asset(
                                      AssetsName.appLogo,
                                      height: 160,
                                    ),
                                  ),
                                  30.height,
                                  const DesignText.titleSemiBold(
                                    "Where people meet thru thoughts ",
                                  ),
                                  6.height,
                                  const DesignText.body(
                                    'sign-in to experience new way of dating',
                                  ),
                                  30.height,
                                  DesignFormField(
                                    controller: _phone,
                                    labelText: "Phone",
                                    fillColor: DesignColor.latteyellowLight3,
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
                                        isTappedNotifier:
                                            ValueNotifier<bool>(isloading),
                                        onPressed: () async {
                                          if (formKey.currentState!
                                              .validate()) {
                                            final goRouter =
                                                GoRouter.of(context);
                                            if (!await acceptTermAndCondition) {
                                              setState(() => isloading = false);
                                              return;
                                            }
                                            setState(() => isloading = true);
                                            ApiService()
                                                .otpRequest(phone: _phone.text)
                                                .then((v) {
                                              setState(() => isloading = false);
                                              if (v) {
                                                final String route =
                                                    "${Routes.otpScreen}?phone=${_phone.text}";
                                                goRouter.go(route);
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
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<bool> get acceptTermAndCondition async {
    return await showModalBottomSheet<bool>(
          context: context,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(6))),
          isScrollControlled: true,
          // isDismissible: false,
          // enableDrag: false,
          // add linear bounce in animation curve
          backgroundColor: Colors.transparent,
          builder: (context) {
            return ConfirmSheet(
              title: "Terms&conditions",
              description: Constants.termAndCondition,
              confirmText: "Understood",
              onPressed: () {
                context.pop(true);
              },
            );
          },
        ) ??
        false;
  }
}
