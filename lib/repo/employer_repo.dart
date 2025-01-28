import 'dart:developer';
import 'dart:ffi';

import 'package:isentcare/network_data/network/BaseApiServices.dart';
import 'package:isentcare/resources/constants/api_endpoints.dart';

import '../network_data/network/NetworkApiService.dart';

class EmployerRepository {
  final BaseApiServices _apiServices = NetworkApiService();

  Future<dynamic> getEmployers() async {
    try {
      const String url = ApiEndPoints.employers;
      log("Api url: $url");
      dynamic response = await _apiServices.getGetApiResponse(url);
      log("Api Response: $response");
      return response;
    } catch (e) {
      log("Error in Api: $e");
      rethrow;
    }
  }

  Future<dynamic> addEmploye(dynamic data) async {
    try {
      dynamic response =
          await _apiServices.postApiResponse(ApiEndPoints.employers, data);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> deleteEmployee(int employerId) async {
    try {
      dynamic response = await _apiServices
          .deleteApiResponse('${ApiEndPoints.employers}$employerId/');
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> updateEmployers(dynamic data, int employerId) async {
    try {
      dynamic response = await _apiServices.patchApiResponse(
        '${ApiEndPoints.employers}$employerId/',
        data,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
