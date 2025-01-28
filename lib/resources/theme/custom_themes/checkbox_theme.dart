import 'package:flutter/material.dart';

import '../../constants/color.dart';
import '../../constants/sizes.dart';

/// Custom Class for Light & dark themes
class SCheckBoxTheme {
  SCheckBoxTheme._();

  /// Customizable Light Text theme
  static CheckboxThemeData lightCheckboxTheme = CheckboxThemeData(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(SSizes.borderRadiusSm)),
      checkColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return AppColors.white;
        } else {
          return AppColors.dark;
        }
      }),
      fillColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return AppColors.primary;
        } else {
          return Colors.transparent;
        }
      }));

  /// Customizable Light Text theme
  static CheckboxThemeData darkCheckboxTheme = CheckboxThemeData(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(SSizes.borderRadiusSm)),
      checkColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return AppColors.white;
        } else {
          return AppColors.dark;
        }
      }),
      fillColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return AppColors.primary;
        } else {
          return Colors.transparent;
        }
      }));
}
