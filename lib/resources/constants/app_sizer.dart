import 'package:flutter/material.dart';

extension MediaQueryValues on BuildContext {
  double get screenWidth => MediaQuery.of(this).size.width;
  double get screenHeight => MediaQuery.of(this).size.height;
}

extension TextThemes on BuildContext {
  TextTheme get textTheme => Theme.of(this).textTheme;
  TextStyle get headline1 => textTheme.displayLarge!;
  TextStyle get bodyText1 => textTheme.bodyLarge!;
}
