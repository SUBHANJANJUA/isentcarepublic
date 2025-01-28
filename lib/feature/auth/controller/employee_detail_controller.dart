import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EmployeeDetailController extends GetxController {
  final TextEditingController licenseController = TextEditingController();
  final TextEditingController licensenumberController = TextEditingController();
  final TextEditingController licensestateController = TextEditingController();
  final TextEditingController primaystateController = TextEditingController();

  final TextEditingController expiredobController = TextEditingController();
  void logValues() {
    log(licenseController.text);
    log(licensenumberController.text);
    log(licensestateController.text);
    log(primaystateController.text);

    log(expiredobController.text);
  }

  var isEligible = true.obs;
  void validLicense() {
    String pickedDate = expiredobController.text;
    if (pickedDate.isEmpty) {
      isEligible.value = false;
    } else {
      isEligible.value = isFutureDate(pickedDate);
    }
  }

  bool isFutureDate(String pickedDate) {
    try {
      DateTime selectedDate = DateTime.parse(pickedDate);
      DateTime today = DateTime.now();

      return selectedDate.isAfter(today);
    } catch (e) {
      return false;
    }
  }
}
