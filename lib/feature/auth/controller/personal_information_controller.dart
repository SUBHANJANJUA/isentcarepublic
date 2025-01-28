import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class PersonalInformationController extends GetxController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController ssnController = TextEditingController();
  final TextEditingController confirmpassController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController stateController = TextEditingController();
  final TextEditingController zipController = TextEditingController();
  final TextEditingController dobController = TextEditingController();

  var obsecure = true.obs;
  var obsecure2 = true.obs;

  var selectedImagePath = ''.obs;
  var fetchedPlaces = <String>[].obs;
  void setAddress(String address) {
    addressController.text = address;
    fetchedPlaces.clear();
  }

  Future<void> pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      selectedImagePath.value = pickedFile.path;
    } else {
      log('Error, No image selected');
    }
  }

  void logFormData() {
    log(fetchedPlaces.toString());

    // log(zipController.text);
    // log(stateController.text);
    // log(cityController.text);
    // log(addressController.text);
    // log(passwordController.text);
    // log(phoneController.text);
    // log(confirmpassController.text);
    // log(emailController.text);
    // log(ssnController.text);
    // log(dobController.text);
    // log(lastNameController.text);
    // log(firstNameController.text);
    //log(selectedImagePath.value);
  }

  Future<List<dynamic>?> fetchPlaces(String input) async {
    log("call  ho rahi ha");
    final String googleApiKey = 'AIzaSyAu1gwHCSzLG9ACacQqLk-LG8oJMkarNF0';
    final Uri url = Uri.parse(
        'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$input&key=$googleApiKey');

    try {
      log("api ko call hoe ha");
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        log("api sy data aya ha");
        final data = json.decode(response.body);
        final predictions = data['predictions'] as List;

        fetchedPlaces.value = predictions
            .map((prediction) => prediction['description'].toString())
            .toList();

        // Update fetchedPlaces with the new data
        // fetchedPlaces.value = descriptions;
      } else {
        log("data nahi aya api sy");
        log("Error in fetching places: ${response.body}");
      }
    } catch (error) {
      log("last error Error: $error");
    }
    return null;
  }

  var isEligible = true.obs;

  void validateDOB() {
    String pickedDate = dobController.text;
    if (pickedDate.isEmpty) {
      isEligible.value = false; // DOB is empty, mark as not eligible
    } else {
      isEligible.value = isAtLeast18YearsOld(pickedDate);
    }
  }

  bool isAtLeast18YearsOld(String pickedDate) {
    try {
      DateTime dob = DateTime.parse(pickedDate);
      DateTime today = DateTime.now();
      int age = today.year - dob.year;
      if (today.month < dob.month ||
          (today.month == dob.month && today.day < dob.day)) {
        age--;
      }
      return age >= 18;
    } catch (e) {
      return false;
    }
  }
}
