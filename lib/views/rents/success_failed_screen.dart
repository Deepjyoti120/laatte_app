import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:laatte/services/api_services.dart';
import 'package:laatte/ui/widgets/progress_circle.dart';
import 'package:laatte/utils/extensions.dart';
import 'package:lottie/lottie.dart';
import '../../ui/theme/buttons.dart';
import '../../ui/theme/text.dart';
import '../../utils/assets_names.dart';
import '../../utils/design_colors.dart';

class SuccessFailedScreen extends StatefulWidget {
  static const String route = '/SuccessFailedScreen';
  const SuccessFailedScreen({
    super.key,
    this.data,
    required this.isSuccess,
    required this.message,
  });
  final Map? data;
  final bool isSuccess;
  final String message;

  @override
  State<SuccessFailedScreen> createState() => _SuccessFailedScreenState();
}

class _SuccessFailedScreenState extends State<SuccessFailedScreen> {
  bool isSuccess = false;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    isSuccess = widget.isSuccess;
    paymentVerify();
  }

  paymentVerify() async {
    // if (isSuccess) {
    //   ApiService().paymentSuccess(data: widget.data!).then((v) {
    //     isSuccess = v;
    //     setState(() => isLoading = false);
    //   });
    // } else {
    //   ApiService().paymentFailed(data: widget.data!).then((v) {
    //     setState(() => isLoading = false);
    //   });
    // }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return PopScope(
          canPop: !isLoading,
          child: const Scaffold(body: Center(child: DesignProgress())));
    }
    return PopScope(
      canPop: !isLoading,
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset(
                isSuccess ? AssetsName.jsonSuccess : AssetsName.jsonError,
                height: 200,
                width: 200,
                repeat: false,
              ),
              DesignText.titleSemiBold(
                isSuccess ? 'Payment Successful' : 'Payment Failed',
                textAlign: TextAlign.center,
              ),
              6.height,
              DesignText.body(
                widget.message,
                textAlign: TextAlign.center,
                fontSize: 16,
              ),
              20.height,
              SizedBox(
                width: double.infinity,
                height: 48,
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
                  textLabel: "Back",
                  child: const DesignText(
                    "Back",
                    fontSize: 16,
                    fontWeight: 500,
                    color: Colors.white,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
