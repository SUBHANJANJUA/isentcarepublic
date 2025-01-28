import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:isentcare/feature/auth/controller/employee_detail_controller.dart';
import 'package:isentcare/feature/isent_care/view/profile/setting/setting.dart';
import 'package:isentcare/models/auth_Viewmodel.dart';
import 'package:isentcare/models/license_viewController.dart';
import 'package:isentcare/navigation_menu.dart';

import 'package:isentcare/resources/constants/app_sizer.dart';
import 'package:isentcare/resources/constants/color.dart';
import 'package:isentcare/splash_Screen.dart';
import 'package:isentcare/widgets/datepicker_field.dart';
import 'package:isentcare/widgets/text_field.dart';
import '../../../widget/dialog/confirmation_dialog.dart';
import '../../../widgets/MultiSelectionDropDwonField.dart';
import '../../../widgets/dropdownField.dart';
import '../../auth/controller/dropdown_controller.dart';

class EmployDetailsScreen extends StatefulWidget {
  const EmployDetailsScreen({super.key});

  @override
  State<EmployDetailsScreen> createState() => _EmployDetailsScreenState();
}

class _EmployDetailsScreenState extends State<EmployDetailsScreen> {
  var isMultiState = false.obs;

  final DropdownController dropdownController = Get.put(DropdownController());

  final _formKey = GlobalKey<FormState>();

  final EmployeeDetailController controller =
      Get.put(EmployeeDetailController());

  final LicenseController licenseController = Get.put(LicenseController());

  final AuthViewModel authController = Get.put(AuthViewModel());

  List<int> selectedIndices = [];
  @override
  void initState() {
    authController.fetchUserStatus();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    dropdownController.fetchProfessions();
    return Scaffold(
      appBar: AppBar(
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
                const SizedBox(width: 15),
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
                    child: const Icon(
                      Icons.logout,
                      color: Colors.red,
                    )),
              ],
            ),
          )
        ],
        automaticallyImplyLeading: false,
        title: const Text('EmployDetails'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Obx(() {
                  return Dropdownfield(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Professional License is required';
                      }
                      return null;
                    },
                    onPressed: () {
                      dropdownController.fetchProfessions();
                    },
                    text: 'Professional License',
                    hintText: "Select Professional",
                    hasdropDownButton: true,
                    controller: controller.licenseController,
                    dropdownItems: dropdownController.professions
                        .map((professions) => professions.name)
                        .toList(),
                    dropdownItemsId: dropdownController.professions
                        .map((professions) => professions.id)
                        .toList(),
                  );
                }),
                SizedBox(height: context.screenHeight * 0.01),
                CustomTextField(
                  hasdropDownButton: false,
                  text: 'License Number:',
                  hintText: 'Number',
                  controller: controller.licensenumberController,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'License number is required';
                    }
                    return null;
                  },
                ),
                SizedBox(height: context.screenHeight * 0.01),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Text('Single State',
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w700)),
                    Obx(() => Switch(
                          activeColor: AppColors.primary,
                          value: isMultiState.value,
                          onChanged: (value) {
                            isMultiState.value = value;
                          },
                        )),
                    const Text('Multi State',
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w700)),
                  ],
                ),
                SizedBox(height: context.screenHeight * 0.01),
                Obx(() {
                  return isMultiState.value
                      ? MultiSelectionDropdownField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'License State is required';
                            }
                            return null;
                          },
                          text: 'License State',
                          hintText: "Select State",
                          hasdropDownButton: true,
                          controller: controller.licensestateController,
                          dropdownItems: dropdownController.states
                              .map((state) => state.name)
                              .toList(),
                          onChanged: (selectedItems) {
                            selectedIndices = selectedItems.map((selectedItem) {
                              return dropdownController.states.indexWhere(
                                  (state) => state.name == selectedItem);
                            }).toList();

                            log("Selected States: $selectedItems");
                            log("Selected Indices: $selectedIndices");
                          },
                        )
                      : CustomTextField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'License State is required';
                            }
                            return null;
                          },
                          text: 'License State',
                          hintText: "Select State",
                          hasdropDownButton: true,
                          controller: controller.licensestateController,
                          dropdownItems: dropdownController.states
                              .map((state) => state.name)
                              .toList(),
                          onChanged: (value) {
                            final selectedIndex =
                                dropdownController.states.indexWhere(
                              (state) => state.name == value,
                            );

                            if (selectedIndex != -1) {
                              final selectedState =
                                  dropdownController.states[selectedIndex];
                              dropdownController
                                  .setSelectedState(selectedState);
                              log("Dropdown onChanged selected state: ${selectedState.name}, ID: ${selectedState.id}, Index: $selectedIndex");
                            } else {
                              log("Invalid state selected");
                            }
                          },
                        );
                }),
                SizedBox(height: context.screenHeight * 0.01),
                Obx(() {
                  return CustomTextField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Primary State is required';
                      }
                      return null;
                    },
                    text: 'Primary State',
                    hintText: "Select Primary State",
                    hasdropDownButton: true,
                    controller: controller.primaystateController,
                    dropdownItems: dropdownController.states
                        .map((state) => state.name)
                        .toList(),
                    onChanged: (value) {
                      final selectedIndex =
                          dropdownController.states.indexWhere(
                        (state) => state.name == value,
                      );

                      if (selectedIndex != -1) {
                        final selectedState =
                            dropdownController.states[selectedIndex];
                        dropdownController.setSelectedState(selectedState);
                        log("Dropdown onChanged selected state: ${selectedState.name}, ID: ${selectedState.id}, Index: $selectedIndex");
                      } else {
                        log("Invalid state selected");
                      }
                    },
                  );
                }),
                SizedBox(height: context.screenHeight * 0.01),
                DatePickerField(
                  text: 'Expiry Date:',
                  controller: controller.expiredobController,
                  validationMessage: 'Expiry Date is required',
                ),
                SizedBox(height: context.screenHeight * 0.005),
                Obx(() {
                  return controller.isEligible.value
                      ? const SizedBox.shrink()
                      : const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Please enter valid Expiry Date",
                            style: TextStyle(color: AppColors.error),
                          ),
                        );
                }),
                SizedBox(height: context.screenHeight * 0.03),
                SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        onPressed: () {
                          controller.validLicense();
                          final ProfessionalIndex =
                              dropdownController.professions.indexWhere(
                            (professions) =>
                                professions.name ==
                                controller.licenseController.text,
                          );

                          final PrimaryStateIndex =
                              dropdownController.states.indexWhere(
                            (state) =>
                                state.name ==
                                controller.primaystateController.text,
                          );
                          log("this is index of professionals ${dropdownController.indexvalue.toString()}");
                          if (controller.isEligible.value) {
                            if (_formKey.currentState?.validate() ?? false) {
                              log("Professtion index: $ProfessionalIndex");
                              log("Primary State index: $PrimaryStateIndex");

                              Map<String, dynamic> payload = {
                                'number':
                                    controller.licensenumberController.text,
                                'expiry_date':
                                    controller.expiredobController.text,
                                'profession': 22,
                                'primary_state': PrimaryStateIndex,
                              };
                              if (isMultiState.value) {
                                payload['state'] = selectedIndices
                                    .map((index) => index
                                        .toString()) // Map indices to string
                                    .toList();
                              } else {
                                // For single state selection
                                payload['state'] = dropdownController.states
                                    .indexWhere(
                                      (state) =>
                                          state.name ==
                                          controller
                                              .licensestateController.text,
                                    )
                                    .toString();
                              }

                              licenseController.addLicense(payload, context);
                              log("Payload to be sent: $payload");
                            }
                            log("All the successfully entered");
                          } else {
                            log("Please fill all the fields");
                          }
                        },
                        child: const Text('Save'))),
                SizedBox(height: context.screenHeight * 0.01),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: () => Get.to(() => const SettingScreen()),
                      child: const Text('Next')),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
