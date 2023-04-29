import 'package:flutter/material.dart';
import 'package:paye_ton_kawa/styles/custom_colors.dart';

class CustomTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      primaryColor: CustomColors.lightBrown,
      scaffoldBackgroundColor: Colors.white,
      fontFamily: 'Roboto',
      buttonTheme: ButtonThemeData(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
        buttonColor: CustomColors.gold,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
          backgroundColor: CustomColors.gold,
          foregroundColor: CustomColors.lightBrown,
        ),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        backgroundColor: CustomColors.transpLightBrown,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: CustomColors.lightBrown,
        foregroundColor: CustomColors.gold,
        titleTextStyle: TextStyle(
          color: CustomColors.gold,
          fontFamily: 'Satisfy',
          fontSize: 36,
        )
      ),
    );
  }
}