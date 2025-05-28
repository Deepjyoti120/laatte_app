import 'package:flutter_svg/svg.dart';
import 'package:laatte/common_libs.dart';
import 'package:laatte/utils/assets_names.dart';
import 'package:laatte/utils/design_colors.dart';
import 'package:laatte/utils/extensions.dart';
import 'package:laatte/utils/utlis.dart';
import '../theme/buttons.dart';
import '../theme/text.dart';

class ConfirmSheet extends StatelessWidget {
  const ConfirmSheet({
    Key? key,
    this.isDismissible = true,
    required this.title,
    required this.description,
    this.confirmText = 'Done',
    this.onPressed,
    this.isLoading = false,
    this.assetPath,
  }) : super(key: key);
  final bool isDismissible;
  final String title;
  final String description;
  final String confirmText;
  final VoidCallback? onPressed;
  final bool isLoading;
  final String? assetPath;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: isDismissible,
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
              color: DesignColor.latteyellowLight3,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                Image.asset(
                  assetPath ?? AssetsName.appLogo,
                  height: 80,
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.fromLTRB(30, 14, 30, 14),
                  child: Column(
                    children: [
                      DesignText.title(
                        title,
                        textAlign: TextAlign.center,
                        color: DesignColor.primary,
                      ),
                      const SizedBox(height: 10),
                      DesignText.body(
                        description,
                        textAlign: TextAlign.justify,
                      ),
                      if (onPressed != null) const SizedBox(height: 20),
                      if (onPressed != null)
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
                              onPressed: () async {
                                if (onPressed != null) {
                                  onPressed!();
                                }
                              },
                              textLabel: "",
                              child: DesignText(
                                confirmText,
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
                if (Utils.isIOS) 30.height,
              ],
            ),
          ),
        ],
      ),
    );
  }
}
