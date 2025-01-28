import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:isentcare/resources/helper_functions.dart';
import 'package:isentcare/resources/utils.dart';

class JobTypeController extends GetxController {
  final licenceController = TextEditingController();
  final joiningController = TextEditingController();

  // Separate variables for each interest
  var perDiem = false.obs;
  var fixTime = false.obs;
  var travelingAssignment = false.obs;
  var permanentPlacement = false.obs;
  var latitude = 0.0.obs;
  var longitude = 0.0.obs;
  var loading = false.obs;

  void logValue() {
    log("License or Certification: ${licenceController.text}");
    log("Joining Date: ${joiningController.text}");
    log("Per Diem: $perDiem");
    log("Fixed Time Contract: $fixTime");
    log("Traveling Assignment: $travelingAssignment");
    log("Permanent Placement: $permanentPlacement");
  }

  bool isInterestSelected() {
    return perDiem.value ||
        fixTime.value ||
        travelingAssignment.value ||
        permanentPlacement.value;
  }

  Future<void> getLatLong() async {
    try {
      loading.value = true;

      // Get the current location first
      final position = await HelperUtil.getLocation();

      // Store the location in variables
      latitude.value = position.latitude;
      longitude.value = position.longitude;

      log("Current Location: Lat = $latitude, Long = $longitude");

    } catch (e) {
      if (e
          .toString()
          .contains('Location permissions are permanently denied')) {
        Utils.showError(
          "Location permissions are permanently denied. Please enable location permissions from the settings to continue.",
        );
      } else {
        log(e.toString());
        Utils.showError("Could not get location: $e");
      }
    } finally {
      loading.value = false;
    }
  }
}
