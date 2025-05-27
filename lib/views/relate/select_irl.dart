import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:laatte/common_libs.dart';
import 'package:laatte/ui/theme/container.dart';
import 'package:laatte/ui/theme/text.dart';
import 'package:laatte/utils/design_colors.dart';
import 'package:laatte/utils/extensions.dart';
import 'package:laatte/viewmodel/bloc/visit_irl_bloc.dart';

class SelectIrl extends StatefulWidget {
  const SelectIrl({super.key});

  @override
  State<SelectIrl> createState() => _SelectIrlState();
}

class _SelectIrlState extends State<SelectIrl> {
  @override
  Widget build(BuildContext context) {
    final visits = context.watch<VisitIrlBloc>().state.visitIrls;
    return Column(
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
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: Colors.white.withOpacity(0.2),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(30, 14, 30, 14),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const DesignText(
                          "IRL",
                          color: DesignColor.white,
                          fontSize: 30,
                        ),
                        const DesignText(
                          "Start connecting with people \nat places you went today.",
                          color: DesignColor.white,
                          fontSize: 16,
                          textAlign: TextAlign.center,
                        ),
                        10.height,
                        if (visits.isNotEmpty)
                          const DesignText(
                            "Today You Were At...",
                            color: DesignColor.white,
                            fontSize: 20,
                          ),
                        if (visits.isNotEmpty) 10.height,
                        if (visits.isNotEmpty)
                          ListView.builder(
                            itemCount: visits.length,
                            shrinkWrap: true,
                            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                            itemBuilder: (context, index) {
                              final visit = visits[index];
                              if (visit == null) {
                                return const SizedBox();
                              }
                              return GestureDetector(
                                onTap: () {
                                  context.pop(visit.irl);
                                },
                                child: DesignContainer(
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
                                              color: DesignColor.primary,
                                              fontSize: 16,
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          )
                        else
                          const DesignText(
                            "You have not visited any places today.",
                            color: DesignColor.white,
                            fontSize: 16,
                            textAlign: TextAlign.center,
                          ),
                        10.height,
                        const Row()
                        // SizedBox(
                        //   height: 48,
                        //   child: BlurBtn(
                        //     title: "Sent",
                        //     onTap: () {},
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                  10.height,
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
