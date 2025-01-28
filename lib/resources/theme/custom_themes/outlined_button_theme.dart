import 'package:flutter/material.dart';

import '../../constants/color.dart';
import '../../constants/sizes.dart';

class SOutlineButtonTheme {
  SOutlineButtonTheme._();

  static final lightOutlineButtonTheme = OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
    elevation: 0,
    foregroundColor: AppColors.dark,
    side: const BorderSide(color: AppColors.primary),
    textStyle: const TextStyle(
        fontSize: SSizes.fontSizeMd,
        color: AppColors.dark,
        fontWeight: FontWeight.w600),
    padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
  ));

  static final darkOutlineButtonTheme = OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
    elevation: 0,
    foregroundColor: AppColors.white,
    side: const BorderSide(color: AppColors.primary),
    textStyle: const TextStyle(
        fontSize: SSizes.fontSizeMd,
        color: AppColors.white,
        fontWeight: FontWeight.w600),
    padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
  ));
}
