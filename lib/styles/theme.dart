// import 'package:example_buttons/mixin/widget_state_property.dart';
// import 'package:flutter/material.dart';

// class AppThemeData with WidgetStatePropertyMixin {
//   ThemeData getAppThemeData(BuildContext context) {
//     return ThemeData.light().copyWith(
//         iconButtonTheme: iconButtonTheme,
//         floatingActionButtonTheme: const FloatingActionButtonThemeData(
//           backgroundColor: secondaryCheckboxColor,
//         ),
//         checkboxTheme: CheckboxThemeData(
//             overlayColor: WidgetStateProperty.resolveWith((states) {
//           if (states.contains(WidgetState.selected)) {
//             return secondaryCheckboxColor;
//           }
//           return mainTextColor;
//         }), checkColor: WidgetStateProperty.resolveWith((states) {
//           if (states.contains(WidgetState.selected)) {
//             return mainTextColor;
//           }
//           return Colors.transparent;
//         }), fillColor: WidgetStateProperty.resolveWith((states) {
//           if (states.contains(WidgetState.selected)) {
//             return secondaryCheckboxColor;
//           }
//           return primaryColor;
//         })),
//         bottomSheetTheme: const BottomSheetThemeData(
//             backgroundColor: primaryColor,
//             surfaceTintColor: primaryColor,
//             modalBarrierColor: dividerColor,
//             shadowColor: Colors.transparent,
//             elevation: 0.0),
//         datePickerTheme:
//             const DatePickerThemeCreator().createDatePickerThemeData(context),
//         dropdownMenuTheme: DropdownMenuThemeData(
//             inputDecorationTheme: InputDecorationTheme(
//               errorMaxLines: 2,
//               border: const UnderlineInputBorder(),
//               focusedBorder: const UnderlineInputBorder(
//                   borderSide: BorderSide(color: dividerColor)),
//               errorBorder: UnderlineInputBorder(
//                   borderSide: BorderSide(color: Colors.redAccent.shade200)),
//               fillColor: onPrimaryColor,
//               enabledBorder: const UnderlineInputBorder(
//                   borderSide: BorderSide(color: dividerColor)),
//             ),
//             menuStyle: MenuStyle(
//                 backgroundColor: getProperty(onPrimaryColor),
//                 surfaceTintColor: getProperty(onPrimaryColor))),
//         buttonTheme: const ButtonThemeData(buttonColor: secondaryCheckboxColor),
//         textButtonTheme: TextButtonThemeData(
//             style: ButtonStyle(
//                 foregroundColor: getProperty(mainTextColor),
//                 textStyle: getProperty(context.bodyMedium?.copyWith(
//                     color: mainTextColor,
//                     fontWeight: FontWeight.w600,
//                     fontSize: 16.5)))),
//         elevatedButtonTheme: _elevatedButtonThemeData(context),
//         iconTheme: iconThemeData,
//         textTheme: textTheme);
//   }

//   ElevatedButtonThemeData _elevatedButtonThemeData(BuildContext context) {
//     return ElevatedButtonThemeData(
//         style: ButtonStyle(
//             fixedSize: getProperty(
//               Size(context.width, 45),
//             ),
//             backgroundColor: getProperty(secondaryCheckboxColor),
//             shape: getProperty(RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(8.0)))));
//   }
// }

// const iconThemeData = IconThemeData(color: mainTextColor);

// final iconButtonTheme = IconButtonThemeData(
//     style: ButtonStyle(
//         iconColor:
//             MaterialStategetProperty.resolveWith((states) => mainTextColor)));

// const textTheme = TextTheme(
//     titleLarge:
//         TextStyle(fontSize: 24.0, color: mainTextColor, fontFamily: 'LTWave'),
//     //titlemedium control the formtext style
//     titleMedium: TextStyle(
//       fontSize: 16.0,
//       color: mainTextColor,
//       fontFamily: 'LTWave',
//       fontWeight: FontWeight.w500,
//     ),
//     headlineLarge: TextStyle(
//       fontSize: 16.0,
//       color: mainTextColor,
//       fontFamily: 'LTWave',
//       fontWeight: FontWeight.w700,
//     ),
//     headlineMedium: TextStyle(
//       fontSize: 16.0,
//       color: mainTextColor,
//       fontFamily: 'LTWave',
//       fontWeight: FontWeight.w500,
//     ),
//     headlineSmall: TextStyle(
//       fontSize: 16.0,
//       color: mainTextColor,
//       fontFamily: 'LTWave',
//       fontWeight: FontWeight.w500,
//     ),
//     //control del texto general
//     bodySmall: TextStyle(
//       fontSize: 15.0,
//       color: mainTextColor,
//       fontFamily: 'JUSTsans',
//       fontWeight: FontWeight.w500,
//     ),
//     bodyMedium: TextStyle(
//       fontSize: 17.0,
//       color: mainTextColor,
//       fontFamily: 'JUSTsans',
//       fontWeight: FontWeight.w500,
//     ),
//     bodyLarge: TextStyle(
//         fontSize: 18.0,
//         color: mainTextColor,
//         fontWeight: FontWeight.w700,
//         fontFamily: 'LTWave'),
//     labelSmall: TextStyle(
//       fontSize: 17.0,
//       color: mainTextColor,
//       fontFamily: 'JUSTsans',
//       fontWeight: FontWeight.w500,
//     ),
//     labelMedium: TextStyle(
//       fontSize: 16.0,
//       color: mainTextColor,
//       fontFamily: 'LTWave',
//       fontWeight: FontWeight.w500,
//     ),
//     displayLarge:
//         TextStyle(fontSize: 17.0, color: mainTextColor, fontFamily: 'JUSTsans'),
//     displayMedium:
//         TextStyle(fontSize: 17.0, color: mainTextColor, fontFamily: 'JUSTsans'),
//     displaySmall:
//         TextStyle(fontSize: 17.0, color: mainTextColor, fontFamily: 'JUSTsans'),
//     labelLarge:
//         TextStyle(fontSize: 17.0, color: mainTextColor, fontFamily: 'JUSTsans'),
//     titleSmall: TextStyle(
//         fontSize: 17.0, color: mainTextColor, fontFamily: 'JUSTsans'));
