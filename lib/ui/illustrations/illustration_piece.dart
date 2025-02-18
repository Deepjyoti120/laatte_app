import 'dart:ui' as ui;
import 'package:laatte/common_libs.dart';
import 'package:laatte/ui/illustrations/wonder_illustration_config.dart';

import '../../utils/assets_names.dart';

class IllustrationPiece extends StatefulWidget {
  const IllustrationPiece({
    super.key,
    required this.fileName,
    required this.heightFactor,
    required this.animation,
    required this.config,
    this.alignment = Alignment.center,
    this.minHeight,
    this.offset = Offset.zero,
    this.fractionalOffset,
    this.zoomAmt = 0,
    this.initialOffset = Offset.zero,
    this.enableHero = false,
    this.initialScale = 1,
    this.dynamicHzOffset = 0,
    this.top,
    this.bottom,
  });

  final String fileName;
  final Alignment alignment;
  final Offset initialOffset;
  final double initialScale;
  final double heightFactor;
  final double? minHeight;
  final Offset offset;
  final Offset? fractionalOffset;
  final double zoomAmt;
  final bool enableHero;
  final double dynamicHzOffset;
  final Widget Function(BuildContext context)? top;
  final Widget Function(BuildContext context)? bottom;
  final Animation<double> animation;
  final WonderIllustrationConfig config;

  @override
  State<IllustrationPiece> createState() => _IllustrationPieceState();
}

class _IllustrationPieceState extends State<IllustrationPiece> {
  double? aspectRatio;
  ui.Image? uiImage;

  @override
  Widget build(BuildContext context) {
    final anim = widget.animation;
    final curvedAnim = Curves.easeOut.transform(anim.value);
    final config = widget.config;
    final imgPath = widget.fileName;

    if (aspectRatio == null) {
      aspectRatio == 0;
      rootBundle.load(imgPath).then((img) async {
        uiImage = await decodeImageFromList(img.buffer.asUint8List());
        if (!mounted) return;
        setState(() => aspectRatio = uiImage!.width / uiImage!.height);
      });
    }

    return Align(
      alignment: widget.alignment,
      child: LayoutBuilder(
          key: ValueKey(aspectRatio),
          builder: (_, constraints) {
            Widget img =
                Image.asset(imgPath, opacity: anim, fit: BoxFit.fitHeight);
            img = OverflowBox(maxWidth: 2500, child: img);

            final double introZoom =
                (widget.initialScale - 1) * (1 - curvedAnim);
            final double height = max(widget.minHeight ?? 0,
                constraints.maxHeight * widget.heightFactor);

            Offset finalTranslation = widget.offset;
            if (widget.initialOffset != Offset.zero) {
              finalTranslation += widget.initialOffset * (1 - curvedAnim);
            }

            final dynamicOffsetAmt =
                ((MediaQuery.of(context).size.width - 400) / 1100).clamp(0, 1);
            finalTranslation +=
                Offset(dynamicOffsetAmt * widget.dynamicHzOffset, 0);

            final width = height * (aspectRatio ?? 0);
            if (widget.fractionalOffset != null) {
              finalTranslation += Offset(
                widget.fractionalOffset!.dx * width,
                height * widget.fractionalOffset!.dy,
              );
            }

            Widget? content;
            if (uiImage != null) {
              content = Transform.translate(
                offset: finalTranslation,
                child: Transform.scale(
                  scale: 1 + (widget.zoomAmt * config.zoom) + introZoom,
                  child: SizedBox(
                    height: height,
                    width: height * aspectRatio!,
                    child: img,
                  ),
                ),
              );
            }

            return Stack(
              children: [
                if (widget.bottom != null)
                  Positioned.fill(child: widget.bottom!.call(context)),
                if (uiImage != null) ...[
                  widget.enableHero
                      ? Hero(tag: AssetsName.appLogo, child: content!)
                      : content!,
                ],
                if (widget.top != null)
                  Positioned.fill(child: widget.top!.call(context)),
              ],
            );
          }),
    );
  }
}
