import 'dart:convert';
import 'dart:developer';

import 'package:isentcare/modals/todayshift_modal.dart';
import 'package:isentcare/network_data/network/BaseApiServices.dart';
import 'package:isentcare/network_data/network/NetworkApiService.dart';
import 'package:isentcare/resources/constants/api_endpoints.dart';

class TodayShiftRepository {
  final BaseApiServices _apiServices = NetworkApiService();

  Future<TodayShiftModel> getTodayShifts() async {
    try {
      const String url = ApiEndPoints.todayShift;
      log("Api url: $url");
      dynamic response = await _apiServices.getGetApiResponse(url);
      log("Api Response: $response");
      return TodayShiftModel.fromJson(response);
    } catch (e) {
      log("Error in Api: $e");
      rethrow;
    }
  }

  Future<dynamic> punchOut(int punchoutId) async {
  try {
    final String url = '${ApiEndPoints.punchout}$punchoutId/punch_out/';
    log("PunchOut URL: $url");

    // Call the API
    final response = await _apiServices.patchApi(url);

    // Log and handle response
    log('PunchOut Response: $response');
    if (response.isNotEmpty) {
      return response; // Return response if not empty
    }
    return 'Success'; // Default success value for empty body
  } catch (e) {
    log('Error in punchOut: $e');
    rethrow;
  }
}
 Future<dynamic> breakShift(int breakId) async {
  try {
    final String url = '${ApiEndPoints.punchout}$breakId/no_break/';
    log("BreakShift URL: $url");

    // Call the API
    final response = await _apiServices.patchApi(url);

    // Log and handle response
    log('BreakShift Response: $response');
    if (response.isNotEmpty) {
      return response; // Return response if not empty
    }
    return 'Success'; // Default success value for empty body
  } catch (e) {
    log('Error in BreakShift: $e');
    rethrow;
  }
}



}
