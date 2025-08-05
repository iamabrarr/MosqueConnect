import 'package:flutter/material.dart';
import 'package:mosqueconnect/constants/colors.dart';
import 'package:mosqueconnect/utils/size_config.dart';

class AppTheme {
  static ThemeData primaryTheme = ThemeData(
    useMaterial3: false,
    fontFamily: 'Poppins',
    appBarTheme: AppBarTheme(backgroundColor: AppColors.bgColor),
    scaffoldBackgroundColor: AppColors.bgColor,
    primaryColor: AppColors.primary,
    textTheme: TextTheme(
      displaySmall: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.w400,
        fontSize: SizeConfig.textMultiplier * 1.2,
      ),
      bodySmall: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.w400,
        fontSize: SizeConfig.textMultiplier * 1.4,
      ),
      bodyMedium: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.w400,
        fontSize: SizeConfig.textMultiplier * 1.6,
      ),
      bodyLarge: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.w400,
        fontSize: SizeConfig.textMultiplier * 1.8,
      ),
      displayLarge: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.w400,
        fontSize: SizeConfig.textMultiplier * 2,
      ),
      headlineSmall: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.w600,
        fontSize: SizeConfig.textMultiplier * 2.2,
      ),
      headlineMedium: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.w600,
        fontSize: SizeConfig.textMultiplier * 2.5,
      ),
      headlineLarge: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.w600,
        fontSize: SizeConfig.textMultiplier * 3,
      ),
    ),
    colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
  );

  //   static ThemeData darkTheme = ThemeData(
  //     textTheme: TextTheme(
  //       displaySmall: TextStyle(
  //         color: Colors.white,
  //         fontWeight: FontWeight.w400,
  //         fontSize: SizeConfig.textMultiplier * 1.2,
  //       ),
  //       bodySmall: TextStyle(
  //         color: Colors.white,
  //         fontWeight: FontWeight.w400,
  //         fontSize: SizeConfig.textMultiplier * 1.4,
  //       ),
  //       bodyMedium: TextStyle(
  //         color: Colors.white,
  //         fontWeight: FontWeight.w400,
  //         fontSize: SizeConfig.textMultiplier * 1.6,
  //       ),
  //       bodyLarge: TextStyle(
  //         color: Colors.white,
  //         fontWeight: FontWeight.w400,
  //         fontSize: SizeConfig.textMultiplier * 1.8,
  //       ),
  //       displayLarge: TextStyle(
  //         color: Colors.white,
  //         fontWeight: FontWeight.w400,
  //         fontSize: SizeConfig.textMultiplier * 2,
  //       ),
  //       headlineSmall: TextStyle(
  //         color: Colors.white,
  //         fontWeight: FontWeight.w600,
  //         fontSize: SizeConfig.textMultiplier * 2.2,
  //       ),
  //       headlineMedium: TextStyle(
  //         color: Colors.white,
  //         fontWeight: FontWeight.w600,
  //         fontSize: SizeConfig.textMultiplier * 2.5,
  //       ),
  //       headlineLarge: TextStyle(
  //         color: Colors.white,
  //         fontWeight: FontWeight.w600,
  //         fontSize: SizeConfig.textMultiplier * 3.2,
  //       ),
  //     ),
  //     fontFamily: 'Poppins',

  //     // fontFamily: 'Poppins',
  //     scaffoldBackgroundColor: Colors.black,
  //     // colorScheme: ColorScheme.dark(primary: AppColors.primary),
  //   );
}
