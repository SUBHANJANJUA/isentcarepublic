import 'package:flutter/material.dart';

import '../../constants/color.dart';

class SChipTheme {
  SChipTheme._();

  static ChipThemeData lightChipTheme = ChipThemeData(
      disabledColor: AppColors.grey.withOpacity(0.4),
      labelStyle: const TextStyle(color: AppColors.dark),
      selectedColor: AppColors.primary,
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12),
      checkmarkColor: Colors.white);

  static ChipThemeData darkChipTheme = const ChipThemeData(
      disabledColor: AppColors.grey,
      labelStyle: TextStyle(color: AppColors.white),
      selectedColor: AppColors.primary,
      padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 12),
      checkmarkColor: Colors.white);
}
