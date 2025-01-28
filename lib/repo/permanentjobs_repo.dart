import 'dart:developer';
import 'package:isentcare/modals/permanentjobs_modal.dart';
import 'package:isentcare/network_data/network/BaseApiServices.dart';
import 'package:isentcare/resources/constants/api_endpoints.dart';
import '../network_data/network/NetworkApiService.dart';

class PermanentJobsRepository {
  final BaseApiServices _apiServices = NetworkApiService();

  Future<PermanentJobsModel> getPermanentJobs(int page) async {
    try {
      dynamic response = await _apiServices
          .getGetApiResponse("${ApiEndPoints.permanentJobs}?page=$page");
      log("Api Response: $response");

      PermanentJobsModel jobsList = PermanentJobsModel.fromJson(response);

      return jobsList;
    } catch (e) {
      log("Error in Api: $e");
      rethrow;
    }
  }

  Future<dynamic> createPermanentJob(dynamic data) async {
    try {
      dynamic response = await _apiServices.postApiResponse(
        ApiEndPoints.applyPermanentJob,
        data,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
