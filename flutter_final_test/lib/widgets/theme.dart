import 'package:flutter/material.dart';

class AppTheme {
  
  AppTheme._();

  static const _primaryColorLight = Colors.lightBlueAccent;

  static const _primaryColorDark = Colors.lightGreenAccent;
  static final Color _lightPrimaryColor = Colors.blueGrey.shade50;
  static final Color _lightPrimaryVariantColor = Colors.blueGrey.shade800;
  static final Color _lightOnPrimaryColor = Colors.blueGrey.shade200;
  static const Color _lightTextPrimaryColor = Colors.black;
  static const Color _appbarPrimaryColor = Colors.blue;

  static final Color _darkPrimaryColor = Colors.blueGrey.shade900;
  static const Color _darkPrimaryVariantColor = Colors.black;
  static final Color _darkOnPrimaryColor = Colors.blueGrey.shade300;
  static const Color _darkTextColorPrimary = Colors.white;
  static const Color _appbarColorDark = Colors.blueGrey;

  static const Color _iconColor = Colors.white;
  static const Color _accentColor = Color.fromRGBO(74, 217, 217, 1);


  // static final ThemeData lightTheme = ThemeData(
  //     useMaterial3: true,
  //     colorScheme: ColorScheme.fromSeed(
  //         seedColor: _primaryColorLight, brightness: Brightness.light));

  // static final ThemeData darkTheme =
  //     ThemeData(
  //       useMaterial3: true,
  //       colorScheme: ColorScheme.fromSeed(seedColor: _primaryColorDark,brightness: Brightness.dark));

  static const TextStyle _lightHeadingText = TextStyle(
      color: _lightTextPrimaryColor,
      fontFamily: "Rubik",
      fontSize: 20,
      fontWeight: FontWeight.bold);
  static const TextStyle _lightBodyText = TextStyle(
      color: _lightTextPrimaryColor,
      fontFamily: "Rubik",
      fontStyle: FontStyle.italic,
      fontSize: 16,
      fontWeight: FontWeight.bold);

  static const TextTheme _lightTextTheme = TextTheme(
    // ignore: deprecated_member_use
    headline1: _lightHeadingText,
    // ignore: deprecated_member_use
    bodyText1: _lightBodyText,
  );

  static final TextStyle _darkThemeHeadingTextStyle =
      _lightHeadingText.copyWith(color: _darkTextColorPrimary);
  
  static final TextStyle _darkThemeBodyTextStyle =
      _lightBodyText.copyWith(color: _darkTextColorPrimary);
  
  static final TextTheme _darkTextTheme = TextTheme(
    // ignore: deprecated_member_use
    headline1: _darkThemeHeadingTextStyle,
    // ignore: deprecated_member_use
    bodyText1: _darkThemeBodyTextStyle,
  );


  static final ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: _lightPrimaryColor,
    appBarTheme: const AppBarTheme(
      color: _appbarPrimaryColor,
      iconTheme: IconThemeData(color: _iconColor)
    ),
    // ignore: deprecated_member_use
    bottomAppBarColor: _appbarPrimaryColor, 
    colorScheme: ColorScheme.light(
      primary: _lightPrimaryColor,
      onPrimary: _lightOnPrimaryColor,
      secondary: _accentColor,
      primaryContainer: _lightPrimaryVariantColor,
    ),
    textTheme: _lightTextTheme
      );

  static final ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: _darkPrimaryColor,
    appBarTheme: const AppBarTheme(
      color: _appbarColorDark,
      iconTheme: IconThemeData(color: _iconColor)
    ),
    
    // ignore: deprecated_member_use
    bottomAppBarColor: _appbarColorDark, 
    colorScheme: ColorScheme.dark(
      primary: _darkPrimaryColor,
      onPrimary: _darkOnPrimaryColor,
      secondary: _accentColor,
      primaryContainer: _darkPrimaryVariantColor,
    ),
    textTheme: _darkTextTheme
      );
}