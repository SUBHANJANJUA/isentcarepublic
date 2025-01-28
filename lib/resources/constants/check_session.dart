import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:isentcare/feature/isent_care/register/get_started.dart';
import 'package:isentcare/navigation_menu.dart';

const secureStorage = FlutterSecureStorage();

Future<void> checkSession(BuildContext context) async {
  final accessToken = await secureStorage.read(key: 'accessToken');

  if (accessToken != null) {
    Get.offAll(() => const NavigationMenu());
  } else {
    Get.offAll(() => const GetStartedScreen());

  }
}
