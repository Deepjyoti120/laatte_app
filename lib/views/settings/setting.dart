import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:laatte/common_libs.dart';
import 'package:laatte/routes.dart';
import 'package:laatte/ui/theme/text.dart';
import 'package:laatte/utils/design_colors.dart';
import 'package:laatte/utils/extensions.dart';

class SettingScreen extends StatefulWidget {
  static const String route = "/SettingScreen";
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
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
                  title: "Edit Profile",
                  onTap: () {
                    context.push(Routes.profileScreen);
                  },
                ),
                const Divider(color: DesignColor.grey300),
                settingsCard(
                  title: "Privacy Policy",
                  onTap: () {},
                ),
                const Divider(color: DesignColor.grey300),
                settingsCard(
                  title: "Notifications",
                  onTap: () {},
                ),
                20.height,
                const DesignText.body(
                  "PREFERENCES",
                  fontWeight: 600,
                ),
                const Divider(color: DesignColor.grey300),
                settingsCard(
                  title: "Appearance",
                  onTap: () {},
                ),
                const Divider(color: DesignColor.grey300),
                settingsCard(
                  title: "Discovery Settings",
                  onTap: () {},
                ),
                20.height,
                const DesignText.body(
                  "SUPPORT",
                  fontWeight: 600,
                ),
                const Divider(color: DesignColor.grey300),
                settingsCard(
                  title: "Give Feedback",
                  onTap: () {},
                ),
                const Divider(color: DesignColor.grey300),
                settingsCard(
                  title: "Help & Support",
                  onTap: () {},
                ),
                const Divider(color: DesignColor.grey300),
                settingsCard(
                  title: "Logout",
                  onTap: () {},
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
    required VoidCallback onTap,
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
              const Icon(
                Icons.arrow_forward_ios,
                color: DesignColor.grey500,
              )
            ],
          ),
        ),
      ),
    );
  }
}
