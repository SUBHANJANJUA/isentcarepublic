import 'dart:developer';

import 'package:isentcare/network_data/network/BaseApiServices.dart';
import 'package:isentcare/resources/constants/api_endpoints.dart';

import '../network_data/network/NetworkApiService.dart';

class DropDownRepository {
  final BaseApiServices _apiServices = NetworkApiService();

  Future<dynamic> getStates() async {
    try {
      const String url = ApiEndPoints.states;
      log("Api of get state url: $url");
      dynamic response = await _apiServices.getGetApiSimple(url);

      return response;
    } catch (e) {
      log("Error in Api: $e");
      rethrow;
    }
  }

  Future<dynamic> getProfessions() async {
    try {
      const String url = ApiEndPoints.professions;

      dynamic response = await _apiServices.getGetApiSimple(url);

      return response;
    } catch (e) {
      log("Error in Api: $e");
      rethrow;
    }
  }

  Future<dynamic> getCountry() async {
    try {
      const String url = ApiEndPoints.countries;

      dynamic response = await _apiServices.getGetApiSimple(url);

      return response;
    } catch (e) {
      log("Error in Api: $e");
      rethrow;
    }
  }

  Future<dynamic> getIdEmpList() async {
    try {
      const String url = ApiEndPoints.idEmpApi;
      log("Call go to api rapo");

      dynamic response = await _apiServices.getGetApiResponse(url);

      return response;
    } catch (e) {
      log("Error in Api: $e");
      rethrow;
    }
  }

  Future<dynamic> getEmpAuthList() async {
    try {
      const String url = ApiEndPoints.empAuthApi;

      dynamic response = await _apiServices.getGetApiResponse(url);

      return response;
    } catch (e) {
      log("Error in Api: $e");
      rethrow;
    }
  }

  Future<dynamic> getIdDocList() async {
    try {
      const String url = ApiEndPoints.idDocApi;

      dynamic response = await _apiServices.getGetApiResponse(url);

      return response;
    } catch (e) {
      log("Error in Api: $e");
      rethrow;
    }
  }
}
