import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:isentcare/feature/isent_care/controller/profile_controller.dart';
import 'package:isentcare/modals/profile_modal.dart';
import 'package:isentcare/resources/constants/app_sizer.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key, required this.profile});
  final ProfileModel profile;

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final controller = Get.put(ProfileController());

  @override
  void initState() {
    super.initState();
    controller.firstName.text = widget.profile.firstName;
    controller.lastName.text = widget.profile.lastName;
    controller.email.text = widget.profile.email;
    controller.phone.text = widget.profile.phone;
    controller.addressController.text = widget.profile.address.address;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edit Profile')),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: context.screenHeight * 0.05),
              Form(
                key: controller.formKey,
                child: Column(
                  children: [
                    TextFormField(
                      enabled: false,
                      controller: controller.firstName,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                        ),
                        hintText: 'First name',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please Enter your first name';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: context.screenHeight * 0.02),
                    TextFormField(
                      enabled: false,
                      controller: controller.lastName,
                      decoration: const InputDecoration(
                        hintText: 'Last name',
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please Enter your last name';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: context.screenHeight * 0.02),
                    TextFormField(
                      enabled: false,
                      controller: controller.email,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Enter Email";
                        } else if (!RegExp(
                                r"""^[a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+(?:\.[a-zA-Z0-9]+)*\.[a-z][a-z]*$""")
                            .hasMatch(value)) {
                          return "Enter Valid Email";
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        hintText: 'Email',
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                    SizedBox(height: context.screenHeight * 0.02),
                    TextFormField(
                      controller: controller.phone,
                      decoration: const InputDecoration(
                        hintText: "Phone",
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please Enter your Number';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: context.screenHeight * 0.02),
                    TextFormField(
                      onChanged: (value) {
                        controller.fetchPlaces(value.toString());
                        controller.addressController.text.isEmpty
                            ? controller.fetchedPlaces.clear()
                            : null;
                      },
                      controller: controller.addressController,
                      decoration: const InputDecoration(
                        hintText: "Address",
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please Enter your address';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: context.screenHeight * 0.01),
                    Obx(() {
                      if (controller.fetchedPlaces.isEmpty) {
                        return const SizedBox.shrink();
                      }
                      log("this is our ${controller.fetchedPlaces[0].toString()}");
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: controller.fetchedPlaces.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            onTap: () {
                              controller.setAddress(
                                  controller.fetchedPlaces[index].toString());
                            },
                            title: Text(controller.fetchedPlaces[index]),
                          );
                        },
                      );
                    }),
                  ],
                ),
              ),
              SizedBox(height: context.screenHeight * 0.03),
              SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: () {
                        if (controller.formKey.currentState!.validate()) {
                          log("Successfully");
                        }
                      },
                      child: const Text('Save')))
            ],
          ),
        ),
      ),
    );
  }
}
