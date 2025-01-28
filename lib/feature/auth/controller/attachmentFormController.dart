import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Attachmentformcontroller extends GetxController {
  final TextEditingController expiredobController1 = TextEditingController();
  final TextEditingController expiredobController2 = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController relationController = TextEditingController();
  final TextEditingController otherAttachController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final identityController = TextEditingController();
  final RxString selectedIdentity = ''.obs;

  @override
  void onInit() {
    super.onInit();
    identityController.addListener(() {
      selectedIdentity.value = identityController.text;
    });
  }

  @override
  void onClose() {
    identityController.dispose();

    super.onClose();
  }

  final idEmpController = TextEditingController();
  final empAuthController = TextEditingController();
  final idDocController = TextEditingController();
  var isExpire1 = true.obs;
  void expireDate1() {
    String pickedDate = expiredobController1.text;
    if (pickedDate.isEmpty) {
      isExpire1.value = false;
    } else {
      isExpire1.value = isFutureDate(pickedDate);
    }
  }

  var isExpire2 = true.obs;
  void expireDate2() {
    String pickedDate = expiredobController2.text;
    if (pickedDate.isEmpty) {
      isExpire2.value = false;
    } else {
      isExpire2.value = isFutureDate(pickedDate);
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
