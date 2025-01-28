import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:isentcare/modals/employer_modal.dart';
import 'package:isentcare/repo/employer_repo.dart';
import 'package:isentcare/resources/constants/app_strings.dart';
import 'package:isentcare/resources/utils.dart';

import '../network_data/response/api_response.dart';

class EmployerController extends GetxController {
  final _myRepo = EmployerRepository();
  var employDetails = ApiResponse<List<EmployerModel>>.loading().obs;
  // var countryDetails = ApiResponse<List<Country>>.loading().obs;

  // Method to set education details
  setEmployerDetails(ApiResponse<List<EmployerModel>> response) {
    employDetails.value = response;
  }

  // Method to set country details
  // setCountryDetails(ApiResponse<List<Country>> response) {
  //   countryDetails.value = response;
  // }

  Future<void> fetchEmployers() async {
    setEmployerDetails(ApiResponse.loading());
    try {
      var employers = await _myRepo.getEmployers();
      if (employers != null && employers is List) {
        List<EmployerModel> employerList =
            employers.map((item) => EmployerModel.fromJson(item)).toList();

        setEmployerDetails(ApiResponse.completed(employerList));
      } else {
        setEmployerDetails(ApiResponse.error(AppStrings.somethingWentWrong));
      }
    } catch (e) {
      log(e.toString());
      setEmployerDetails(ApiResponse.error(e.toString()));
    }
  }

  Future<void> addEmployer(dynamic data, BuildContext context) async {
    EasyLoading.show();
    try {
      await _myRepo.addEmploye(data);

      EasyLoading.dismiss();
      Utils.showSuccess("Added Employee Successfully");
      await fetchEmployers();
      Get.back();
    } catch (error) {
      EasyLoading.dismiss();

      hanldeError(error, context);
    }
  }

  Future<void> deleteEmployee(int id, BuildContext context) async {
    EasyLoading.show();
    try {
      await _myRepo.deleteEmployee(id);

      EasyLoading.dismiss();
      Utils.showSuccess("Deleted Employee Successfully");
      await fetchEmployers();
    } catch (error) {
      EasyLoading.dismiss();

      hanldeError(error, context);
    }
  }

  Future<void> updateEmployer(
      dynamic data, BuildContext context, int employId) async {
    EasyLoading.show();
    try {
      await _myRepo.updateEmployers(data, employId);

      await fetchEmployers();

      EasyLoading.dismiss();
      Utils.showSuccess("Data Updates Successfully");

      Get.back();
    } catch (error) {
      EasyLoading.dismiss();
      log("Res occurred: $error");
      Utils.showError("An error occurred: $error");
    }
  }
  // Future<void> fetchCountries() async {
  //   setCountryDetails(ApiResponse.loading());
  //   try {
  //     var countries = await _myRepo.getCountries();
  //     print('Raw API Response: $countries');
  //     if (countries != null &&
  //         countries.containsKey('results') &&
  //         countries is Map) {
  //       List<Country> countryList = (countries['results'] as List<dynamic>)
  //           .map((item) => Country.fromJson(item))
  //           .toList();
  //       print('Parsed Country List: $countryList');

  //       setCountryDetails(ApiResponse.completed(countryList));
  //     } else {
  //       print('Error: Response does not contain results');
  //       setCountryDetails(ApiResponse.error(AppStrings.somethingWentWrong));
  //     }
  //   } catch (e) {
  //     log(e.toString());
  //     setCountryDetails(ApiResponse.error(e.toString()));
  //   }
  // }

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
    }
  }
}
