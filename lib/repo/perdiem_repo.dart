import 'dart:developer';
import 'package:isentcare/modals/completedshift_modal.dart';
import 'package:isentcare/modals/perdiem_modal.dart';
import 'package:isentcare/network_data/network/BaseApiServices.dart';
import 'package:isentcare/resources/constants/api_endpoints.dart';
import '../network_data/network/NetworkApiService.dart';

class PerdiemRepository {
  final BaseApiServices _apiServices = NetworkApiService();

  Future<PerDiemModel> getPerDiems(String url) async {
    try {
      dynamic response = await _apiServices.getGetApiResponse(url);
      log("Api Response: $response");

      PerDiemModel perdiemsList = PerDiemModel.fromJson(response);

      return perdiemsList;
    } catch (e) {
      log("Error in Api: $e");
      rethrow;
    }
  }

  Future<CompletedShiftModel> getCompletedShift(int page) async {
    try {
      dynamic response =
          await _apiServices.getGetApiResponse("${ApiEndPoints.completed}?page=$page");
      log("Api Response: $response");

      CompletedShiftModel completedList =
          CompletedShiftModel.fromJson(response);

      return completedList;
    } catch (e) {
      log("Error in Api: $e");
      rethrow;
    }
  }

  Future<dynamic> createJob(dynamic data) async {
    try {
      dynamic response = await _apiServices.postApiResponse(
        ApiEndPoints.applyJob,
        data,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
