import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:laatte/common_libs.dart';
import 'package:laatte/services/api_services.dart';
import 'package:laatte/ui/blur_button.dart';
import 'package:laatte/ui/theme/container.dart';
import 'package:laatte/ui/theme/text.dart';
import 'package:laatte/utils/design_colors.dart';
import 'package:laatte/utils/extensions.dart';
import 'package:laatte/viewmodel/bloc/visit_irl_bloc.dart';
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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<VisitIrlBloc>().add(VisitIrlFetch(context));
    });
  }

  @override
  Widget build(BuildContext context) {
    final appState = context.watch<AppStateCubit>();
    final visits = context.watch<VisitIrlBloc>().state.visitIrls;
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            const DesignText(
              "IRL",
              color: DesignColor.latteYellowSmall,
              fontSize: 30,
            ),
            const DesignText(
              "Start connecting with people \nat places you went today.",
              color: DesignColor.latteYellowSmall,
              fontSize: 16,
              textAlign: TextAlign.center,
            ),
            10.height,
            const DesignText(
              "Today You Were At...",
              color: DesignColor.latteYellowSmall,
              fontSize: 20,
            ),
            10.height,
            Expanded(
              child: ListView.builder(
                itemCount: visits.length,
                shrinkWrap: true,
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                itemBuilder: (context, index) {
                  final visit = visits[index];
                  if (visit == null) {
                    return const SizedBox();
                  }
                  return DesignContainer(
                    width: double.infinity,
                    clipBehavior: Clip.antiAlias,
                    color: DesignColor.latteDarkCard,
                    isColor: true,
                    child: Row(
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: 100,
                            child: CachedNetworkImage(
                              imageUrl: visit.irl?.profile ?? "",
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            height: 100,
                            alignment: Alignment.center,
                            color: DesignColor.latteDarkCard,
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: DesignText(
                                visit.irl?.name ?? "",
                                color: DesignColor.latteYellowSmall,
                                fontSize: 16,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            20.height,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (appState.irlPreLoad != null)
                  Expanded(
                    child: Row(
                      children: [
                        8.width,
                        Expanded(
                          child: SizedBox(
                            height: 50,
                            child: BlurBtn(
                              title: "Use the IRL Feed",
                              onTap: () {
                                appState.irl = appState.irlPreLoad;
                                appState.goIrl = !appState.goIrl;
                              },
                            ),
                          ),
                        ),
                        8.width,
                      ],
                    ),
                  ),
                Expanded(
                  child: SizedBox(
                    height: 50,
                    child: BlurBtn(
                      title: "Continue Normally",
                      onTap: () {
                        appState.irl = null;
                        appState.goIrl = !appState.goIrl;
                      },
                    ),
                  ),
                ),
                8.width,
              ],
            ),
            90.height,
          ],
        ),
      ),
    );
  }
}
