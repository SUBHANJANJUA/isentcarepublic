import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:isentcare/modals/myshift_modal.dart';
import 'package:isentcare/modals/shift_modal.dart';
import 'package:isentcare/navigation_menu.dart';
import 'package:isentcare/repo/shift_repo.dart';
import 'package:isentcare/resources/utils.dart';

import '../network_data/response/api_response.dart';

class ShiftController extends GetxController {
  final _myRepo = ShiftRepository();
  var shiftDetails = ApiResponse<ShiftModel>.loading().obs;
  var myshiftDetails = ApiResponse<MyShiftModel>.loading().obs;
  var isshiftLoadingMore = false.obs;

  Rx<int> _currentPage = 1.obs;

  // Method to set education details
  setShiftDetails(ApiResponse<ShiftModel> response) {
    shiftDetails.value = response;
  }

  setMyShiftDetails(ApiResponse<MyShiftModel> response) {
    myshiftDetails.value = response;
  }

Future<void> fetchShift({bool isLoadMore = false}) async {
  if (isshiftLoadingMore.value) return;

  try {
    isshiftLoadingMore.value = true;

    if (!isLoadMore) {
      _currentPage.value = 1; // Reset page if not loading more
      setShiftDetails(ApiResponse.loading());
    }

    var shifts = await _myRepo.getShifts(_currentPage.value);
    log('Fetched data: ${shifts.results.length} results');
    log('Next page URL: ${shifts.next}');

    if (isLoadMore) {
      List<Result> currentResults = shiftDetails.value.data?.results ?? [];
      final updatedResults = [...currentResults, ...shifts.results];
      final updatedData = shifts.copyWith(results: updatedResults);
      setShiftDetails(ApiResponse.completed(updatedData));
    } else {
      setShiftDetails(ApiResponse.completed(shifts));
    }

    if (shifts.next != null) {
      _currentPage.value++;
    }
  } catch (e) {
    log(e.toString());
    setShiftDetails(ApiResponse.error(e.toString()));
  } finally {
    isshiftLoadingMore.value = false;
  }
}


  Future<void> fetchMyShift({bool isLoadMore = false}) async {
    if (isshiftLoadingMore.value) return;

    try {
      isshiftLoadingMore.value = true;

      if (!isLoadMore) {
        _currentPage.value = 1;
        setMyShiftDetails(ApiResponse.loading());
      }
      var myshifts = await _myRepo.getMyShift(_currentPage.value);
      log('Fetched data: ${myshifts.results.length} results');

      log('Next page URL: ${myshifts.next}');
      if (isLoadMore) {
        List<ShiftResult> currentResults =
            myshiftDetails.value.data?.results ?? [];

        final updatedResults = [...currentResults, ...myshifts.results];
        final updatedData = myshifts.copyWith(results: updatedResults);
        setMyShiftDetails(ApiResponse.completed(updatedData));
      } else {
        setMyShiftDetails(ApiResponse.completed(myshifts));
      }
      if (myshifts.next != null) {
      _currentPage.value++;
    }
    } catch (e) {
      log(e.toString());
      setMyShiftDetails(ApiResponse.error(e.toString()));
    }finally{
      isshiftLoadingMore.value = false;
    }
  }

  Future<void> startShift(dynamic data, BuildContext context) async {
    try {
      EasyLoading.show(status: 'Loading...');
      Get.back();

      final response = await _myRepo.createShift(data);
      EasyLoading.dismiss();
      Get.offAll(() => NavigationMenu());
      Utils.showSuccess("Start Shift Successfully");
    } catch (error) {
      EasyLoading.dismiss();

      hanldeError(error, context);
      Utils.showError("Something went wrong");
    }
  }

  Future<void> dropShift(int shiftId, BuildContext context) async {
    try {
      EasyLoading.show(status: 'Dropping shift...');
      await _myRepo.dropShift(shiftId);
      EasyLoading.dismiss();
      Get.back();
      Utils.showSuccess("Shift dropped successfully");
      fetchMyShift();
    } catch (error) {
      EasyLoading.dismiss();
      hanldeError(error, context);
      Utils.showError("Failed to drop shift");
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
    }
  }
}
