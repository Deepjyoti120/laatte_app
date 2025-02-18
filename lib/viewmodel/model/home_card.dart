// import 'package:flutter_svg/svg.dart';
// import 'package:laatte/common_libs.dart';
// import 'package:laatte/routes.dart';
// import 'package:laatte/utils/assets_names.dart';
// import 'package:laatte/utils/design_colors.dart';

// class HomeCard {
//   // HomeCard._internal();
//   // static final HomeCard _instance = HomeCard._internal();
//   // static HomeCard get instance => _instance;

//   // List<String> activeCards = [];

//   static List<HomeItem> items(List<String>? activeCards) {
//     return [
//       HomeItem(
//         name: "Attendance",
//         icon: SvgPicture.asset(
//           AssetsName.svgCalenderSolid,
//           height: 40,
//           width: 40,
//           colorFilter:
//               const ColorFilter.mode(DesignColor.success600, BlendMode.srcIn),
//         ),
//         color: DesignColor.success600,
//         colorLight: DesignColor.lightSuccess,
//         isActive: activeCards?.contains("Attendance") ?? false,
//         route: Routes.employee,
//       ),
//       HomeItem(
//         name: "Leave",
//         icon: SvgPicture.asset(
//           AssetsName.svgLeave,
//           height: 36,
//           width: 36,
//           colorFilter:
//               const ColorFilter.mode(DesignColor.dashRed, BlendMode.srcIn),
//         ),
//         color: DesignColor.dashRed,
//         colorLight: DesignColor.dashRedLight,
//         isActive: activeCards?.contains("Leave") ?? false,
//         route: Routes.employee,
//       ),
//       HomeItem(
//         name: "Employee",
//         icon: SvgPicture.asset(
//           AssetsName.svgEmployees,
//           height: 26,
//           width: 26,
//           colorFilter:
//               const ColorFilter.mode(DesignColor.purple, BlendMode.srcIn),
//         ),
//         color: DesignColor.purple,
//         colorLight: DesignColor.purpleLight,
//         isActive: activeCards?.contains("employee") ?? false,
//         route: Routes.employee,
//       ),
//       HomeItem(
//         name: "Activity Tracker",
//         icon: SvgPicture.asset(
//           AssetsName.svgTracker,
//           height: 40,
//           width: 40,
//           colorFilter:
//               const ColorFilter.mode(DesignColor.indigo600, BlendMode.srcIn),
//         ),
//         color: DesignColor.indigo600,
//         colorLight: DesignColor.indigo100,
//         isActive: activeCards?.contains("Activity Tracker") ?? false,
//         route: Routes.employee,
//       ),
//       HomeItem(
//         name: "Field Visits History",
//         icon: SvgPicture.asset(
//           AssetsName.svgFieldForm,
//           height: 40,
//           width: 40,
//           colorFilter:
//               const ColorFilter.mode(DesignColor.blueLight600, BlendMode.srcIn),
//         ),
//         color: DesignColor.blueLight600,
//         colorLight: DesignColor.blueLight100,
//         isActive: activeCards?.contains("Field Visits History") ?? false,
//         route: Routes.employee,
//       ),
//       HomeItem(
//         name: "Mark Field Visit",
//         icon: SvgPicture.asset(
//           AssetsName.svgLocation,
//           height: 42,
//           width: 42,
//           colorFilter:
//               const ColorFilter.mode(DesignColor.blueGrey600, BlendMode.srcIn),
//         ),
//         color: DesignColor.blueGrey600,
//         colorLight: DesignColor.blueGrey100,
//         isActive: activeCards?.contains("Mark Field Visit") ?? false,
//         route: Routes.employee,
//       ),
//       HomeItem(
//         name: "Resignation",
//         icon: SvgPicture.asset(
//           AssetsName.svgResignation,
//           height: 50,
//           width: 50,
//           colorFilter:
//               const ColorFilter.mode(DesignColor.success600, BlendMode.srcIn),
//         ),
//         color: DesignColor.success600,
//         colorLight: DesignColor.lightSuccess,
//         isActive: activeCards?.contains("Resignation") ?? false,
//         route: Routes.employee,
//       ),
//       HomeItem(
//         name: "Birthday",
//         icon: SvgPicture.asset(
//           AssetsName.svgBirthday,
//           height: 50,
//           width: 50,
//           colorFilter:
//               const ColorFilter.mode(DesignColor.purple600, BlendMode.srcIn),
//         ),
//         color: DesignColor.purple600,
//         colorLight: DesignColor.purple100,
//         isActive: activeCards?.contains("Birthday") ?? false,
//         route: Routes.employee,
//       ),
//       HomeItem(
//         name: "Manual Attendance",
//         icon: SvgPicture.asset(
//           AssetsName.svgAttendance,
//           height: 50,
//           width: 50,
//           colorFilter:
//               const ColorFilter.mode(DesignColor.success600, BlendMode.srcIn),
//         ),
//         color: DesignColor.success600,
//         colorLight: DesignColor.lightSuccess,
//         isActive: activeCards?.contains("Manual Attendance") ?? false,
//         route: Routes.employee,
//       ),
//     ];
//   }

//   // List<HomeItem> get activeItems =>
//   //     items().where((item) => item.isActive).toList();
// }

// class HomeItem {
//   final String name;
//   final Widget icon;
//   final Color color;
//   final Color colorLight;
//   final bool isActive;
//   final String route;

//   HomeItem({
//     required this.name,
//     required this.icon,
//     required this.color,
//     required this.colorLight,
//     required this.isActive,
//     required this.route,
//   });
// }
