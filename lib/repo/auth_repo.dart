import 'dart:developer';

import 'package:isentcare/modals/profile_modal.dart';
import 'package:isentcare/modals/signup_modal.dart';
import 'package:isentcare/network_data/network/BaseApiServices.dart';
import 'package:isentcare/network_data/network/NetworkApiService.dart';
import 'package:isentcare/resources/constants/api_endpoints.dart';

class AuthRepository {
  final BaseApiServices _apiServices = NetworkApiService();

  // Future getAdminToken() async {
  //   try {
  //     dynamic response = await _apiServices
  //         .getGetApiResponse(ApiEndPoints.getAdminTokenEndPoint);
  //     return response;
  //   } catch (e) {
  //     rethrow;
  //   }
  // }
  Future<dynamic> loginApi(dynamic data) async {
    try {
      dynamic response =
          await _apiServices.getPostApiResponse(ApiEndPoints.loginAPI, data);

      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> signUpApi(SingUpModal data) async {
    try {
      dynamic response =
          await _apiServices.multiPartSignUp(ApiEndPoints.singUp, data);
      return response;
    } catch (e) {
      rethrow;
    }
  }

//   Future<UserModel> userDetailsAPI({required String userId}) async {
//     try {
//       dynamic response = await _apiServices
//           .getPostApiResponse(ApiEndPoints.getMyDataAPI, {"userId": userId});
//       return response = UserModel.fromJson(response);
//     } catch (e) {
//       rethrow;
//     }
//   }

//   Future<dynamic> editProfileAPI({required Map<String, dynamic> data}) async {
//     try {
//       dynamic response =
//           await _apiServices.getPostApiResponse(ApiEndPoints.updateUser, data);

//       return response;
//     } catch (e) {
//       rethrow;
//     }
//   }
  Future<ProfileModel> getProfileDetails() async {
    try {
      dynamic response =
          await _apiServices.getGetApiResponse(ApiEndPoints.profileDetails);
      log("profile Response: $response");

      return ProfileModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }
}
