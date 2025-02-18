import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:laatte/utils/extensions.dart';
import 'package:laatte/views/home/dwawer/toggle_item.dart';
import '../../../ui/theme/text.dart';
import '../../../utils/assets_names.dart';
import '../../../utils/constants.dart';
import '../../../utils/design_colors.dart';
import '../../../utils/utlis.dart';
import '../../../viewmodel/bloc/user_report_bloc.dart';
import '../../../viewmodel/cubit/app_cubit.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});
  @override
  Widget build(BuildContext context) {
    final appState = context.watch<AppStateCubit>();
    final user = context.watch<UserReportBloc>().state;
    return Drawer(
      elevation: 0,
      child: Column(
        children: [
          SizedBox(
            height: 190,
            child: UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                  color: appState.isDarkMode ? DesignColor.grey : Colors.white),
              accountName: DesignText(
                Constants.appName,
                fontSize: 14,
                fontWeight: 400,
                color: appState.isDarkMode ? Colors.white : null,
              ),
              accountEmail: DesignText(
                (user.userReport?.name ?? '').capitalizeFirstLetter(),
                fontSize: 14,
                fontWeight: 700,
                color: appState.isDarkMode ? Colors.white : null,
              )
                  .animate()
                  .fadeIn(duration: 600.ms)
                  .slide(delay: 200.ms, curve: Curves.easeInOutBack),
              currentAccountPicture: Container(
                clipBehavior: Clip.antiAlias,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(0)),
                child:
                    SvgPicture.asset(AssetsName.appLogo, height: 4, width: 4),
              ),
              currentAccountPictureSize: const Size(60, 60),
              margin: EdgeInsets.zero,
            ),
          ),
          Expanded(
              child: Column(
            children: [
              DrawerItem(
                title: "Home",
                iconData: FontAwesomeIcons.house,
                onTap: () {
                  context.pop();
                },
              ),
              const Divider(
                color: DesignColor.grey,
                height: 1,
              ),
            ],
          )),
          // Expanded(
          //   child: SingleChildScrollView(
          //     child: BlocBuilder<ModuleBloc, ModuleState>(
          //         builder: (context, state) {
          //       final modules = state.items;
          //       return ListView.builder(
          //         shrinkWrap: true,
          //         itemCount: modules.length,
          //         padding: EdgeInsets.zero,
          //         physics: const NeverScrollableScrollPhysics(),
          //         itemBuilder: (context, index) {
          //           final module = state.items[index];
          //           return Column(
          //             children: [
          //               DrawerItem(
          //                 title: module.name ?? "",
          //                 iconData: linkIcon(module.name ?? ""),
          //                 onTap: () {
          //                   // clickMenu(
          //                   //   appState: appState,
          //                   //   context: context,
          //                   //   route: module.url,
          //                   // );
          //                   context.pop();
          //                   if (module.url != null) {
          //                     GoRouter.of(context).push(module.url!);
          //                   } else {
          //                     appState.currentPage = module.moduleID ?? 0;
          //                   }
          //                 },
          //                 items: (module.submenus ?? [])
          //                     .map(
          //                       (e) => DrawerListItem(
          //                         title: e.name ?? "",
          //                         onTap: () {
          //                           // clickMenu(
          //                           //   appState: appState,
          //                           //   context: context,
          //                           //   route: e.url,
          //                           // );
          //                         },
          //                       ),
          //                     )
          //                     .toList(),
          //               ),
          //               const Divider(
          //                 color: DesignColor.colorPrimary2,
          //                 height: 1,
          //               ),
          //             ],
          //           );
          //         },
          //       );
          //     }),
          //   ),
          // ),
          Container(
            height: 92,
            alignment: Alignment.center,
            color: DesignColor.colorNew,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                6.height,
                const DesignText(
                  'Powered by',
                  fontWeight: 600,
                  fontSize: 12,
                  color: Colors.white,
                ),
                SizedBox(
                  height: 20,
                  child: TextButton(
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                    ),
                    onPressed: () {
                      Utils.launchUrl2(url: Constants.companySite);
                    },
                    child: const DesignText(
                      Constants.companyName,
                      fontWeight: 600,
                      fontSize: 12,
                      decoration: TextDecoration.underline,
                      color: Colors.white,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                6.height,
                DesignText(
                  "V${Constants.packageInfo?.version ?? ""}",
                  fontSize: 12,
                  fontWeight: 700,
                  color: Colors.white,
                ),
                // const DesignText(
                //   "Also Available on",
                //   fontSize: 14,
                //   color: Colors.white,
                //   fontWeight: 600,
                // ),
                // const SizedBox(height: 10),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //   children: [
                //     IconButton(
                //       constraints: const BoxConstraints(),
                //       padding: EdgeInsets.zero,
                //       onPressed: () {},
                //       icon: const Icon(
                //         Icons.facebook,
                //         color: Colors.white,
                //       ),
                //     ),
                //     IconButton(
                //       constraints: const BoxConstraints(),
                //       padding: EdgeInsets.zero,
                //       onPressed: () {},
                //       icon: const FaIcon(
                //         FontAwesomeIcons.instagram,
                //         color: Colors.white,
                //       ),
                //     ),
                //     IconButton(
                //       constraints: const BoxConstraints(),
                //       padding: EdgeInsets.zero,
                //       onPressed: () {
                //         // DesignUtlis.launchUrl2( url: '');
                //       },
                //       icon: const Icon(
                //         FontAwesomeIcons.youtube,
                //         color: Colors.white,
                //       ),
                //     ),
                //   ],
                // ),
                const SizedBox(height: 6),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
