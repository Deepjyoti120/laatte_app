import 'package:laatte/common_libs.dart';
import 'package:laatte/ui/animation/fade_color_transition.dart';
import 'package:laatte/ui/illustrations/paint_textures.dart';
import 'package:laatte/ui/illustrations/wonder_illustration_builder.dart';
import 'package:laatte/ui/illustrations/wonder_illustration_config.dart';
import 'package:laatte/utils/assets_names.dart';
import 'package:laatte/utils/wonders_color_extensions.dart';
import 'package:laatte/viewmodel/model/wonder_type.dart';
import 'illustration_piece.dart';

class ChichenItzaIllustration2 extends StatelessWidget {
  ChichenItzaIllustration2({super.key, required this.config});
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
        animation: anim,
        config: config,
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
          fileName: AssetsName.pngTimeCalender,
          heightFactor: .3,
          minHeight: 180,
          zoomAmt: -.1,
          enableHero: true,
          animation: anim,
          config: config,
        ),
      ),
    ];
  }

  List<Widget> _buildFg(BuildContext context, Animation<double> anim) {
    return [
      IllustrationPiece(
        fileName: AssetsName.pngFlower,
        alignment: Alignment.bottomCenter,
        initialOffset: const Offset(20, 40),
        initialScale: .95,
        heightFactor: .3,
        fractionalOffset: const Offset(.5, -.1),
        zoomAmt: .1,
        dynamicHzOffset: 250,
        animation: anim,
        config: config,
      ),
      IllustrationPiece(
        fileName: AssetsName.pngFlowerLeft,
        alignment: Alignment.bottomCenter,
        initialScale: .95,
        initialOffset: const Offset(60, 10),
        heightFactor: .3,
        fractionalOffset: const Offset(-.5, -.1),
        zoomAmt: .25,
        dynamicHzOffset: -600,
        animation: anim,
        config: config,
      ),
    ];
  }
}
