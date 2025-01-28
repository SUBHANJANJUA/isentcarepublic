import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:isentcare/modals/permanentjobs_modal.dart';
import 'package:isentcare/navigation_menu.dart';
import 'package:isentcare/network_data/response/status.dart';
import 'package:isentcare/repo/permanentjobs_repo.dart';
import 'package:isentcare/resources/utils.dart';

import '../network_data/response/api_response.dart';

class PermanentJobsController extends GetxController {
  final _myRepo = PermanentJobsRepository();

  // Observable to hold the state of the API response
  var jobsDetails = ApiResponse<PermanentJobsModel>.loading().obs;
  var isJobsLoadingMore = false.obs;

  Rx<int> _currentPage = 1.obs;

  // Setter to update the state
  setJobsDetails(ApiResponse<PermanentJobsModel> response) {
    jobsDetails.value = response;
  }

  // Getter to extract job list from API response
  List<Result> get jobList {
    if (jobsDetails.value.status == Status.COMPLETED) {
      return jobsDetails.value.data?.results ?? []; // Extract 'results' safely
    }
    return [];
  }

  // API call to fetch permanent jobs
  Future<void> fetchPermanentJobs({bool isLoadMore = false}) async {
    if (isJobsLoadingMore.value) return;

    try {
      isJobsLoadingMore.value = true;

      if (!isLoadMore) {
        _currentPage.value = 1;
        setJobsDetails(ApiResponse.loading());
      }
      var jobsData = await _myRepo.getPermanentJobs(_currentPage.value);
      log('Fetched data: ${jobsData.results.length} results');

      log('Next page URL: ${jobsData.next}');
      if (isLoadMore) {
        List<Result> currentResults = jobsDetails.value.data?.results ?? [];

        final updatedResults = [...currentResults, ...jobsData.results];
        final updatedData = jobsData.copyWith(results: updatedResults);
        setJobsDetails(ApiResponse.completed(updatedData));
      } else {
        setJobsDetails(ApiResponse.completed(jobsData));
      } if (jobsData.next != null) {
        _currentPage.value++;
        log('Next page URL is available, increasing page to $_currentPage');
      }
    } catch (e) {
      log(e.toString());
      setJobsDetails(ApiResponse.error(e.toString()));
    }finally{
       isJobsLoadingMore.value = false; 
    }
  }

  Future<void> permanentJob(dynamic data, BuildContext context) async {
    try {
      EasyLoading.show(status: 'Loading...');
      Get.back();

      final response = await _myRepo.createPermanentJob(data);
      EasyLoading.dismiss();
      Get.offAll(() => NavigationMenu());
      Utils.showSuccess("Apply Successfully");
    } catch (error) {
      EasyLoading.dismiss();

      hanldeError(error, context);
      Utils.showError("Something went wrong");
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
    } else {
      log("error $error");
    }
  }
}
