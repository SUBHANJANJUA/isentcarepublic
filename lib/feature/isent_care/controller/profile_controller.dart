import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ProfileController extends GetxController {
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController addressController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  var fetchedPlaces = <String>[].obs;
  void setAddress(String address) {
    addressController.text = address;
    fetchedPlaces.clear();
  }

  Future<List<dynamic>?> fetchPlaces(String input) async {
    final String googleApiKey = 'AIzaSyAu1gwHCSzLG9ACacQqLk-LG8oJMkarNF0';
    final Uri url = Uri.parse(
        'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$input&key=$googleApiKey');

    try {
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final predictions = data['predictions'] as List;

        fetchedPlaces.value = predictions
            .map((prediction) => prediction['description'].toString())
            .toList();
      } else {
        log("Error in fetching places: ${response.body}");
      }
    } catch (error) {
      log("last error Error: $error");
    }
    return null;
  }

  /// Shift screen variables
  final miles = 0.0.obs;
  RxInt tabIndex = 0.obs;
  void completeTab() {
    tabIndex.value = 1;
  }

  void perDiemTab() {
    tabIndex.value = 0;
  }

  void printvalue() {
    log(tabIndex.value.toString());
  }

  
}
