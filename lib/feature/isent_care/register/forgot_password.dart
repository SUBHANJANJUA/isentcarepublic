import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:isentcare/feature/auth/view/signin/sign_in.dart';
import 'package:isentcare/resources/constants/app_sizer.dart';
import 'package:isentcare/resources/constants/color.dart';

class ForgotPassword extends StatelessWidget {
  ForgotPassword({super.key});
  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Forget Password'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Forget Password',
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
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                child: const Text('Send Email'),
                onPressed: () async {},
              ),
            ),
            SizedBox(height: context.screenHeight * 0.02),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Already have account?"),
                const SizedBox(width: 5),
                GestureDetector(
                  onTap: () => Get.to(() => SignInScreen()),
                  child: const Text(
                    'Login',
                    style: TextStyle(
                        color: AppColors.primary, fontWeight: FontWeight.w700),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
