// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:webview_flutter/webview_flutter.dart';

// import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';

// class WebViewCustom extends StatefulWidget {
//   final String text;

//   const WebViewCustom({super.key, required this.text});

//   @override
//   State<WebViewCustom> createState() => _WebViewCustomState();
// }

// class _WebViewCustomState extends State<WebViewCustom> {
//   late final WebViewController _controller;

//   @override
//   void initState() {
//     super.initState();

//     // #docregion platform_features
//       PlatformWebViewControllerCreationParams params =
//         WebKitWebViewControllerCreationParams(
//       allowsInlineMediaPlayback: true,
//       mediaTypesRequiringUserAction: const <PlaybackMediaTypes>{},
//     );

//     final WebViewController controller =
//         WebViewController.fromPlatformCreationParams(params);
//     // #enddocregion platform_features
//     final String contentBase64 = base64Encode(
//       const Utf8Encoder().convert(widget.text),
//     );
//     controller
//       ..setJavaScriptMode(JavaScriptMode.disabled)
//       ..setBackgroundColor(const Color(0x00000000))
//       ..setNavigationDelegate(
//         NavigationDelegate(
//           // onProgress: (int progress) {
//           //   debugPrint('WebView is loading (progress : $progress%)');
//           // },
//           // onPageStarted: (String url) {
//           //   debugPrint('Page started loading: $url');
//           // },
//           // onPageFinished: (String url) {
//           //   debugPrint('Page finished loading: $url');
//           // },
//           onNavigationRequest: (NavigationRequest request) async {
//             return NavigationDecision.prevent;
//           },
//         ),
//       )
//       ..addJavaScriptChannel(
//         'Toaster',
//         onMessageReceived: (JavaScriptMessage message) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(content: Text(message.message)),
//           );
//         },
//       )
//       ..loadRequest(Uri.parse('data:text/html;base64,$contentBase64'));

//     // #docregion platform_features
//     // if (controller.platform is AndroidWebViewController) {
//     //   AndroidWebViewController.enableDebugging(true);
//     //   (controller.platform as AndroidWebViewController)
//     //       .setMediaPlaybackRequiresUserGesture(false);
//     // }
//     // #enddocregion platform_features
//     _controller = controller;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(body: SafeArea(child: WebViewWidget(controller: _controller)));
//   }
// }
