import 'package:laatte/common_libs.dart';
import 'package:laatte/utils/design_colors.dart';

class AppIcon extends StatelessWidget {
  const AppIcon(this.icon, {super.key, this.size = 22, this.color});
  final AppIcons icon;
  final double size;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    String i = icon.name.toLowerCase().replaceAll('_', '-');
    String path = 'assets/img/house.png';
    return SizedBox(
      width: size,
      height: size,
      child: Center(
        child: Image.asset(path,
            width: size,
            height: size,
            color: color ?? DesignColor.offWhite,
            filterQuality: FilterQuality.high),
      ),
    );
  }
}

enum AppIcons {
  close,
  close_large,
  collection,
  download,
  expand,
  fullscreen,
  fullscreen_exit,
  info,
  menu,
  next_large,
  north,
  prev,
  reset_location,
  search,
  shareandroid,
  share_ios,
  timeline,
  wallpaper,
  zoom_in,
  zoom_out
}
