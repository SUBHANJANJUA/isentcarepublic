import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'constants/color.dart';

class Utils {
  static void configLoading() {
    EasyLoading.instance
      ..displayDuration = const Duration(seconds: 2)
      ..indicatorType = EasyLoadingIndicatorType.threeBounce
      ..loadingStyle = EasyLoadingStyle.custom
      ..indicatorSize = 45.0
      ..radius = 10.0
      ..progressColor = Colors.white
      ..backgroundColor = Colors.white
      ..indicatorColor = AppColors.primary
      ..textColor = AppColors.primary
      ..maskColor = AppColors.primary
      ..userInteractions = false
      ..dismissOnTap = false;
  }

  static void showError(String message) {
    EasyLoading.dismiss();
    EasyLoading.showError(message);
  }

  static void showSuccess(String message) {
    EasyLoading.dismiss();
    EasyLoading.showSuccess(message);
  }

  static void showInfo(String message) {
    EasyLoading.dismiss();
    EasyLoading.showInfo(message);
  }

  static void otpSnakbar(BuildContext context, String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Row(
        children: <Widget>[
          const Icon(
            Icons.error_outline,
            color: Colors.white,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              msg,
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      duration: const Duration(seconds: 3), // Adjust the duration as needed
      backgroundColor: AppColors.primary,
      action: SnackBarAction(
        label: 'Dismiss',
        onPressed: () {
          ScaffoldMessenger.of(context).removeCurrentSnackBar();
        },
        textColor: Colors.white,
      ),
      behavior: SnackBarBehavior.floating,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
    ));
  }

  static void errorSnakbar(BuildContext context, String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Row(
        children: <Widget>[
          const Icon(
            Icons.error_outline,
            color: Colors.white,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              msg,
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      duration: const Duration(seconds: 3), // Adjust the duration as needed
      backgroundColor: Colors.red,
      action: SnackBarAction(
        label: 'Dismiss',
        onPressed: () {
          ScaffoldMessenger.of(context).removeCurrentSnackBar();
        },
        textColor: Colors.white,
      ),
      behavior: SnackBarBehavior.floating,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
    ));
  }
}
