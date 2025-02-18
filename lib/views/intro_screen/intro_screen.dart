// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// import 'package:laatte/ui/theme/buttons.dart';
// import 'package:laatte/ui/theme/text.dart';
// import 'package:laatte/utils/constants.dart';
// import 'package:laatte/utils/extensions.dart';
// import 'package:laatte/views/intro_screen/intro_content.dart';

// import '../../routes.dart';
// import '../../utils/design_colors.dart';

// class IntroScreen extends StatefulWidget {
//   // static const String route = "/IntroScreen";
//   const IntroScreen({super.key});
//   @override
//   State<IntroScreen> createState() => _IntroScreenState();
// }

// class _IntroScreenState extends State<IntroScreen> {
//   int currentPage = 0;
//   final PageController _controller = PageController();
//   List<int> isAnimated = [];
//   List<Map<String, String>> splashData = [
//     {
//       "title": "Welcome to ${Constants.appName}",
//       "json": "assets/lottie/home.json",
//       "text":
//           "A platform to pay rent, collect payments, and manage housing tasks. Stay updated on maintenance and track transactions easily.",
//     },
//     {
//       "title": "Pay Rent and Collect Payments",
//       "text": "Easily pay your rent and collect payments securely.",
//       "json": "assets/lottie/payment-google.json",
//     },
//     {
//       "title": "Track Payment History",
//       "text": "Keep track of all your payments and stay organized.",
//       "json": "assets/lottie/bill-history.json",
//     },
//   ];
//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     bool isLastScreen = currentPage == (splashData.length - 1);
//     return Scaffold(
//       body: SizedBox(
//         width: double.infinity,
//         child: Column(
//           children: [
//             Expanded(
//               flex: 4,
//               child: PageView.builder(
//                 controller: _controller,
//                 onPageChanged: (value) {
//                   isAnimated.add(currentPage);
//                   setState(() {
//                     currentPage = value;
//                   });
//                 },
//                 itemCount: splashData.length,
//                 itemBuilder: (context, index) => SplashContent(
//                   image: splashData[index]["image"],
//                   json: splashData[index]["json"],
//                   text: splashData[index]['text'].toString(),
//                   title: splashData[index]['title'].toString(),
//                   isAnimate: !isAnimated.contains(currentPage),
//                 ),
//               ),
//             ),
//             Expanded(
//               child: Column(
//                 children: [
//                   const Spacer(flex: 4),
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 30),
//                     child: Column(
//                       children: [
//                         SizedBox(
//                           width: double.infinity,
//                           height: 48,
//                           child: Hero(
//                             tag: Constants.keyLoginButton,
//                             child: DesignButtons(
//                               color: DesignColor.backgroundBlack,
//                               elevation: 0,
//                               fontSize: 16,
//                               fontWeight: 500,
//                               colorText: Colors.white,
//                               isTappedNotifier: ValueNotifier<bool>(false),
//                               onPressed: () async {
//                                 if (isLastScreen) {
//                                   context.push(Routes.login);
//                                 } else {
//                                   _controller.nextPage(
//                                       duration:
//                                           const Duration(milliseconds: 400),
//                                       curve: Curves.linear);
//                                 }
//                               },
//                               textLabel: isLastScreen ? "Done" : 'Next',
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   16.height,
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: List.generate(
//                       splashData.length,
//                       (index) => buildDot(index: index),
//                     ),
//                   ),
//                   TextButton(
//                     onPressed: () {
//                       context.push(Routes.login);
//                     },
//                     child: const DesignText(
//                       "Skip",
//                       fontSize: 14,
//                       fontWeight: 400,
//                       color: DesignColor.textbody,
//                     ),
//                   ),
//                   const Spacer(),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   AnimatedContainer buildDot({int? index}) {
//     return AnimatedContainer(
//       duration: const Duration(milliseconds: 300),
//       margin: const EdgeInsets.only(right: 8),
//       height: 8,
//       width: currentPage == index ? 25 : 8,
//       decoration: BoxDecoration(
//         color: currentPage == index
//             ? DesignColor.backgroundBlack
//             : DesignColor.textbody,
//         borderRadius: BorderRadius.circular(6),
//       ),
//     );
//   }
// }
