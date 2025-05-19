import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:laatte/common_libs.dart';
import 'package:laatte/ui/theme/text.dart';
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
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              const DesignText.titleSemiBold("Settings"),
              20.height,
              const DesignText.body(
                "ACCOUNT",
              ),
              Divider(
                color: Theme.of(context).colorScheme.surface,
                height: 1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
