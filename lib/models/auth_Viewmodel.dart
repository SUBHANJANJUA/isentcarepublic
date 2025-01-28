import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:isentcare/feature/auth/view/signin/sign_in.dart';
import 'package:isentcare/feature/isent_care/register/employ_details.dart';
import 'package:isentcare/modals/profile_modal.dart';
import 'package:isentcare/navigation_menu.dart';
import 'package:isentcare/network_data/response/api_response.dart';
import 'package:isentcare/repo/auth_repo.dart';
import 'package:isentcare/resources/utils.dart';
import 'package:isentcare/splash_Screen.dart';

const secureStorage = FlutterSecureStorage();

class AuthViewModel extends GetxController {
  final _myRepo = AuthRepository();
  var profileDetails = ApiResponse<ProfileModel>.loading().obs;
  RxBool isVerified = false.obs;
  setProfileDetails(ApiResponse<ProfileModel> response) {
    profileDetails.value = response;
  }

  Future<void> signOut({required BuildContext context}) async {
    await secureStorage.deleteAll();
    Get.offAll(() => SignInScreen());
  }

  Future<void> loginApi(dynamic data, BuildContext context) async {
    log('API Request Data: $data');
    EasyLoading.show();

    try {
      final loginResponse = await _myRepo.loginApi(data);
      log("Login Response: $loginResponse");

      if (loginResponse["access"] != null && loginResponse["user"] != null) {
        EasyLoading.dismiss();
        Utils.showSuccess("Login Successful");
        // Save user session securely
        await secureStorage.write(
            key: 'accessToken', value: loginResponse["access"]);

        Get.offAll(() => const NavigationMenu());
      } else {
        EasyLoading.dismiss();
        log('Login error occurred');
      }
    } catch (error, stackTrace) {
      log("Error occurred: $error");
      log("Stack Trace: $stackTrace");
      hanldeError(error, context);
    }
  }

  Future<void> multiPartSignUp({
    required dynamic data,
    required BuildContext context,
  }) async {
    EasyLoading.show();
    try {
      final signUpResponse = await _myRepo.signUpApi(data);
      log("SignUp Response: $signUpResponse");
      if (signUpResponse != null && signUpResponse['access'] != null) {
        await secureStorage.write(
            key: 'accessToken', value: signUpResponse["access"]);

        EasyLoading.dismiss();
        Utils.showInfo("User Created Successfully");

        Get.offAll(() => const SplashScreen());
      } else {
        EasyLoading.dismiss();
        log('Signup error: Token missing in response');
      }
    } catch (error) {
      EasyLoading.dismiss();

      hanldeError(error, context);
    }
  }

  Future<void> fetchUserStatus() async {
    try {
      final userDetails = await _myRepo.getProfileDetails();
      isVerified.value = userDetails.verified ?? false;
      log('Fetched user status: ${isVerified.value}');
    } catch (error) {
      log('Error fetching user status: $error');
    }
  }

  Future<void> fetchProfileDetails() async {
    // Set the loading state
    setProfileDetails(ApiResponse.loading());

    try {
      // Fetch the profile details from the repository
      var profileDetails = await _myRepo.getProfileDetails();
      log("Profile Details: $profileDetails");

      if (profileDetails != null) {
        // Convert the response to a ProfileModel instance

        // Set the completed state with the fetched data
        setProfileDetails(ApiResponse.completed(profileDetails));

        // Display success message
        log("Fetched profile details successfully");
      } else {
        // Handle null response case
        setProfileDetails(ApiResponse.error(profileDetails.toString()));
        log('Error: Failed to fetch profile details');
        Utils.showError("Unable to fetch profile details.");
      }
    } catch (error) {
      // Log the error and set the error state
      log("Error occurred while fetching profile details: $error");
      setProfileDetails(ApiResponse.error(error.toString()));
    }
  }

  // Future<void> editProfileApi(
  //   dynamic data,
  //   BuildContext context,
  //   String userId,
  // ) async {
  //   EasyLoading.show();
  //   try {
  //     final editProfile = await _myRepo.editProfileAPI(data: data);
  //     if (editProfile["error"] == false) {
  //       EasyLoading.dismiss();
  //       // NavigationUtil.navigatePush(
  //       //     context: context, destinationScreen: const SuccessfulSignUp());
  //     }

  //     if (editProfile["error"] == true) {
  //       EasyLoading.dismiss();

  //       Utils.showError("Something went wrong");
  //     }
  //   } catch (error) {
  //     hanldeError(error, context);
  //   }
  // }

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
    } else if (error.toString().contains("No user matching the credentials")) {
      Utils.errorSnakbar(context, "Invalid password or email");
    } else if (error.toString().contains("You are not verified by admin")) {
      Utils.errorSnakbar(
          context, " You are not verified by admin. Please contact to admin.");
    } else if (error
        .toString()
        .contains("user with this Email already exists")) {
      Utils.errorSnakbar(context,
          "user with this Email already exists.Please try with different email.");
    } else {
      Utils.errorSnakbar(context, error.toString());
    }
  }
}
