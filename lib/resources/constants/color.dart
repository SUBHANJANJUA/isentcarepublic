import 'package:flutter/material.dart';

class AppColors {
  AppColors._();
  // AppBar
  static const Color icondark = Colors.black;
  static const Color iconColorin = Colors.white;

  static const Color iconColor = Color(0xff1D66A5);

  // App Basic Colors
  static const Color primary = Color(0xff1d66a5);
  static const Color secondary = Color(0xff2c344c); // new
  static const Color accent = Color(0xff2c344c);

  // Text Colors
  static const Color textPrimary = Color(0xff1d66a5);
  static const Color textSecondary = Color.fromARGB(255, 5, 73, 151);
  static const Color lightBlueColor = Color(0xFFE5F1FF);
  static const Color textWhite = Colors.white;
  static const Color textinbox = Colors.white;

  // background Colors
  static const Color light = Color(0xfff6f6f6);
  static const Color dark = Color(0xff272727);
  static const Color primaryBackground = Color(0xfff3f5ff);

  // dark background Colors
  static const Color backgroundContainer = Color(0xFFe8eff6);
  static const Color grayBackgroundContainer = Color(0xffabc5db);

  // background Container Colors
  static const Color lightContainer = Color(0xfff6f6f6);
  static Color darkContainer = Colors.white.withOpacity(0.1);

  // Button Colors
  static const Color buttonPrimary = Color(0xFF7E3636);
  static const Color buttonSecondary = Colors.white;
  static const Color buttonDisabled = Colors.white;

  // Border Colors
  static const Color barderPrimary = Color(0xffd9d9df);
  static const Color barderSecondary = Color(0xffe6e6ef);

  // Error and Validation Colors
  static const Color error = Color(0xFFEF2F2F);
  static const Color sucess = Color(0xff388e3c);
  static const Color warning = Color(0xFFB5880D);
  static const Color info = Color(0xFF0040FF);
  static const Color lighterror = Color(0xFFFFDCDC);
  static const Color lighterror2 = Color(0xffFFE0E0);

  // Neutral Shades
  static const Color black = Color(0xff232323);
  static const Color darkerGrey = Color(0xff4f4f4f);
  static const Color darkGrey = Color(0xff939393);
  static const Color grey = Color(0xffe0e0e0);
  static const Color lightGrey = Color(0xfff9f9f9);
  static const Color white = Colors.white;

  // Gradient Colors
  static const Gradient linerGradient = LinearGradient(
      begin: Alignment(0.0, 0.0),
      end: Alignment(0.707, -0.707),
      colors: [Color(0xff2c344c), Color(0xff2c344c), Color(0xff2c344c)]);

  // Chat Color
  static const Color senderColor = primary;
  static const Color receiverColor = white;
  static const Color chatGreyColor = Color(0xFF71717A);
  static const Color borderGrey = Color(0xffDFDFDF);

  // navigation
  static const Color navigationBackground = Color(0xffe8eff6);
}
