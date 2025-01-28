import 'package:get/get.dart';
import 'package:flutter/material.dart';

class CitizenshipController extends GetxController {
  var selectedOption = 1.obs;

  TextEditingController uscisController = TextEditingController();
  TextEditingController passportController = TextEditingController();

  void updateSelectedOption(int value) {
    selectedOption.value = value;
  }
}
