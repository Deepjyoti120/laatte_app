import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:laatte/utils/extensions.dart';
import '../../ui/theme/buttons.dart';
import '../../ui/theme/text.dart';
import '../../ui/widgets/progress_circle.dart';
import '../../utils/assets_names.dart';
import '../../utils/constants.dart';
import '../../utils/design_colors.dart';

class ForgotPassword extends StatefulWidget {
  static const String route = '/ForgotPassword';
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  // final phoneNumber = TextEditingController();
  bool isloading = false;
  final formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    // phoneNumber.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(
                flex: 2,
              ),
              Hero(
                tag: AssetsName.appLogo,
                child: SvgPicture.asset(
                  AssetsName.appLogo,
                  height: 120,
                ),
              ),
              30.height,
              const DesignText.titleSemiBold(
                "Forget Password?",
              ),
              6.height,
              const DesignText.body(
                "If you've forgotten your password, please contact your administrator for assistance.",
                textAlign: TextAlign.center,
              ),
              20.height,
              const Row(),
              // DesignFormField(
              //   controller: phoneNumber,
              //   labelText: "Phone Number",
              //   prefixIcon: const Icon(
              //     FontAwesomeIcons.mobile,
              //     color: DesignColor.grey400,
              //   ),
              //   validator: (value) {
              //     if (value == null || value.isEmpty) {
              //       return "Phone Number Required";
              //     }
              //     if (message.isNotEmpty) {
              //       return message;
              //     }
              //     return null;
              //   },
              //   keyboardType: TextInputType.number,
              //   inputFormatters: [
              //     LengthLimitingTextInputFormatter(10),
              //     FilteringTextInputFormatter.digitsOnly,
              //   ],
              // ),
              // 10.height,
              20.height,
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
                      isTappedNotifier: ValueNotifier<bool>(false),
                      onPressed: () async {
                        context.pop();
                      },
                      textLabel: 'Okay', //'Send Code',
                      child: isloading
                          ? const DesignProgress(color: Colors.white)
                          : const DesignText(
                              "Okay",
                              fontSize: 16,
                              fontWeight: 500,
                              color: Colors.white,
                            )),
                ),
              ),
              const Spacer(flex: 3),
            ],
          ),
        ),
      ),
    );
  }
}
