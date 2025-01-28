
import 'dart:developer';

import 'package:isentcare/modals/license_modal.dart';
import 'package:isentcare/network_data/network/BaseApiServices.dart';
import 'package:isentcare/resources/constants/api_endpoints.dart';

import '../network_data/network/NetworkApiService.dart';

class LicenseRepository {
  final BaseApiServices _apiServices = NetworkApiService();

  Future<List<LicenseModel>> getLicenses() async {
    try {
      const String url = ApiEndPoints.licenses;
      log("Api url: $url");
      dynamic response = await _apiServices.getGetApiResponse(url);
      log("Api Response: $response");
     return LicenseModel.fromJsonList(response);
    } catch (e) {
      log("Error in Api: $e");
      rethrow;
    }
  }
  Future<dynamic> addLicense(dynamic data) async {
    try {
      dynamic response =
          await _apiServices.multiPartLicenseCreate(ApiEndPoints.licenses, data);
      return response;
    } catch (e) {
      rethrow;
    }
  }
  Future<dynamic> updateLicense(dynamic data, int licenseId) async {
    try {
      dynamic response = await _apiServices.patchApiResponse(
        '${ApiEndPoints.licenses}$licenseId/',
        data,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }


}
