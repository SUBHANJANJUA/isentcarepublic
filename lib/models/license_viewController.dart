import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:isentcare/feature/isent_care/view/profile/setting/setting.dart';
import 'package:isentcare/modals/license_modal.dart';
import 'package:isentcare/repo/license_repo.dart';
import 'package:isentcare/resources/utils.dart';

import '../network_data/response/api_response.dart';

class LicenseController extends GetxController {
  final _myRepo = LicenseRepository();
  var licenseDetails = ApiResponse<List<LicenseModel>>.loading().obs;

  setLicenseDetails(ApiResponse<List<LicenseModel>> response) {
    licenseDetails.value = response;
  }

  Future<void> fetchLicense() async {
    setLicenseDetails(ApiResponse.loading());
    try {
      var licenses = await _myRepo.getLicenses();
      setLicenseDetails(ApiResponse.completed(licenses));
    } catch (e) {
      log(e.toString());
      setLicenseDetails(ApiResponse.error(e.toString()));
    }
  }

  Future<void> addLicense(dynamic data, BuildContext context) async {
    EasyLoading.show();
    try {
      // Prepare data with multiple selected states
      Map<String, dynamic> requestData = {
        'number': data['number'],
        'expiry_date': data['expiry_date'],
        'profession': data['profession'],
        'primary_state': data['primary_state'],
        'state': data['state'], // Add all selected state indices here
      };

      // Call the addLicense method in the repository
      await _myRepo.addLicense(requestData);

      EasyLoading.dismiss();
      Utils.showSuccess("Added License Successfully");
      await fetchLicense();
      Get.to(() => SettingScreen());
    } catch (error) {
      EasyLoading.dismiss();
      Utils.showInfo("You have already added the License");
      Get.to(() => SettingScreen());

      hanldeError(error, context);
    }
  }

  Future<void> updateLicense(
      dynamic data, BuildContext context, int LicenseId) async {
    EasyLoading.show();
    try {
      await _myRepo.updateLicense(data, LicenseId);

      await fetchLicense();

      EasyLoading.dismiss();
      Utils.showSuccess("Data Updates Successfully");

      Get.back();
    } catch (error) {
      EasyLoading.dismiss();
      log("Res occurred: $error");
      Utils.showError("An error occurred: $error");
    }
  }

  hanldeError(error, context) {
    EasyLoading.dismiss();
    log("error $error");
    log("stackTrace $error.stackTrace");

    if (error.toString().contains("Error Occured while ")) {
      Utils.errorSnakbar(context, error.toString());
    } else if (error
        .toString()
        .contains("Error During Communication No Internet Connection")) {
      Utils.errorSnakbar(context, "No Internet Connection");
    } else if (error
        .toString()
        .contains("type: You have already added a license")) {
      Utils.errorSnakbar(context, " You have already added a license");
    } else {
      log("error $error");
    }
  }
}
