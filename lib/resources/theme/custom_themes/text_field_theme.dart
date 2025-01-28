import 'package:flutter/material.dart';

import '../../constants/color.dart';
import '../../constants/sizes.dart';

class STextFormFieldTheme {
  STextFormFieldTheme._();

  static InputDecorationTheme lightInputDecorationTheme = InputDecorationTheme(
    filled: true,
    fillColor: AppColors.grey,
    errorMaxLines: 3,
    prefixIconColor: AppColors.iconColor,
    suffixIconColor: AppColors.iconColor,
    labelStyle: const TextStyle()
        .copyWith(fontSize: SSizes.fontSizeSm, color: AppColors.dark),
    hintStyle: const TextStyle()
        .copyWith(fontSize: SSizes.fontSizeSm, color: AppColors.dark),
    errorStyle: const TextStyle().copyWith(fontStyle: FontStyle.normal),
    floatingLabelStyle:
        const TextStyle().copyWith(color: AppColors.dark.withOpacity(0.8)),
    border: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(SSizes.borderRadiusLg),
      borderSide: const BorderSide(width: 1, color: AppColors.grey),
    ),
    enabledBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(SSizes.borderRadiusLg),
      borderSide: const BorderSide(width: 1, color: AppColors.grey),
    ),
    focusedBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(SSizes.borderRadiusLg),
      borderSide: const BorderSide(width: 1, color: AppColors.grey),
    ),
    errorBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(SSizes.borderRadiusLg),
      borderSide: const BorderSide(width: 1, color: AppColors.error),
    ),
    focusedErrorBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(SSizes.borderRadiusLg),
      borderSide: const BorderSide(width: 2, color: AppColors.grey),
    ),
  );

  static InputDecorationTheme darkInputDecorationTheme = InputDecorationTheme(
    errorMaxLines: 3,
    prefixIconColor: AppColors.iconColor,
    suffixIconColor: AppColors.iconColor,
    labelStyle: const TextStyle()
        .copyWith(fontSize: SSizes.fontSizeSm, color: AppColors.white),
    hintStyle: const TextStyle()
        .copyWith(fontSize: SSizes.fontSizeSm, color: AppColors.white),
    errorStyle: const TextStyle().copyWith(fontStyle: FontStyle.normal),
    floatingLabelStyle:
        const TextStyle().copyWith(color: AppColors.white.withOpacity(0.8)),
    border: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(SSizes.borderRadiusLg),
      borderSide: const BorderSide(width: 1, color: AppColors.grey),
    ),
    enabledBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(SSizes.borderRadiusLg),
      borderSide: const BorderSide(width: 1, color: AppColors.grey),
    ),
    focusedBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(SSizes.borderRadiusLg),
      borderSide: const BorderSide(width: 1, color: AppColors.grey),
    ),
    errorBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(SSizes.borderRadiusLg),
      borderSide: const BorderSide(width: 1, color: AppColors.error),
    ),
    focusedErrorBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(SSizes.borderRadiusLg),
      borderSide: const BorderSide(width: 2, color: AppColors.warning),
    ),
  );
}
