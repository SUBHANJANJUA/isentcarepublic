import 'package:flutter/material.dart';
import 'package:isentcare/resources/constants/color.dart';
import 'package:isentcare/resources/theme/custom_themes/elevated_button_theme.dart';
import 'package:isentcare/resources/theme/custom_themes/text_field_theme.dart';

import 'custom_themes/appbar_theme.dart';

class SAppTheme {
  SAppTheme._();

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'poppins',
    brightness: Brightness.light,
    scaffoldBackgroundColor: Colors.white,
    
    // primaryColor: AppColors.primary,
    // chipTheme: SChipTheme.lightChipTheme,
    // textTheme: STextTheme.lightTextTheme,
    appBarTheme: SAppBarTheme.lightAppBarTheme,
    radioTheme: const RadioThemeData(
      fillColor: WidgetStatePropertyAll(AppColors.iconColor),
      visualDensity: VisualDensity.compact,
    ),
    // checkboxTheme: SCheckBoxTheme.lightCheckboxTheme,
    // bottomSheetTheme: SBottomSheetTheme.lightBottomSheetTheme,
    elevatedButtonTheme: SElevatedButtonTheme.lightElevatedButtonTheme,
    // outlinedButtonTheme: SOutlineButtonTheme.lightOutlineButtonTheme,
    inputDecorationTheme: STextFormFieldTheme.lightInputDecorationTheme,
  );
  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Roboto',
    brightness: Brightness.dark,
    // primaryColor: AppColors.primary,
    // chipTheme: SChipTheme.darkChipTheme,
    // scaffoldBackgroundColor: Colors.black,
    // textTheme: STextTheme.dartTextTheme,
    // appBarTheme: SAppBarTheme.darkAppBarTheme,
    // checkboxTheme: SCheckBoxTheme.darkCheckboxTheme,
    // bottomSheetTheme: SBottomSheetTheme.darkBottomSheetTheme,
    // elevatedButtonTheme: SElevatedButtonTheme.darkElevatedButtonTheme,
    // outlinedButtonTheme: SOutlineButtonTheme.darkOutlineButtonTheme,
    // inputDecorationTheme: STextFormFieldTheme.darkInputDecorationTheme,
  );
}
