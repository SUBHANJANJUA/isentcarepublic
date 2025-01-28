import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:isentcare/modals/completedshift_modal.dart';
import 'package:isentcare/modals/perdiem_modal.dart';
import 'package:isentcare/navigation_menu.dart';
import 'package:isentcare/repo/perdiem_repo.dart';
import 'package:isentcare/resources/constants/api_endpoints.dart';
import 'package:isentcare/resources/utils.dart';

import '../network_data/response/api_response.dart';

class PerdiemController extends GetxController {
  final _myRepo = PerdiemRepository();
  var perdiemDetails = ApiResponse<PerDiemModel>.loading().obs;
  var completedDetails = ApiResponse<CompletedShiftModel>.loading().obs;

  Rx<int> _currentPage = 1.obs;
    Rx<int> _page = 1.obs;

  var isLoadingMore = false.obs;
  var isCompletedLoadingMore = false.obs;

  setPerdiemDetails(ApiResponse<PerDiemModel> response) {
    perdiemDetails.value = response;
  }

  setCompletedDetails(ApiResponse<CompletedShiftModel> response) {
    completedDetails.value = response;
  }

  Future<void> fetchperdiem({bool isLoadMore = false, double? range}) async {
    if (isLoadingMore.value) return;

    try {
      isLoadingMore.value = true; // Set loading to true at start

      if (!isLoadMore) {
        _currentPage.value = 1;
        setPerdiemDetails(ApiResponse.loading());
      }
          final apiUrl = range != null
        ? "${ApiEndPoints.perdiem}?page=${_currentPage.value}&range=$range"
        : "${ApiEndPoints.perdiem}?page=${_currentPage.value}";

      var perdiemData = await _myRepo.getPerDiems(apiUrl);
      log('Fetched data: ${perdiemData.results.length} results');
      log('Fetching data for range: $range');


      log('Next page URL: ${perdiemData.next}');

      if (isLoadMore) {
        List<Result> currentResults = perdiemDetails.value.data?.results ?? [];

        final updatedResults = [...currentResults, ...perdiemData.results];
        final updatedData = perdiemData.copyWith(results: updatedResults);
        setPerdiemDetails(ApiResponse.completed(updatedData));
      } else {
        setPerdiemDetails(ApiResponse.completed(perdiemData));
      }
      if (perdiemData.next != null) {
        _currentPage.value++;
        log('Next page URL is available, increasing page to $_currentPage');
      }
    } catch (e) {
      log('Error occurred while fetching data: $e');
      setPerdiemDetails(ApiResponse.error(e.toString()));
    } finally {
      isLoadingMore.value = false; // Always set loading to false when done
    }
  }

  Future<void> fetchCompleted({bool isLoadMore = false}) async {
    if (isCompletedLoadingMore.value) return;

    try {

      if (!isLoadMore) {
        _page.value = 1;
        setCompletedDetails(ApiResponse.loading());
      }
      var jobsData = await _myRepo.getCompletedShift(_page.value);
      log('Fetched data: ${jobsData.results.length} results');

      log('Next page URL: ${jobsData.next}');
      if (isLoadMore) {
        List<CompleteResult> currentResults =
            completedDetails.value.data?.results ?? [];
        final updatedResults = [...currentResults, ...jobsData.results];
        final updatedData = jobsData.copyWith(results: updatedResults);
        setCompletedDetails(ApiResponse.completed(updatedData));
      } else {
        setCompletedDetails(ApiResponse.completed(jobsData));
      }
      if (jobsData.next != null) {
        _page.value++;
        log('Next page completed URL is available, increasing page to $_page');
      }
    } catch (e) {
      log(e.toString());
      setCompletedDetails(ApiResponse.error(e.toString()));
    } finally {
      isCompletedLoadingMore.value = false;
    }
  }

  Future<void> createJob(dynamic data, BuildContext context) async {
    try {
      EasyLoading.show(status: 'Loading...');
      Get.back();

      final response = await _myRepo.createJob(data);
      EasyLoading.dismiss();
      Get.offAll(() => NavigationMenu());
      Utils.showSuccess("Apply Successfully");
    } catch (error) {
      EasyLoading.dismiss();

      hanldeError(error, context);
      // Utils.showError("Something went wrong");
    }
  }
}

hanldeError(error, context) {
  EasyLoading.dismiss();
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
