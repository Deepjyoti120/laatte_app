// import 'package:flutter/material.dart';
// import 'package:flutter_animate/flutter_animate.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:intro_animated/ui/custom/custom_text_form.dart';
// import 'package:intro_animated/ui/theme/text.dart';
// import 'package:intro_animated/utils/design_colors.dart';
// import 'package:intro_animated/utils/extensions.dart';
// import 'package:intro_animated/viewmodel/provider/appstate.dart';
// import 'package:provider/provider.dart';

// class FromLanguage extends StatelessWidget {
//   const FromLanguage({super.key, required this.title});
//   final String title;
//   @override
//   Widget build(BuildContext context) {
//     final appState = Provider.of<AppState>(context);
//     return Column(
//       children: [
//         30.height,
//         Column(
//           children: [
//             const DesignText(
//               "Hey there!",
//               fontSize: 24,
//               fontWeight: 600,
//             ),
//             6.height,
//             const DesignText(
//               "Welcome to ZeroCarbs! We’re happy to have\nyou onboard. To kickstart your journey\nwe need few informations.",
//               fontSize: 12,
//               fontWeight: 600,
//               textAlign: TextAlign.center,
//             ),
//           ],
//         )
//             .animate()
//             .fadeIn(
//               duration: const Duration(milliseconds: 600),
//               curve: Curves.easeIn,
//               delay: const Duration(milliseconds: 500),
//             )
//             .slideX(
//               duration: const Duration(seconds: 2),
//               curve: Curves.fastLinearToSlowEaseIn,
//               begin: 2,
//             ),
//         20.height,
//         Padding(
//           padding: const EdgeInsets.all(20.0),
//           child: Column(
//             children: [
//               const DesignText(
//                 "What is your Name?",
//                 fontSize: 20,
//                 fontWeight: 600,
//               ),
//               20.height,
//               DesignFormField(
//                 controller: appState.nameController,
//                 labelText: "",
//                 // onChanged: (value) {
//                 //   appState.nameController = TextEditingController(text: value);
//                 // },
//               ),
//               30.height,
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   const Icon(
//                     FontAwesomeIcons.gift,
//                     color: DesignColor.foodRed,
//                     size: 14,
//                   ),
//                   4.width,
//                   const DesignText(
//                     "Have a referral code?",
//                     fontSize: 12,
//                     fontWeight: 600,
//                     color: DesignColor.foodRed,
//                   ),
//                 ],
//               ),
//             ],
//           )
//               .animate()
//               .fadeIn(
//                 duration: const Duration(milliseconds: 1000),
//                 curve: Curves.easeIn,
//                 delay: const Duration(milliseconds: 800),
//               )
//               .slideY(
//                 duration: const Duration(seconds: 2),
//                 curve: Curves.fastLinearToSlowEaseIn,
//                 begin: 2,
//               ),
//         ),
//       ],
//     );
//   }
// }
