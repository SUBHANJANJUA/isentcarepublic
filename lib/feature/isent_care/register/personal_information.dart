import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:isentcare/feature/auth/controller/jobtype_controller.dart';
import 'package:isentcare/feature/auth/controller/personal_information_controller.dart';
import 'package:isentcare/modals/signup_modal.dart';
import 'package:isentcare/models/auth_Viewmodel.dart';
import 'package:isentcare/resources/capitalize_first_letter_formatter.dart';
import 'package:isentcare/resources/constants/app_sizer.dart';
import 'package:isentcare/resources/constants/color.dart';
import 'package:isentcare/widgets/datepicker_field.dart';

import 'package:isentcare/widgets/text_field.dart';

import '../../auth/controller/dropdown_controller.dart';

class PersonalInformation extends StatefulWidget {
  PersonalInformation({super.key});

  @override
  State<PersonalInformation> createState() => _PersonalInformationState();
}

class _PersonalInformationState extends State<PersonalInformation> {
  final DropdownController dropdownController = Get.put(DropdownController());

  final AuthViewModel authcontroller = Get.put(AuthViewModel());

  final JobTypeController jobTypeController = Get.put(JobTypeController());

  final PersonalInformationController controller =
      Get.put(PersonalInformationController());

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    dropdownController.fetchStates();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Personal Information'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: context.screenHeight * 0.01),
                Center(
                  child: Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      Obx(() {
                        return CircleAvatar(
                          radius: 60,
                          backgroundColor: Colors.grey.shade100,
                          backgroundImage:
                              controller.selectedImagePath.value.isEmpty
                                  ? null
                                  : FileImage(
                                      File(controller.selectedImagePath.value)),
                          child: controller.selectedImagePath.value.isEmpty
                              ? const Icon(Icons.person,
                                  color: Colors.black, size: 60)
                              : null,
                        );
                      }),
                      GestureDetector(
                        onTap: () => controller.pickImage(),
                        child: Container(
                          width: 40,
                          height: 40,
                          // ignore: prefer_const_constructors
                          decoration: BoxDecoration(
                            color: Colors.black,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.camera_alt_outlined,
                            color: Colors.white,
                            // size: 35,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: context.screenHeight * 0.025),
                CustomTextField(
                    inputFormatters: [CapitalizeFirstLetterFormatter()],
                    hasdropDownButton: false,
                    text: 'First Name:',
                    hintText: 'First Name',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'First Name is required';
                      }
                      return null;
                    },
                    controller: controller.firstNameController),
                SizedBox(height: context.screenHeight * 0.01),
                CustomTextField(
                    inputFormatters: [CapitalizeFirstLetterFormatter()],
                    hasdropDownButton: false,
                    text: 'Last Name:',
                    hintText: 'Last Name',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Last Name is required';
                      }
                      return null;
                    },
                    controller: controller.lastNameController),
                SizedBox(height: context.screenHeight * 0.01),
                DatePickerField(
                  text: 'DOB:',
                  controller: controller.dobController,
                  validationMessage: 'Date of Birth is required',
                ),
                SizedBox(height: context.screenHeight * 0.005),
                Obx(() {
                  return controller.isEligible.value
                      ? const SizedBox.shrink()
                      : const Text(
                          "Must be at least 18 years old",
                          style: TextStyle(color: AppColors.error),
                        );
                }),
                SizedBox(height: context.screenHeight * 0.01),
                CustomTextField(
                    inputFormatters: [CapitalizeFirstLetterFormatter()],
                    hasdropDownButton: false,
                    text: 'SSN:',
                    hintText: 'SSN',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'SSN is required';
                      }
                      return null;
                    },
                    controller: controller.ssnController),
                SizedBox(height: context.screenHeight * 0.01),
                CustomTextField(
                  hasdropDownButton: false,
                  text: 'Email:',
                  hintText: 'Email',
                  controller: controller.emailController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Email is required';
                    } else if (!RegExp(
                            r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
                        .hasMatch(value)) {
                      return 'Enter a valid email address';
                    }
                    return null;
                  },
                ),
                SizedBox(height: context.screenHeight * 0.01),
                const Text(
                  " Phone no",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
                ),
                SizedBox(height: context.screenHeight * 0.005),
                TextFormField(
                  controller: controller.phoneController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Phone number is required';
                    }

                    return null;
                  },
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(10),
                  ],
                  decoration: const InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.only(left: 10.0),
                    hintText: 'Phone no',
                  ),
                ),
                SizedBox(height: context.screenHeight * 0.01),
                const Text(
                  " Password",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
                ),
                SizedBox(height: context.screenHeight * 0.005),
                Obx(() {
                  return TextFormField(
                    controller: controller.passwordController,
                    obscureText: controller.obsecure.value,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please Enter your password';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      border: const OutlineInputBorder(),
                      contentPadding: const EdgeInsets.only(left: 10.0),
                      hintText: 'Password',
                      suffixIcon: IconButton(
                        onPressed: () {
                          controller.obsecure.value =
                              !controller.obsecure.value;
                        },
                        icon: controller.obsecure.value
                            ? Icon(Icons.remove_red_eye_outlined,
                                color: Colors.black.withOpacity(0.50))
                            : Icon(Icons.remove_red_eye,
                                color: Colors.black.withOpacity(0.50)),
                      ),
                    ),
                  );
                }),
                SizedBox(height: context.screenHeight * 0.01),
                const Text(
                  "Confirm Password:",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
                ),
                SizedBox(height: context.screenHeight * 0.005),
                Obx(() {
                  return TextFormField(
                    controller: controller.confirmpassController,
                    obscureText: controller.obsecure2.value,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Confirm Password is required';
                      }
                      if (controller.passwordController.text != value) {
                        return 'Passwords do not match';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      border: const OutlineInputBorder(),
                      contentPadding: const EdgeInsets.only(left: 10.0),
                      hintText: 'Confirm Password',
                      suffixIcon: IconButton(
                        onPressed: () {
                          controller.obsecure2.value =
                              !controller.obsecure2.value;
                        },
                        icon: controller.obsecure2.value
                            ? Icon(Icons.remove_red_eye_outlined,
                                color: Colors.black.withOpacity(0.50))
                            : Icon(Icons.remove_red_eye,
                                color: Colors.black.withOpacity(0.50)),
                      ),
                    ),
                  );
                }),
                SizedBox(height: context.screenHeight * 0.01),
                CustomTextField(
                    onChanged: (value) {
                      controller.fetchPlaces(value.toString());
                      controller.addressController.text.isEmpty
                          ? controller.fetchedPlaces.clear()
                          : null;
                    },
                    hasdropDownButton: false,
                    text: 'Address:',
                    hintText: 'Address',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Address is required';
                      }
                      return null;
                    },
                    controller: controller.addressController),
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
                SizedBox(height: context.screenHeight * 0.01),
                CustomTextField(
                    inputFormatters: [CapitalizeFirstLetterFormatter()],
                    hasdropDownButton: false,
                    text: 'City:',
                    hintText: 'City',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'City is required';
                      }
                      return null;
                    },
                    controller: controller.cityController),
                SizedBox(height: context.screenHeight * 0.01),
                Obx(() {
                  return CustomTextField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'State is required';
                      }
                      return null;
                    },
                    onPressed: () {
                      dropdownController.fetchStates();
                    },
                    hasdropDownButton: true,
                    text: 'State:',
                    hintText: "Select State",
                    controller: controller.stateController,
                    dropdownItems: dropdownController.states
                        .map((state) => state.name)
                        .toList(),
                  );
                }),
                SizedBox(height: context.screenHeight * 0.01),
                CustomTextField(
                    hasdropDownButton: false,
                    text: 'Zip Code:',
                    hintText: 'Zip Code',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'ZIp Code is required';
                      }
                      return null;
                    },
                    controller: controller.zipController),
                SizedBox(height: context.screenHeight * 0.02),
                Center(
                  child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                          onPressed: () async {
                            controller.logFormData();
                            controller.validateDOB();

                            final LicenceStateIndex =
                                dropdownController.states.indexWhere(
                              (state) =>
                                  state.name == controller.stateController.text,
                            );

                            if (controller.isEligible.value) {
                              if (_formKey.currentState?.validate() ?? false) {
                                // log(controller.firstNameController.text);
                                // log(controller.lastNameController.text);
                                // log(controller.dobController.text);
                                // log(controller.ssnController.text);
                                // log(controller.emailController.text);
                                // log(controller.phoneController.text);
                                // log(controller.passwordController.text);
                                // log(controller.addressController.text);
                                // log(controller.cityController.text);
                                // log(controller.stateController.text);
                                // log("Selected State Index: ${LicenceStateIndex}");
                                // log(controller.zipController.text);
                                // log(jobTypeController.latitude.value
                                //     .toString());
                                // log(jobTypeController.longitude.value
                                //     .toString());

                                SingUpModal userData = SingUpModal(
                                  firstName:
                                      controller.firstNameController.text,
                                  lastName: controller.lastNameController.text,
                                  email: controller.emailController.text,
                                  phone: controller.phoneController.text,
                                  password: controller.passwordController.text,
                                  confirmPassword:
                                      controller.confirmpassController.text,
                                  dob: controller.dobController.text,
                                  ssn: controller.ssnController.text,
                                  address: controller.addressController.text,
                                  city: controller.cityController.text,
                                  state: LicenceStateIndex,
                                  zipCode: controller.zipController.text,
                                  title:
                                      jobTypeController.licenceController.text,
                                  perdiem: jobTypeController.perDiem.value,
                                  fixTime: jobTypeController.fixTime.value,
                                  perPlace: jobTypeController
                                      .permanentPlacement.value,
                                  traAssign: jobTypeController
                                      .travelingAssignment.value,
                                  latitude: jobTypeController.latitude.value
                                      .toDouble(),
                                  longitude: jobTypeController.longitude.value
                                      .toDouble(),
                                  type: 'P',
                                  joiningDate: DateTime.now(),
                                  dp: controller
                                          .selectedImagePath.value.isNotEmpty
                                      ? File(controller.selectedImagePath.value)
                                      : null,
                                );
                                log(userData.dp.toString());
                                authcontroller.multiPartSignUp(
                                    data: userData, context: context);
                                // Get.to(EmployDetailsScreen());
                                // controller.logFormData();
                              } else {
                                log("Please fill all the field");
                              }
                            }
                          },
                          child: const Text('Save and Continue'))),
                ),
                SizedBox(height: context.screenHeight * 0.02),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
