import 'package:flutter/material.dart';

import '../../constants/color.dart';
import '../../constants/sizes.dart';

class SAppBarTheme {
  SAppBarTheme._();

  static const lightAppBarTheme = AppBarTheme(
      elevation: 1,
      centerTitle: false,
      toolbarHeight: 80,
      scrolledUnderElevation: 0,
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.white,
      shadowColor: Colors.blue,
      iconTheme:
          IconThemeData(color: AppColors.icondark, size: SSizes.iconMedium),
      actionsIconTheme:
          IconThemeData(color: AppColors.icondark, size: SSizes.iconMedium),
      titleTextStyle: TextStyle(
          fontSize: SSizes.fontSizeLg,
          fontWeight: FontWeight.w600,
          color: AppColors.dark));

  static const darkAppBarTheme = AppBarTheme(
      elevation: 0,
      centerTitle: false,
      scrolledUnderElevation: 0,
      backgroundColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      iconTheme:
          IconThemeData(color: AppColors.icondark, size: SSizes.iconMedium),
      actionsIconTheme:
          IconThemeData(color: AppColors.iconColorin, size: SSizes.iconMedium),
      titleTextStyle: TextStyle(
          fontSize: SSizes.fontSizeLg,
          fontWeight: FontWeight.w600,
          color: AppColors.textWhite));
}
