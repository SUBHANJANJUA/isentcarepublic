import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:isentcare/feature/auth/controller/jobtype_controller.dart';
import 'package:isentcare/feature/isent_care/register/personal_information.dart';
import 'package:isentcare/resources/constants/app_sizer.dart';
import 'package:isentcare/resources/constants/color.dart';
import 'package:isentcare/resources/utils.dart';
import 'package:isentcare/widgets/datepicker_field.dart';

import '../../../../resources/capitalize_first_letter_formatter.dart';

class JobTypeScreen extends StatelessWidget {
  final JobTypeController controller = Get.put(JobTypeController());
  final _formKey = GlobalKey<FormState>();
  JobTypeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Job Type"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Obx(
          () => SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Type of License or Certification:",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                        inputFormatters: [CapitalizeFirstLetterFormatter()],
                        controller: controller.licenceController,
                        decoration: InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                          hintText: "Enter your license or certification",
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'License or certification is required';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      DatePickerField(
                        text: 'Joining Date:',
                        controller: controller.joiningController,
                        validationMessage: 'Joining Date is required',
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  "Interested in:",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Column(
                  children: [
                    CustomCheckboxTile(
                      title: "Flexible on demand / Per Diem",
                      value: controller.perDiem.value,
                      onChanged: (value) => controller.perDiem.value = value!,
                    ),
                    CustomCheckboxTile(
                      title: "Fixed Time Contract",
                      value: controller.fixTime.value,
                      onChanged: (value) => controller.fixTime.value = value!,
                    ),
                    CustomCheckboxTile(
                      title: "Traveling Assignment",
                      value: controller.travelingAssignment.value,
                      onChanged: (value) =>
                          controller.travelingAssignment.value = value!,
                    ),
                    CustomCheckboxTile(
                      title: "Permanent Placement",
                      value: controller.permanentPlacement.value,
                      onChanged: (value) =>
                          controller.permanentPlacement.value = value!,
                    ),
                  ],
                ),
                SizedBox(height: context.screenHeight * 0.03),
                Center(
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: controller.loading.value
                          ? null // Disable button while loading
                          : () async {
                              if (_formKey.currentState?.validate() ?? false) {
                                if (controller.isInterestSelected()) {
                                  await controller.getLatLong();
                                  Get.to(() => PersonalInformation());
                                } else {
                                  Utils.showError(
                                      'Please select at least one interest before proceeding.');
                                }
                              }
                            },
                      child: controller.loading.value
                          ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(Colors.white),
                              ),
                            )
                          : const Text("Next"),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CustomCheckboxTile extends StatelessWidget {
  final String title;
  final bool value;
  final ValueChanged<bool?> onChanged;

  const CustomCheckboxTile({
    super.key,
    required this.title,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          side: const BorderSide(color: AppColors.iconColor, width: 2),
          activeColor: AppColors.iconColor,
          value: value,
          onChanged: onChanged,
        ),
        Expanded(
          child: Text(
            title,
            style: const TextStyle(fontSize: 16),
          ),
        ),
      ],
    );
  }
}
