import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:isentcare/feature/isent_care/register/employ_details.dart';
import 'package:isentcare/feature/isent_care/register/get_started.dart';
import 'package:isentcare/models/auth_Viewmodel.dart';
import 'package:isentcare/navigation_menu.dart';
import 'package:isentcare/resources/constants/app_strings.dart';
import 'package:isentcare/resources/constants/color.dart';

const secureStorage = FlutterSecureStorage();

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  AuthViewModel authcontroller = Get.put(AuthViewModel());
  @override
  void initState() {
    super.initState();
    _initializeApp();
  }
    Future<void> _initializeApp() async {
    await authcontroller.fetchUserStatus(); 
    await Future.delayed(const Duration(seconds: 2));
    await _checkSession();
  }

  

  Future<void> _checkSession() async {
    final accessToken = await secureStorage.read(key: 'accessToken');
    log('Access Token: $accessToken');
    if (accessToken != null) {
      if (authcontroller.isVerified.value) {
        Get.offAll(() => const NavigationMenu());
      } else {
        Get.offAll(() => const EmployDetailsScreen());
      }
    } else {
      Get.offAll(() => const GetStartedScreen());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              '${AppStrings.imagePath}isent-care-logo-white.png',
              width: 200,
              height: 200,
            ),
            const CircularProgressIndicator(
              color: AppColors.primary,
            ),
          ],
        ),
      ),
    );
  }
}
