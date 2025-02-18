import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:laatte/common_libs.dart';
import 'package:laatte/services/api_services.dart';
import 'package:laatte/ui/custom/custom_text_form.dart';
import 'package:laatte/ui/theme/text.dart';
import 'package:laatte/utils/design_colors.dart';
import 'package:laatte/utils/extensions.dart';
import 'package:laatte/utils/utlis.dart';
import '../../ui/theme/buttons.dart';
import '../../utils/assets_names.dart';

class CreateAccount extends StatefulWidget {
  static const String route = "/CreateAccount";
  const CreateAccount({super.key});

  @override
  State<CreateAccount> createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  bool isloading = false;
  final formKey = GlobalKey<FormState>();
  final name = TextEditingController();
  final username = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();
  final confirmPassword = TextEditingController();
  final phone = TextEditingController();
  bool obscureText = true;

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
        appBar: AppBar(
          elevation: 0,
          title: const DesignText("Create Account"),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Hero(
                  tag: AssetsName.appLogo,
                  child: SvgPicture.asset(
                    AssetsName.appLogo,
                    height: 80,
                  ),
                ),
                10.height,
                const DesignText.titleSemiBold(
                  "Create an admin account",
                ),
                6.height,
                const DesignText.body(
                  "You are about to create an admin account. This account will have full access to the system.",
                  textAlign: TextAlign.center,
                ),
                10.height,
                DesignFormField(
                  controller: name,
                  labelText: "Full name",
                  prefixIcon: const Icon(
                    FontAwesomeIcons.faceSmile,
                    color: DesignColor.grey400,
                  ),
                ),
                10.height,
                DesignFormField(
                  controller: username,
                  labelText: "Username",
                  prefixIcon: const Icon(
                    FontAwesomeIcons.user,
                    color: DesignColor.grey400,
                  ),
                ),
                10.height,
                DesignFormField(
                  controller: email,
                  labelText: "Email",
                  prefixIcon: const Icon(
                    FontAwesomeIcons.envelope,
                    color: DesignColor.grey400,
                  ),
                  validator: (value) => Utils.validateEmail(value),
                ),
                10.height,
                DesignFormField(
                  controller: phone,
                  labelText: "Phone number",
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
                10.height,
                DesignFormField(
                  controller: password,
                  labelText: "Password",
                  prefixIcon: const Icon(
                    FontAwesomeIcons.lock,
                    color: DesignColor.grey400,
                  ),
                  validator: (value) => Utils.validatePassword(value),
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
                10.height,
                DesignFormField(
                  controller: confirmPassword,
                  labelText: "Confirm Password",
                  validator: (value) {
                    if (value?.isEmpty ?? false) {
                      return "Please enter password";
                    }
                    if (password.text != value) {
                      return "Password does not match";
                    }
                    return null;
                  },
                  prefixIcon: const Icon(
                    FontAwesomeIcons.lock,
                    color: DesignColor.grey400,
                  ),
                ),
                10.height,
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
                          if (formKey.currentState?.validate() ?? false) {
                            setState(() => isloading = true);
                            final goRouter = GoRouter.of(context);
                            ApiService()
                                .accountCreate(
                              fullName: name.text,
                              email: email.text,
                              password: password.text,
                              username: username.text,
                              phone: phone.text,
                            )
                                .then((v) {
                              if (mounted) {
                                setState(() => isloading = false);
                              }
                              if (v) {
                                Utils.flutterToast(
                                    'Successfully Account Created');
                                goRouter.pop();
                              }
                            });
                          }
                          //
                        },
                        // isloading: isloading,
                        textLabel: 'Create Account', //'Send Code',
                        child: const DesignText(
                          "Create Account",
                          fontSize: 16,
                          fontWeight: 500,
                          color: Colors.white,
                        )),
                  ),
                ),
                if (Utils.isIOS) 30.height else 20.height
              ],
            ),
          ),
        ),
      ),
    );
  }
}
