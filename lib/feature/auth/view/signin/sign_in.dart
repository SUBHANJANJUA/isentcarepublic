import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:isentcare/feature/auth/controller/auth_controller.dart';
import 'package:isentcare/feature/auth/view/signup/job_type.dart';
import 'package:isentcare/feature/isent_care/register/forgot_password.dart';
import 'package:isentcare/models/auth_Viewmodel.dart';
import 'package:isentcare/navigation_menu.dart';
import 'package:isentcare/resources/constants/app_sizer.dart';
import 'package:isentcare/resources/constants/app_strings.dart';
import 'package:isentcare/resources/constants/color.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({super.key});

  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();
  final authController = Get.put(AuthController());

  final GlobalKey<FormState> signinkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Form(
            key: signinkey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "${AppStrings.imagePath}logo.png",
                    width: 250,
                    fit: BoxFit.contain,
                  ),
                  SizedBox(height: context.screenHeight * 0.05),
                  const Text(
                    'Sign In',
                    style: TextStyle(
                        fontSize: 20,
                        color: AppColors.primary,
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: context.screenHeight * 0.02),
                  TextFormField(
                    controller: emailController,
                    decoration: InputDecoration(
                      hintText: 'Email',
                      prefixIcon: Icon(
                        Icons.email,
                        color: Colors.black.withOpacity(0.50),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Enter Email";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: context.screenHeight * 0.02),
                  Obx(() {
                    return TextFormField(
                      controller: passwordController,
                      obscureText: authController.obsecure.value,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please Enter your password';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        hintText: 'Password',
                        prefixIcon: Icon(Icons.lock,
                            color: Colors.black.withOpacity(0.50)),
                        suffixIcon: IconButton(
                          onPressed: () {
                            authController.obsecure.value =
                                !authController.obsecure.value;
                          },
                          icon: authController.obsecure.value
                              ? Icon(Icons.remove_red_eye_outlined,
                                  color: Colors.black.withOpacity(0.50))
                              : Icon(Icons.remove_red_eye,
                                  color: Colors.black.withOpacity(0.50)),
                        ),
                      ),
                    );
                  }),
                  SizedBox(height: context.screenHeight * 0.01),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: InkWell(
                      onTap: () {
                        Get.to(() => ForgotPassword());
                      },
                      child: const Text(
                        'Forgot Password?',
                        style: TextStyle(
                          color: AppColors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: context.screenHeight * 0.05),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      child: const Text('Sign In'),
                      onPressed: () async {
                        if (signinkey.currentState!.validate()) {
                          final loginMap = {
                            "email": emailController.text.trim(),
                            "password": passwordController.text.trim(),
                          };
                          await AuthViewModel().loginApi(loginMap, context);
                        }

                        // Get.to(() => const NavigationMenu());
                        // if (signinkey.currentState!.validate()) {}
                      },
                    ),
                  ),
                  SizedBox(height: context.screenHeight * 0.02),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Dont't have an account?"),
                      const SizedBox(width: 5),
                      GestureDetector(
                          onTap: () => Get.to(() => JobTypeScreen()),
                          child: const Text(
                            'Register',
                            style: TextStyle(
                                color: AppColors.primary,
                                fontWeight: FontWeight.w700),
                          ))
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    ));
  }
}
