import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InteractiveView extends StatefulWidget {
  const InteractiveView({super.key, required this.preview});
  final String preview;

  @override
  State<InteractiveView> createState() => _InteractiveViewState();
}

class _InteractiveViewState extends State<InteractiveView> {
  final _transformationController = TransformationController();
  TapDownDetails? _doubleTapDetails;
  void handleDoubleTapDown(TapDownDetails details) {
    _doubleTapDetails = details;
  }

  void handleDoubleTap() {
    if (_transformationController.value != Matrix4.identity()) {
      _transformationController.value = Matrix4.identity();
    } else {
      final position = _doubleTapDetails!.localPosition;
      // For a 3x zoom
      _transformationController.value = Matrix4.identity()
        ..translate(-position.dx * 2, -position.dy * 2)
        ..scale(3.0);
      // Fox a 2x zoom
      // ..translate(-position.dx, -position.dy)
      // ..scale(2.0);
    }
  }

  @override
  void initState() {
    super.initState();
    setViewMode();
  }

  @override
  void dispose() {
    super.dispose();
    setAllOrientation();
  }

  Future setViewMode() async {
    await SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
  }

  Future setAllOrientation() async {
    await SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
  }

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: widget.preview,
      child: InteractiveViewer(
        transformationController: _transformationController,
        child: GestureDetector(
          onDoubleTapDown: handleDoubleTapDown,
          onDoubleTap: handleDoubleTap,
          child: CachedNetworkImage(
            imageUrl: widget.preview,
            fit: BoxFit.contain,
            height: double.infinity,
          ),
        ),
      ),
    );
  }
}

// class InteractiveVideoView extends StatefulWidget {
//   const InteractiveVideoView({super.key, required this.preview});
//   final String preview;

//   @override
//   State<InteractiveVideoView> createState() => _InteractiveVideoViewState();
// }

// class _InteractiveVideoViewState extends State<InteractiveVideoView> {
//   late VideoPlayerController videoPlayerController;
//   late CustomVideoPlayerController _controller;
//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//     videoPlayerController = VideoPlayerController.network(widget.preview)
//       ..initialize().then((value) => setState(() {}));
//     _controller = CustomVideoPlayerController(
//       context: context,
//       videoPlayerController: videoPlayerController,
//     );
//   }

//   @override
//   void initState() {
//     super.initState();
//     setViewMode();
//   }

//   @override
//   void dispose() {
//     super.dispose();
//     _controller.dispose();
//     // videoPlayerController.dispose();
//     setAllOrientation();
//   }

//   Future setViewMode() async {
//     await SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
//   }

//   Future setLandscape() async {
//     await SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
//     await SystemChrome.setPreferredOrientations([
//       DeviceOrientation.landscapeLeft,
//       DeviceOrientation.landscapeRight,
//     ]);
//   }

//   Future setAllOrientation() async {
//     await SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
//         overlays: SystemUiOverlay.values);
//     await SystemChrome.setPreferredOrientations(DeviceOrientation.values);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Hero(
//       tag: widget.preview,
//       child: CustomVideoPlayer(
//         customVideoPlayerController: _controller,
//       ),
//     );
//   }
// }
