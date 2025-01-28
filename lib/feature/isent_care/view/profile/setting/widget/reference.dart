import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:isentcare/feature/isent_care/controller/reference_controller.dart';
import 'package:isentcare/models/education_viewController.dart';
import 'package:isentcare/models/signature_controller.dart';
import 'package:isentcare/resources/constants/app_sizer.dart';
import 'package:isentcare/resources/constants/color.dart';
import 'package:isentcare/widget/dialog/signature_dialog.dart';

import '../../../../../../resources/capitalize_first_letter_formatter.dart';
import '../../../../../../resources/helper_functions.dart';
import '../../../../../../widget/heading/text_field_heading.dart';
import '../../../../../../widget/textfield/custom_text_field.dart';
import '../../../../../../widgets/datepicker_field.dart';

class ReferenceCheckForm extends StatelessWidget {
  ReferenceCheckForm({super.key});

  final fromDateController = TextEditingController();
  final toDateController = TextEditingController();
  final formerEmployer = TextEditingController();
  final jobTitle = TextEditingController();
  final formerEmail = TextEditingController();
  final formerPhone = TextEditingController();
  final name = TextEditingController();
  final formKey5 = GlobalKey<FormState>();
  final EducationController educationController =
      Get.put(EducationController());
  final SignController signController = Get.put(SignController());
  var isValidDate = true.obs;

  void validateDateRange() {
    String fromDate = fromDateController.text;
    String toDate = toDateController.text;

    if (fromDate.isEmpty || toDate.isEmpty) {
      isValidDate.value = false;
      return;
    }

    try {
      DateTime fromDateTime = DateTime.parse(fromDate);
      DateTime toDateTime = DateTime.parse(toDate);

      if (toDateTime.isBefore(fromDateTime)) {
        isValidDate.value = false;
      } else {
        isValidDate.value = true;
      }
    } catch (e) {
      isValidDate.value = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ReferenceController());

    return Column(
      children: [
        Form(
          key: formKey5,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
              const TextFieldHeading(
                text: "To (Former Employer)",
              ),
              const SizedBox(
                height: 5,
              ),
              CustomeTextFormField(
                inputFormatters: [CapitalizeFirstLetterFormatter()],
                controller: formerEmployer,
                hintText: "To (Former Employer)",
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please enter email";
                  } else {
                    return null;
                  }
                },
              ),
              const SizedBox(
                height: 10,
              ),
              const TextFieldHeading(
                text: "Job Title",
              ),
              const SizedBox(
                height: 5,
              ),
              CustomeTextFormField(
                inputFormatters: [CapitalizeFirstLetterFormatter()],
                controller: jobTitle,
                hintText: "Job Title",
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please enter job title";
                  } else {
                    return null;
                  }
                },
              ),
              const SizedBox(
                height: 10,
              ),
              const TextFieldHeading(
                text: "Former Email",
              ),
              const SizedBox(
                height: 5,
              ),
              CustomeTextFormField(
                controller: formerEmail,
                hintText: "Email",
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please enter email";
                  } else if (!RegExp(
                          r"^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]+$")
                      .hasMatch(value)) {
                    return "Enter a valid email";
                  } else {
                    return null;
                  }
                },
              ),
              const SizedBox(
                height: 10,
              ),
              const TextFieldHeading(
                text: "Former Phone",
              ),
              const SizedBox(
                height: 5,
              ),
              CustomeTextFormField(
                controller: formerPhone,
                hintText: "Former Phone",
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please enter phone number";
                  } else {
                    return null;
                  }
                },
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                  "The following person has applied for a position in out firm and has given you as a aformer employer. Your evaluation would be sincerely appreciated and considered strictly confidential. Please respond promptly as emplloyment is pending receipt of reference. Thank You"),
              const SizedBox(
                height: 5,
              ),
              const Text("IsentCare"),
              const Text("(Prospective Employer)"),
              const SizedBox(
                height: 10,
              ),
              const TextFieldHeading(
                text: "Employment Dates:",
              ),
              DatePickerField(
                text: 'From:',
                controller: fromDateController,
                validationMessage: 'From Date is required',
              ),
              SizedBox(height: context.screenHeight * 0.005),
              DatePickerField(
                text: 'To:',
                controller: toDateController,
                validationMessage: 'To Date is required',
              ),
              SizedBox(height: context.screenHeight * 0.005),
              Obx(() {
                return isValidDate.value
                    ? const SizedBox.shrink()
                    : const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Please enter valid date",
                          style: TextStyle(color: AppColors.error),
                        ),
                      );
              }),
              const SizedBox(
                height: 10,
              ),
              const TextFieldHeading(
                text: "May we check the reference above.",
              ),
              Obx(
                () => RadioListTile(
                  fillColor: const WidgetStatePropertyAll(AppColors.primary),
                  dense: true,
                  visualDensity:
                      const VisualDensity(horizontal: -4, vertical: -4),
                  contentPadding: EdgeInsets.zero,
                  value: 0,
                  groupValue: controller.radioGroupValue.value,
                  onChanged: (value) {
                    controller.radioGroupValue.value = value as int;
                  },
                  title: const Text("Yes"),
                ),
              ),
              Obx(
                () => RadioListTile(
                  fillColor: const WidgetStatePropertyAll(AppColors.primary),
                  dense: true,
                  visualDensity:
                      const VisualDensity(horizontal: -4, vertical: -4),
                  contentPadding: EdgeInsets.zero,
                  value: 1,
                  groupValue: controller.radioGroupValue.value,
                  onChanged: (value) {
                    controller.radioGroupValue.value = value as int;
                  },
                  title: const Text("No"),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const TextFieldHeading(
                text: "Name",
              ),
              const SizedBox(
                height: 5,
              ),
              CustomeTextFormField(
                  inputFormatters: [CapitalizeFirstLetterFormatter()],
                  controller: name,
                  hintText: "Name",
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter name";
                    } else {
                      return null;
                    }
                  }),
              const SizedBox(
                height: 10,
              ),
              const TextFieldHeading(
                text: "Signature",
              ),
              const SizedBox(
                height: 5,
              ),
              Obx(() {
                return CustomeTextFormField(
                  // controller:   signController.signatureController,
                  validator: signController.signEmpty.value
                      ? (value) {
                          if (value == null || value.isEmpty) {
                            return "Please write Signature";
                          } else {
                            return null;
                          }
                        }
                      : null,

                  readOnly: true,
                  onTap: () {
                    showDialog(
                      context: Get.context!,
                      builder: (context) => SignatureDialog(
                        dilogdescription: "Are you sure you want to delete?",
                        onTap: () {},
                      ),
                    );
                  },
                  hintText: "Add Signature",
                );
              })
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Center(
            child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () {
                      signController.checkSignEmpty();
                      if (formKey5.currentState!.validate()) {
                        validateDateRange();
                        if (isValidDate.value) {
                          log("data enter sucessfully");
                          final referenceData = {
                            "job_title": jobTitle.text,
                            "employer": formerEmployer.text,
                            "email": formerEmail.text,
                            "phone": formerPhone.text,
                            "agree": controller.radioGroupValue.value == 0
                                ? true
                                : false,
                            "from_date": fromDateController.text,
                            "to_date": toDateController.text,
                            "name": name.text,
                            "signature": signController.signatureBase64.value
                          };
                          educationController.addReference(
                              referenceData, context);
                          log(referenceData.toString());
                        }
                      } else {
                        log("Not Done");
                      }
                    },
                    child: const Text("Save"))))
      ],
    );
  }
}
