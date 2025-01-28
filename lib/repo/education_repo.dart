import 'dart:developer';
import 'dart:ffi';

import 'package:isentcare/network_data/network/BaseApiServices.dart';
import 'package:isentcare/resources/constants/api_endpoints.dart';

import '../network_data/network/NetworkApiService.dart';

class EducationRepository {
  final BaseApiServices _apiServices = NetworkApiService();

  // Future<dynamic> createProject(dynamic data) async {
  //   try {
  //     dynamic response =
  //         await _apiServices.postApiResponse(ApiEndPoints.createProject, data);
  //     return response;
  //   } catch (e) {
  //     rethrow;
  //   }
  // }

  Future<dynamic> updateEducation(dynamic data, int educationId) async {
    try {
      dynamic response = await _apiServices.patchApiResponse(
        '${ApiEndPoints.educations}$educationId/',
        data,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> deleteEducation(int educationId) async {
    try {
      const String url = ApiEndPoints.educations;
      log("Fetching Educations from: $url");
      dynamic response = await _apiServices.deleteApiResponse(
        '${ApiEndPoints.educations}$educationId/',
      );
      log("Education Response: $response");
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> getEducations() async {
    try {
      const String url = ApiEndPoints.educations;
      log("Fetching Educations from: $url");
      dynamic response = await _apiServices.getGetApiResponse(url);
      log("Education Response: $response");
      return response;
    } catch (e) {
      log("Error in getEducations: $e");
      rethrow;
    }
  }
   Future<dynamic> addEducation(dynamic data) async {
    try {
      dynamic response =
          await _apiServices.postApiResponse(ApiEndPoints.educations, data);
      return response;
    } catch (e) {
      rethrow;
    }
  }
     Future<dynamic> addReference(dynamic data) async {
    try {
      dynamic response =
          await _apiServices.postApiResponse(ApiEndPoints.reference, data);
      return response;
    } catch (e) {
      rethrow;
    }
  }


  Future<dynamic> getCountries() async {
    try {
      const String url = ApiEndPoints.countries;
      log("Fetching Countries from: $url");
      dynamic response = await _apiServices.getGetApiSimple(url);
      log("Countries Response: $response");
      return response;
    } catch (e) {
      log("Error in getCountries: $e");
      rethrow;
    }
  }
}
