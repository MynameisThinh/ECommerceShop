import 'package:flutter/material.dart';

ThemeData themeData = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    primaryColor: Colors.grey,
    // inputDecorationTheme: InputDecorationTheme(
    //   border: outlineInputBorder,
    //   enabledBorder: outlineInputBorder,
    //   errorBorder: outlineInputBorder,
    //   focusedBorder: outlineInputBorder,
    //   disabledBorder: outlineInputBorder,
    // ),
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.grey,
            textStyle: TextStyle(
              fontSize: 18,
            ),
            disabledBackgroundColor: Colors.black)));
// OutlineInputBorder outlineInputBorder = OutlineInputBorder(
//   borderSide: BorderSide(
//     color: Colors.grey,
//   ),
//   borderRadius: BorderRadius.circular(10),
// );
