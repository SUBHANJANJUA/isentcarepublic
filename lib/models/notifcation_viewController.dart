import 'dart:developer';
import 'package:get/get.dart';
import 'package:isentcare/modals/notification_modal.dart';
import 'package:isentcare/repo/notification_repo.dart';
import 'package:isentcare/resources/utils.dart';

import '../network_data/response/api_response.dart';

class NotifcationViewcontroller extends GetxController {
    final _myRepo = NotificationRepository();

  var notificationsDetails = ApiResponse<NotificationModel>.loading().obs;

  Rx<int> _currentPage = 1.obs;

  var isLoadingMore = false.obs;

  setNotificationDetails(ApiResponse<NotificationModel> response) {
    notificationsDetails.value = response;
  }

  
  Future<void> fetchNotificatons({bool isLoadMore = false}) async {
    if (isLoadingMore.value) return;

    try {
      isLoadingMore.value = true; 

      if (!isLoadMore) {
        _currentPage.value = 1;
        setNotificationDetails(ApiResponse.loading());
      }

      var notifcationData = await _myRepo.getNotifications(_currentPage.value);
      log('Fetched data: ${notifcationData.results.length} results');

      log('Next page URL: ${notifcationData.next}');

      if (isLoadMore) {
        List<Result> currentResults = notificationsDetails.value.data?.results ?? [];

        final updatedResults = [...currentResults, ...notifcationData.results];
        final updatedData = notifcationData.copyWith(results: updatedResults);
        setNotificationDetails(ApiResponse.completed(updatedData));
      } else {
        setNotificationDetails(ApiResponse.completed(notifcationData));
      }
      if (notifcationData.next != null) {
        _currentPage.value++;
        log('Next page URL is available, increasing page to $_currentPage');
      }
    } catch (e) {
      log('Error occurred while fetching data: $e');
      setNotificationDetails(ApiResponse.error(e.toString()));
    } finally {
      isLoadingMore.value = false; 
    }
  }





hanldeError(error, context) {
  log("error $error");
  log("stackTrace $error.stackTrace");

  if (error.toString().contains("Error Occured while ")) {
    Utils.errorSnakbar(context, error.toString());
  } else if (error
      .toString()
      .contains("Error During Communication No Internet Connection")) {
    Utils.errorSnakbar(context, "No Internet Connection");
  } else if (error.toString().contains("Invalid password")) {
    Utils.errorSnakbar(context, "Invalid password");
  } else if (error.toString().contains("User not found")) {
    Utils.errorSnakbar(context, "User not found");
  }
   else {
    log("error $error");
        Utils.showInfo( error);

  }
}
}