import 'dart:developer';
import 'dart:ffi';

import 'package:isentcare/network_data/network/BaseApiServices.dart';
import 'package:isentcare/resources/constants/api_endpoints.dart';

import '../network_data/network/NetworkApiService.dart';

class CalenderRepository {
  final BaseApiServices _apiServices = NetworkApiService();

  Future<dynamic> getCalender() async {
    try {
      const String url = ApiEndPoints.calenderAPI;
      log("Fetching Calender from: $url");
      dynamic response = await _apiServices.getGetApiResponse(url);
      log("Education Response: $response");
      return response;
    } catch (e) {
      log("Error in getEducations: $e");
      rethrow;
    }
  }
}
