// import 'package:awesome_number_picker/awesome_number_picker.dart';
// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:intro_animated/ui/theme/container.dart';
// import 'package:intro_animated/ui/theme/text.dart';
// import 'package:intro_animated/utils/design_colors.dart';
// import 'package:intro_animated/viewmodel/provider/appstate.dart';
// import 'package:numberpicker/numberpicker.dart';
// import 'package:provider/provider.dart';

// class AgeSelect extends StatefulWidget {
//   const AgeSelect({super.key});

//   @override
//   State<AgeSelect> createState() => _AgeSelectState();
// }

// class _AgeSelectState extends State<AgeSelect> {

//   @override
//   Widget build(BuildContext context) {
//     final appState = Provider.of<AppState>(context);
//     return Column(
//       children: [
//         Expanded(
//           child: Stack(
//             alignment: Alignment.center,
//             children: [
//               IntegerNumberPicker(
//                 initialValue: appState.age,
//                 minValue: 12,
//                 maxValue: 100,
//                 size: 80,
//                 axis: Axis.vertical,
//                 otherItemsDecoration: BoxDecoration(
//                   // border: Border.all(color: DesignColor.foodGrey),
//                   borderRadius: BorderRadius.circular(0),
//                 ),
//                 otherItemsTextStyle: TextStyle(
//                   color: DesignColor.foodGrey.withOpacity(0.7),
//                   fontSize: 30,
//                   fontWeight: FontWeight.bold,
//                 ),
//                 pickedItemTextStyle: const TextStyle(
//                   color: DesignColor.foodGreen,
//                   fontSize: 36,
//                   fontWeight: FontWeight.bold,
//                 ),
//                 pickedItemDecoration: BoxDecoration(
//                   border: Border.all(color: DesignColor.foodGreen),
//                   borderRadius: BorderRadius.circular(10),
//                   boxShadow: [
//                     BoxShadow(
//                       color: DesignColor.foodGreen.withOpacity(0.5),
//                       spreadRadius: 5,
//                       blurRadius: 8,
//                       blurStyle: BlurStyle.outer,
//                       offset: const Offset(0, 3),
//                     ),
//                   ],
//                 ),
//                 onChanged: (i)   {
//                   appState.age = i;
//                 },
//               ),
//               const Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Icon(
//                     FontAwesomeIcons.caretLeft,
//                     color: Colors.black,
//                     size: 24,
//                   ),
//                   Icon(FontAwesomeIcons.caretRight, color: Colors.black)
//                 ],
//               )
//             ],
//           ),
//         ),
//         DesignContainer(
//             borderAllColor: DesignColor.foodGreen.withOpacity(0.5),
//             bordered: true,
//             padding: const EdgeInsets.fromLTRB(16, 4, 16, 4),
//             margin: const EdgeInsets.all(10),
//             borderRadius: BorderRadius.circular(16),
//             child: const DesignText(
//               "years old",
//               fontSize: 12,
//               fontWeight: 600,
//             ))
//         // SizedBox(
//         //   height: 600,
//         //   child: NumberPicker(
//         //     value: _currentValue,
//         //     minValue: 0,
//         //     maxValue: 100,
//         //     itemHeight: 80,
//         //     itemCount: 6,
//         //     textStyle: TextStyle(
//         //       color: DesignColor.foodGrey.withOpacity(0.7),
//         //       fontSize: 30,
//         //       fontWeight: FontWeight.bold,
//         //     ),
//         //     axis: Axis.vertical,
//         //     // haptics: true,
//         //     // zeroPad: true,
//         //     selectedTextStyle: const TextStyle(
//         //       color: DesignColor.foodGreen,
//         //       fontSize: 36,
//         //       fontWeight: FontWeight.bold,
//         //     ),
//         //     decoration: BoxDecoration(
//         //       border: Border.all(color: DesignColor.foodGreen),
//         //       borderRadius: BorderRadius.circular(10),
//         //       boxShadow: [
//         //         BoxShadow(
//         //           color: DesignColor.foodGreen.withOpacity(0.5),
//         //           spreadRadius: 5,
//         //           blurRadius: 8,
//         //           blurStyle: BlurStyle.outer,
//         //           offset: const Offset(0, 3),
//         //         ),
//         //       ],
//         //     ),
//         //     onChanged: (value) => setState(() => _currentValue = value),
//         //   ),
//         // ),
//       ],
//     );
//   }
// }
