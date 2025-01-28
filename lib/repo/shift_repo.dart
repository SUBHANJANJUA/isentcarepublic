import 'dart:developer';

import 'package:isentcare/modals/myshift_modal.dart';
import 'package:isentcare/modals/shift_modal.dart';
import 'package:isentcare/network_data/network/BaseApiServices.dart';
import 'package:isentcare/resources/constants/api_endpoints.dart';

import '../network_data/network/NetworkApiService.dart';

class ShiftRepository {
  final BaseApiServices _apiServices = NetworkApiService();

  Future<ShiftModel> getShifts(int page) async {
    try {
      dynamic response = await _apiServices
          .getGetApiResponse("${ApiEndPoints.shifts}?page=$page");
      log("Api Response: $response");
      return ShiftModel.fromJson(response);
    } catch (e) {
      log("Error in Api: $e");
      rethrow;
    }
  }

  Future<MyShiftModel> getMyShift(int page) async {
    try {
      dynamic response = await _apiServices
          .getGetApiResponse("${ApiEndPoints.applyJob}?page=$page");
      log("Api Response: $response");
      return MyShiftModel.fromJson(response);
    } catch (e) {
      log("Error in Api: $e");
      rethrow;
    }
  }

  Future<void> dropShift(int shiftId) async {
    try {
      final String url = "${ApiEndPoints.drop}$shiftId/cancel_shift/";
      log("Drop Shift API URL: $url");
      await _apiServices.getGetApiResponse(url);
    } catch (e) {
      log("Error in Drop Shift API: $e");
      rethrow;
    }
  }

  Future<dynamic> createShift(dynamic data) async {
    try {
      dynamic response = await _apiServices.postApiResponse(
        ApiEndPoints.startShift,
        data,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
