import 'dart:developer';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:isentcare/modals/todayshift_modal.dart';
import 'package:isentcare/network_data/response/api_response.dart';
import 'package:isentcare/repo/todayshift_repo.dart';
import 'package:isentcare/resources/utils.dart';
import 'package:isentcare/splash_Screen.dart';

class TodayShiftController extends GetxController {
  var todayshiftDetails = ApiResponse<TodayShiftModel>.loading().obs;
  final _myRepo = TodayShiftRepository();

// Method to set education details
  setTodayShiftDetails(ApiResponse<TodayShiftModel> response) {
    todayshiftDetails.value = response;
  }

  Future<void> fetchTodayShift() async {
    setTodayShiftDetails(ApiResponse.loading());
    try {
      var shifts = await _myRepo.getTodayShifts();
      setTodayShiftDetails(ApiResponse.completed(shifts));
    } catch (e) {
      log(e.toString());
      setTodayShiftDetails(ApiResponse.error(e.toString()));
    }
  }

  Future<void> punchOut(int punchoutId) async {
    EasyLoading.show();
    try {
      final result = await _myRepo.punchOut(punchoutId);

      log('PunchOut Result: $result');
      await fetchTodayShift();
      EasyLoading.dismiss();
      Utils.showSuccess("PunchOut Successfully");
      Get.back();
    } catch (error) {
      EasyLoading.dismiss();
      log("Res occurred: $error");
      Utils.showError("An error occurred: $error");
    }
  }

  Future<void> breakShift(int breakshiftId) async {
    EasyLoading.show();
    try {
      final result = await _myRepo.breakShift(breakshiftId);

      log('breakshift Result: $result');
      await fetchTodayShift();
      EasyLoading.dismiss();
      Utils.showSuccess("breakshift Successfully");
      Get.back();
    } catch (error) {
      EasyLoading.dismiss();
      log("Res occurred: $error");
      Utils.showError("An error occurred: $error");
    }
  }
}
