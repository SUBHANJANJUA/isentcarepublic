import 'dart:developer';


import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:isentcare/resources/utils.dart';


class HandleError {
    static handleError(dynamic error) {
    EasyLoading.dismiss();
    if (error.toString().contains("No Internet Connection")) {
           Utils.errorSnakbar(Get.context!, "No Internet Connection");

    } else if(error.toString().contains("user with this Email already exists")){
      Utils.errorSnakbar(Get.context!, "user with this Email already exists");
    }
    else {
      log(error.toString());
      Utils.errorSnakbar(Get.context!, error.toString());
    }
  }
}