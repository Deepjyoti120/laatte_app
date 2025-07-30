import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:laatte/common_libs.dart';
import 'package:laatte/routes.dart';
import 'package:laatte/services/token_handler.dart';
import 'package:laatte/ui/theme/text.dart';
import 'package:laatte/utils/design_colors.dart';
import 'package:laatte/utils/extensions.dart';
import 'package:laatte/utils/utils.dart';
import 'package:laatte/viewmodel/bloc/user_report_bloc.dart';
import 'package:laatte/viewmodel/cubit/app_cubit.dart';

class SettingScreen extends StatefulWidget {
  static const String route = "/SettingScreen";
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    final appState = context.watch<AppStateCubit>();
    final user = context.watch<UserReportBloc>().state.userReport;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                const DesignText.titleSemiBold("Settings"),
                30.height,
                const DesignText.body(
                  "ACCOUNT",
                  fontWeight: 600,
                ),
                const Divider(color: DesignColor.grey300),
                settingsCard(
                  title: "My Profile",
                  onTap: () {
                    context.push(Routes.profileScreen, extra: user!);
                  },
                ),
                const Divider(color: DesignColor.grey300),
                settingsCard(
                  title: "Edit Profile",
                  onTap: () {
                    context.push(Routes.profileUpdateScreen);
                  },
                ),
                const Divider(color: DesignColor.grey300),
                settingsCard(
                  title: "Notifications",
                  trailingIcon: Transform.scale(
                    scale: 0.7,
                    child: Switch(
                      activeColor: DesignColor.primary,
                      value: appState.isAllowNotification,
                      onChanged: (value) {
                        appState.isAllowNotification = value;
                      },
                    ),
                  ),
                ),
                // 20.height,
                // const DesignText.body(
                //   "PREFERENCES",
                //   fontWeight: 600,
                // ),
                // const Divider(color: DesignColor.grey300),
                // settingsCard(
                //   title: "Appearance",
                //   onTap: () {},
                // ),
                // const Divider(color: DesignColor.grey300),
                // settingsCard(
                //   title: "Discovery Settings",
                //   onTap: () {},
                // ),
                20.height,
                const DesignText.body(
                  "SUPPORT",
                  fontWeight: 600,
                ),
                const Divider(color: DesignColor.grey300),
                settingsCard(
                  title: "Give Feedback",
                  onTap: () {
                    context.push(Routes.feedbackScreen);
                  },
                ),
                const Divider(color: DesignColor.grey300),
                settingsCard(
                  title: "Privacy Policy",
                  onTap: () {
                    Utils.launchUrl2(url: Constants.privacyPolicy);
                  },
                ),
                const Divider(color: DesignColor.grey300),
                settingsCard(
                  title: "Help & Support",
                  onTap: () {
                    Utils.launchUrl2(url: Constants.helpAndSupport);
                  },
                ),
                const Divider(color: DesignColor.grey300),
                settingsCard(
                  title: "Logout",
                  onTap: () {
                    close();
                  },
                  trailingIcon: const Icon(
                    FontAwesomeIcons.rightFromBracket,
                    size: 18,
                    color: DesignColor.red,
                  ),
                ),
              ],
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
