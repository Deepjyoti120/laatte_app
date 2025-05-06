import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:laatte/common_libs.dart';
import 'package:laatte/services/api_services.dart';
import 'package:laatte/ui/blur_button.dart';
import 'package:laatte/ui/theme/buttons.dart';
import 'package:laatte/ui/theme/text.dart';
import 'package:laatte/utils/design_colors.dart';
import 'package:laatte/utils/extensions.dart';
import 'package:laatte/viewmodel/cubit/app_cubit.dart';

class IrlScreen extends StatefulWidget {
  static const String route = "/IrlScreen";
  const IrlScreen({super.key});

  @override
  State<IrlScreen> createState() => _IrlScreenState();
}

class _IrlScreenState extends State<IrlScreen> {
  @override
  void initState() {
    super.initState();
    runInit();
  }

  runInit() async {
    ApiService().irlVisit();
    ApiService().irlVisitIrls();
  }

  @override
  Widget build(BuildContext context) {
    final appState = context.watch<AppStateCubit>();
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            const DesignText(
              "IRL",
              color: Colors.white,
              fontSize: 30,
            ),
            20.height,
            Expanded(
              child: ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: DesignText("Item $index",
                        color: Colors.white, fontSize: 20),
                    onTap: () {
                      // Handle item tap
                    },
                  );
                },
              ),
            ),
            20.height,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                8.width,
                Expanded(
                  child: SizedBox(
                    height: 50,
                    child: BlurBtn(
                      title: "Use the IRL Feed",
                      onTap: () {
                        appState.goIrl = !appState.goIrl;
                      },
                    ),
                  ),
                ),
                8.width,
                Expanded(
                  child: SizedBox(
                    height: 50,
                    child: BlurBtn(
                      title: "Continue Normally",
                      onTap: () {
                        appState.goIrl = !appState.goIrl;
                      },
                    ),
                  ),
                ),
                8.width,
              ],
            ),
            10.height,
          ],
        ),
      ),
    );
  }
}
