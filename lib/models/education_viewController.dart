import 'dart:developer';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:isentcare/modals/education_modal.dart';
import 'package:isentcare/navigation_menu.dart';
import 'package:isentcare/repo/education_repo.dart';
import 'package:isentcare/resources/constants/app_strings.dart';
import 'package:isentcare/resources/utils.dart';

import '../network_data/response/api_response.dart';

class EducationController extends GetxController {
  final _myRepo = EducationRepository();
  var educationDetails = ApiResponse<List<EducationModel>>.loading().obs;
  var countryDetails = ApiResponse<List<Country>>.loading().obs;

  // Method to set education details
  setEducationDetails(ApiResponse<List<EducationModel>> response) {
    educationDetails.value = response;
  }

  // Method to set country details
  setCountryDetails(ApiResponse<List<Country>> response) {
    countryDetails.value = response;
  }

  Future<void> fetchEducations() async {
    setEducationDetails(ApiResponse.loading());
    try {
      var educations = await _myRepo.getEducations();
      if (educations != null && educations is List) {
        List<EducationModel> educationList = educations
            .map((item) => EducationModel.fromJson(
                item)) // Convert each map to EducationModel
            .toList();

        setEducationDetails(ApiResponse.completed(educationList));
      } else {
        setEducationDetails(ApiResponse.error(AppStrings.somethingWentWrong));
      }
    } catch (e) {
      log(e.toString());
      setEducationDetails(ApiResponse.error(e.toString()));
    }
  }

  Future<void> addEducations(dynamic data, BuildContext context) async {
    EasyLoading.show();
    try {
      await _myRepo.addEducation(data);

      EasyLoading.dismiss();
      Utils.showSuccess("Added Education Successfully");
      await fetchEducations();
      Get.back();
    } catch (error) {
      EasyLoading.dismiss();

      hanldeError(error, context);
    }
  }

  Future<void> addReference(dynamic data, BuildContext context) async {
    EasyLoading.show();
    try {
      await _myRepo.addReference(data);

      EasyLoading.dismiss();
      Utils.showSuccess("Added Reference Successfully");
      Get.back();
    } catch (error) {
      EasyLoading.dismiss();
      if (error is String) {
        Utils.showError(error); 
      } else if (error is Map<String, dynamic> &&
          error.containsKey('details')) {

        Utils.showError(
            error['details']); 
      } else {
        hanldeError(error, context); 
      }
    }
  }

  Future<void> deleteEducations(int id, BuildContext context) async {
    EasyLoading.show();
    try {
      await _myRepo.deleteEducation(id);

      EasyLoading.dismiss();
      Utils.showSuccess("Deleted Education Successfully");
      await fetchEducations();
    } catch (error) {
      EasyLoading.dismiss();

      hanldeError(error, context);
    }
  }

  Future<void> fetchCountries() async {
    setCountryDetails(ApiResponse.loading());
    try {
      var countries = await _myRepo.getCountries();
      print('Raw API Response: $countries');
      if (countries != null &&
          countries.containsKey('results') &&
          countries is Map) {
        List<Country> countryList = (countries['results'] as List<dynamic>)
            .map((item) => Country.fromJson(item))
            .toList();
        print('Parsed Country List: $countryList');

        setCountryDetails(ApiResponse.completed(countryList));
      } else {
        print('Error: Response does not contain results');
        setCountryDetails(ApiResponse.error(AppStrings.somethingWentWrong));
      }
    } catch (e) {
      log(e.toString());
      setCountryDetails(ApiResponse.error(e.toString()));
    }
  }

  Future<void> updateEducation(
      dynamic data, BuildContext context, int educationId) async {
    EasyLoading.show();
    try {
      await _myRepo.updateEducation(data, educationId);

      await fetchEducations();

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
    } else if (error.toString().contains("Invalid password")) {
      Utils.errorSnakbar(context, "Invalid password");
    } else if (error.toString().contains("User not found")) {
      Utils.errorSnakbar(context, "User not found");
    } else {
      log("error $error");

      // Utils.errorSnakbar(context, error.toString());
    }
  }
}
