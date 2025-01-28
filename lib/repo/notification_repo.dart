import 'dart:developer';
import 'package:isentcare/modals/notification_modal.dart';
import 'package:isentcare/network_data/network/BaseApiServices.dart';
import 'package:isentcare/resources/constants/api_endpoints.dart';
import '../network_data/network/NetworkApiService.dart';

class NotificationRepository {
  final BaseApiServices _apiServices = NetworkApiService();

  Future<NotificationModel> getNotifications(int page) async {
    try {
      dynamic response = await _apiServices
          .getGetApiResponse("${ApiEndPoints.notification}?page=$page");
      log("Api Response: $response");

      NotificationModel notificationList = NotificationModel.fromJson(response);

      return notificationList;
    } catch (e) {
      log("Error in Api: $e");
      rethrow;
    }
  }
}
