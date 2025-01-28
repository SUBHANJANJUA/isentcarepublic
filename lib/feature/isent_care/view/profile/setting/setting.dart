import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:isentcare/resources/constants/color.dart';
import 'package:isentcare/splash_Screen.dart';
import '../../../../../models/auth_Viewmodel.dart';
import '../../../../../navigation_menu.dart';
import '../../../../../widget/container/text_container.dart';
import '../../../../../widget/dialog/confirmation_dialog.dart';
import 'widget/attachmentForm.dart';
import 'widget/education_form.dart';
import 'widget/reference.dart';
import 'widget/work_experience.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  int _selectedIndex = 0; // Tracks the selected menu index

  final List<String> _options = [
    "WORK EXPERIENCE",
    "EDUCATION",
    "ATTACHMENT",
    "APPLICANT REFERENCE CHECK",
  ];
  final AuthViewModel authController = Get.put(AuthViewModel());
  @override
  void initState() {
    authController.fetchUserStatus();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Add Detail"),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 15.0),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () async {
                      if (authController.isVerified.value != true) {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              backgroundColor: Colors.white,
                              title: const Text(
                                "Not Verified",
                                style: TextStyle(
                                    color: AppColors.primary,
                                    fontWeight: FontWeight.w700),
                              ),
                              content: const Text(
                                "You are not verified. Please contact the admin.",
                                style: TextStyle(
                                    color: AppColors.black,
                                    fontWeight: FontWeight.w500),
                              ),
                              actions: [
                                SizedBox(
                                  width: 80,
                                  height: 40,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      Get.back();
                                    },
                                    style: ElevatedButton.styleFrom(
                                      padding: EdgeInsets
                                          .zero, // Removes inner padding
                                    ),
                                    child: const Text("OK"),
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                      } else {
                        Get.offAll(() => const NavigationMenu());
                      }
                    },
                    child: Container(
                      width: 30,
                      height: 30,
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle, color: AppColors.primary),
                      child: const Icon(
                        Icons.home,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                  SizedBox(width: 15),
                  GestureDetector(
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return ConfirmationDialog(
                                onTap: () =>
                                    AuthViewModel().signOut(context: context),
                                dilogdescription:
                                    "Are you sure to logout for this account?",
                              );
                            });
                      },
                      child: Icon(
                        Icons.logout,
                        color: Colors.red,
                      )),
                ],
              ),
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Employment",
                  style: TextStyle(
                    color: AppColors.primary,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    spacing: 10,
                    children: List.generate(
                      _options.length,
                      (index) => TextContainer(
                        onTap: () {
                          setState(() {
                            _selectedIndex = index; // Update selected index
                          });
                        },
                        text: _options[index],
                        textColor: _selectedIndex == index
                            ? Colors.white
                            : AppColors.primary,
                        fontSize: 14,
                        verticalPadding: 10,
                        containerColor: _selectedIndex == index
                            ? AppColors.primary
                            : Colors.white,
                        fontWeight: FontWeight.normal,
                        border: Border.all(
                          color: AppColors.primary,
                          width: 1.5,
                        ), // Add a border for unselected containers
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextContainer(
                      text: _options[_selectedIndex],
                      containerColor: AppColors.primary,
                      textColor: Colors.white,
                      verticalPadding: 10,
                      fontSize: 18,
                      fontWeight: FontWeight.normal,
                      radius: 0,
                      width: double.infinity,
                    ),
                    _buildForm(_selectedIndex),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Method to return different forms based on the selected index
  Widget _buildForm(int index) {
    switch (index) {
      case 0:
        return WorkExperienceForm();
      case 1:
        return EducationForm();
      case 2:
        return AttachmentForm();
      case 3:
        return ReferenceCheckForm();
      default:
        return const Center(child: Text("Select a form"));
    }
  }
}
