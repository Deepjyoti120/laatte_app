import 'package:laatte/common_libs.dart';
import 'package:laatte/ui/animation/fade_color_transition.dart';
import 'package:laatte/ui/illustrations/paint_textures.dart';
import 'package:laatte/ui/illustrations/wonder_illustration_builder.dart';
import 'package:laatte/ui/illustrations/wonder_illustration_config.dart';
import 'package:laatte/utils/assets_names.dart';
import 'package:laatte/utils/wonders_color_extensions.dart';
import 'package:laatte/viewmodel/model/wonder_type.dart';

import 'illustration_piece.dart';

class EmployeeReportIllustration extends StatelessWidget {
  EmployeeReportIllustration({super.key, required this.config});
  final WonderIllustrationConfig config;
  // final assetPath = WonderType.chichenItza.assetPath;
  final fgColor = WonderType.chichenItza.fgColor;
  @override
  Widget build(BuildContext context) {
    return WonderIllustrationBuilder(
      config: config,
      bgBuilder: _buildBg,
      mgBuilder: _buildMg,
      fgBuilder: _buildFg,
      wonderType: WonderType.chichenItza,
    );
  }

  List<Widget> _buildBg(BuildContext context, Animation<double> anim) {
    return [
      FadeColorTransition(animation: anim, color: fgColor),
      Positioned.fill(
        child: IllustrationTexture(
          AssetsName.appLogo,
          color: const Color(0xffDC762A),
          opacity: anim.drive(Tween(begin: 0, end: .5)),
          flipY: true,
          scale: config.shortMode ? 4 : 1.15,
        ),
      ),
      IllustrationPiece(
        fileName: AssetsName.appLogo,
        initialOffset: const Offset(0, 50),
        enableHero: true,
        heightFactor: .4,
        minHeight: 200,
        config: config,
        animation: anim,
        fractionalOffset: Offset(.55, config.shortMode ? .2 : -.35),
      ),
    ];
  }

  List<Widget> _buildMg(BuildContext context, Animation<double> anim) {
    // We want to size to the shortest side
    return [
      Transform.translate(
        offset: Offset(0, config.shortMode ? 70 : -30),
        child: IllustrationPiece(
          fileName: AssetsName.pngReports,
          heightFactor: .4,
          minHeight: 180,
          zoomAmt: -.1,
          animation: anim,
          config: config,
          enableHero: true,
        ),
      ),
    ];
  }

  List<Widget> _buildFg(BuildContext context, Animation<double> anim) {
    return [
      IllustrationPiece(
        fileName: AssetsName.pngEmployeeRight,
        alignment: Alignment.bottomCenter,
        initialOffset: const Offset(40, 30),
        initialScale: .9,
        heightFactor: .36,
        fractionalOffset: const Offset(.6, 0.1),
        zoomAmt: .2,
        dynamicHzOffset: 700,
        animation: anim,
        config: config,
      ),
      IllustrationPiece(
        fileName: AssetsName.pngEmployeeLeft,
        alignment: Alignment.bottomCenter,
        initialScale: .9,
        initialOffset: const Offset(-60, 20),
        heightFactor: .36,
        fractionalOffset: const Offset(-.57, .1),
        zoomAmt: .2,
        dynamicHzOffset: 300,
        animation: anim,
        config: config,
      ),
    ];
  }
}
