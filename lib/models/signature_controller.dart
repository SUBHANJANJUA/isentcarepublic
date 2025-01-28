import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:isentcare/resources/utils.dart';
import 'package:signature/signature.dart';

class SignController extends GetxController {
  var signatureBase64 = RxnString();
  late SignatureController signatureController;
  final signatureTextController = TextEditingController();
  RxBool signEmpty = true.obs;

  @override
  void onInit() {
    super.onInit();

    signatureController =
        SignatureController(penStrokeWidth: 2, penColor: Colors.black);
  }

  void checkSignEmpty() {
    signEmpty.value = signatureTextController.text.isEmpty;
  }

  Future<void> saveSignature(SignatureController signatureController) async {
    if (!signatureController.isEmpty) {
      final imageBytes = await signatureController.toPngBytes();
      if (imageBytes != null) {
        signatureBase64.value = base64Encode(imageBytes);
        signatureTextController.text =
            "Signature Saved"; // Set a value in the text field
        checkSignEmpty(); // Update the empty check status
        log("Signature saved as Base64: ${signatureBase64.value}");
        Utils.showSuccess("Signature saved successfully");
      } else {
        Utils.showError("Failed to save signature");
      }
    } else {
      Utils.showError("Add Signature");
    }
  }

  // Clear the signature
  void clearSignature() {
    signatureController.clear();
    signatureTextController.clear(); // Clear the text controller
    checkSignEmpty(); // Update the empty check status
  }
}
