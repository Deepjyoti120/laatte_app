import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:laatte/routes.dart';
import 'package:laatte/services/api_services.dart';
import 'package:laatte/utils/extensions.dart';
import '../../ui/theme/buttons.dart';
import '../../ui/theme/text.dart';
import '../../ui/widgets/progress_circle.dart';
import '../../utils/assets_names.dart';
import '../../utils/constants.dart';
import '../../utils/design_colors.dart';

class OtpScreen extends StatefulWidget {
  static const String route = '/OtpScreen';
  const OtpScreen({super.key, required this.phone});
  final String phone;

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  List<TextEditingController> textEditingController = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
  ];
  StreamController<int> timerStreamController = StreamController<int>();
  Timer? timer;
  // OtpRequestModel? otpRequest;
  final formKey = GlobalKey<FormState>();
  bool isloading = false;
  String message = "Enter the the code\nwe just sent you on your phone number";
  // String verificationId = "";
  // int resendToken = 0;
  void startTimer() {
    int timeLeft = 120;
    timerStreamController.add(120);
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (timeLeft == 0) {
        timer.cancel();
      } else {
        timeLeft--;
        timerStreamController.add(timeLeft);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    super.dispose();
    timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Scaffold(
        body: StreamBuilder<int>(
            stream: timerStreamController.stream,
            builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
              return Padding(
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
                      child: Image.asset(
                        AssetsName.appLogo,
                        height: 60,
                      ),
                    ),
                    30.height,
                    const DesignText.titleSemiBold(
                      "Verify Code",
                    ),
                    6.height,
                    DesignText.body(
                      message,
                      textAlign: TextAlign.center,
                    ),
                    20.height,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: List.generate(
                        6,
                        (index) => OtpInput(
                          textEditingController: textEditingController[index],
                        ),
                      ),
                    ),
                    30.height,
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
                            if (formKey.currentState!.validate()) {
                              setState(() => isloading = true);
                              final goRouter = GoRouter.of(context);
                              ApiService()
                                  .otpLogin(
                                otp: textEditingController
                                    .map((e) => e.text)
                                    .toList()
                                    .join()
                                    .toString(),
                                phone: widget.phone,
                              )
                                  .then((value) {
                                setState(() => isloading = false);
                                if (value) {
                                  goRouter.go(Routes.homeController);
                                } else {
                                  formKey.currentState!.validate();
                                  for (var i = 0;
                                      i < textEditingController.length;
                                      i++) {
                                    textEditingController[i] =
                                        TextEditingController();
                                  }
                                }
                              });
                            }
                          },
                          textLabel: 'Verify',
                          child: isloading
                              ? const DesignProgress(color: Colors.white)
                              : const DesignText(
                                  "Verify",
                                  fontSize: 16,
                                  fontWeight: 500,
                                  color: Colors.white,
                                ),
                        ),
                      ),
                    ),
                    20.height,
                    (snapshot.data != null && (snapshot.data ?? 0) == 0)
                        ? SizedBox(
                            height: 20,
                            child: TextButton(
                                onPressed: () async {
                                  startTimer();
                                  await ApiService()
                                      .otpRequest(phone: widget.phone);
                                },
                                style: TextButton.styleFrom(
                                    padding: EdgeInsets.zero),
                                child: const Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    DesignText.body(
                                      "Didn’t get the Code? ",
                                    ),
                                    DesignText.body(
                                      "Resend",
                                      fontWeight: 400,
                                      color: DesignColor.blue,
                                    ),
                                  ],
                                )),
                          )
                        : Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const DesignText.body(
                                "OTP Resend in ? ",
                              ),
                              DesignText.body(
                                "${snapshot.data ?? 0} sec",
                                fontWeight: 400,
                                color: DesignColor.blue,
                              ),
                            ],
                          ),
                    const Spacer(
                      flex: 3,
                    ),
                  ],
                ),
              );
            }),
      ),
    );
  }
}

class OtpInput extends StatefulWidget {
  const OtpInput({
    Key? key,
    required this.textEditingController,
  }) : super(key: key);

  final TextEditingController textEditingController;
  @override
  State<OtpInput> createState() => _OtpInputState();
}

class _OtpInputState extends State<OtpInput> {
  late bool _isEmpty;
  late FocusNode _focusNode;
  @override
  void initState() {
    super.initState();
    _isEmpty = widget.textEditingController.text.isEmpty;
    _focusNode = FocusNode();
    widget.textEditingController.addListener(_handleTextChanged);
  }

  void _handleTextChanged() {
    setState(() {
      _isEmpty = widget.textEditingController.text.isEmpty;
    });
  }

  void _handleBackspace(KeyEvent event) {
    if (_isEmpty && event.logicalKey == LogicalKeyboardKey.backspace) {
      debugPrint('Backspace pressed, _isEmpty: $_isEmpty');
      _focusNode.requestFocus();
      FocusScope.of(context).previousFocus();
    }
  }

  @override
  void dispose() {
    widget.textEditingController.removeListener(_handleTextChanged);
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 50,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 2),
        child: KeyboardListener(
          focusNode: _focusNode,
          autofocus: true,
          onKeyEvent: _handleBackspace,
          child: TextFormField(
            controller: widget.textEditingController,
            onChanged: (value) {
              if (value.length == 1) {
                _focusNode.nextFocus();
                FocusScope.of(context).nextFocus();
              } else {
                _focusNode.previousFocus();
                FocusScope.of(context).previousFocus();
              }
            },
            onTap: () {
              if (widget.textEditingController.text.isNotEmpty) {
                widget.textEditingController.text =
                    widget.textEditingController.text;
              }
              // else {
              //   _focusNode.previousFocus();
              //   FocusScope.of(context).previousFocus();
              // }
            },
            onTapOutside: (event) {
              final currentFocus = FocusScope.of(context);
              if (currentFocus.focusedChild != null) {
                currentFocus.focusedChild!.unfocus();
              }
            },
            onFieldSubmitted: (_) {
              _focusNode.nextFocus();
              FocusScope.of(context).nextFocus();
            },
            onEditingComplete: () {
              _focusNode.nextFocus();
              FocusScope.of(context).nextFocus();
            },
            validator: (val) {
              if (val == null || val.isEmpty) {
                return "";
              }
              return null;
            },
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            textAlign: TextAlign.center,
            decoration: const InputDecoration(
              filled: true,
              errorStyle: TextStyle(height: 0, color: Colors.transparent),
              isDense: true,
              floatingLabelBehavior: FloatingLabelBehavior.auto,
              contentPadding: EdgeInsets.fromLTRB(12, 12, 12, 12),
              fillColor: DesignColor.grey50,
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: DesignColor.grey300, width: 1),
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: DesignColor.grey300, width: 1),
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
              ),
              border: OutlineInputBorder(
                borderSide: BorderSide(color: DesignColor.grey300, width: 1.0),
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.red, width: 1.0),
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
              ),
            ),
            keyboardType: TextInputType.number,
            inputFormatters: [
              LengthLimitingTextInputFormatter(1),
              FilteringTextInputFormatter.digitsOnly,
            ],
          ),
        ),
      ),
    );
  }
}
