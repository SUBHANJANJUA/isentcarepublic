import 'dart:developer';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:isentcare/feature/auth/controller/dropdown_controller.dart';
import 'package:isentcare/modals/education_modal.dart';
import 'package:isentcare/models/education_viewController.dart';
import 'package:isentcare/network_data/response/status.dart';
import 'package:isentcare/resources/constants/app_sizer.dart';
import 'package:isentcare/resources/constants/color.dart';
import 'package:isentcare/resources/helper_functions.dart';
import 'package:isentcare/resources/utils.dart';
import 'package:isentcare/widgets/datepicker_field.dart';
import 'package:isentcare/widgets/text_field.dart';
import 'package:isentcare/widgets/update_close_button.dart';

import '../../../../../resources/capitalize_first_letter_formatter.dart';
import '../../../../../widgets/dropdownField.dart';

class EditEducationScreen extends StatefulWidget {
  final EducationModel educationData;

  const EditEducationScreen({super.key, required this.educationData});

  @override
  State<EditEducationScreen> createState() => _EditEducationScreenState();
}

class _EditEducationScreenState extends State<EditEducationScreen> {
  final TextEditingController degreeController = TextEditingController();
  final TextEditingController instituteController = TextEditingController();
  final TextEditingController startDateController = TextEditingController();
  final TextEditingController endDateController = TextEditingController();
  final TextEditingController countryController = TextEditingController();
  final TextEditingController gpaController = TextEditingController();
  final TextEditingController majorController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final EducationController controller = Get.put(EducationController());
  final DropdownController dropdownController = Get.put(DropdownController());
  var isValidDate = true.obs;

  void validateDateRange() {
    String fromDate = startDateController.text;
    String toDate = endDateController.text;

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
  void initState() {
    super.initState();
    controller.fetchCountries();
    degreeController.text = widget.educationData.degree;
    instituteController.text = widget.educationData.institute;
    startDateController.text =
        HelperUtil.formatDate(widget.educationData.startDate.toString());
    endDateController.text =
        HelperUtil.formatDate(widget.educationData.endDate.toString());
    countryController.text = widget.educationData.country!.name ?? '';
    gpaController.text = widget.educationData.gpa.toString();
    majorController.text = widget.educationData.majors;
    dropdownController.selectedValue.value =
        widget.educationData.country!.name ?? '';
  }

  @override
  Widget build(BuildContext context) {
    dropdownController.fetchCountry();
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  height: 50,
                  color: AppColors.primary,
                  child: const Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text(
                      'Edit Education',
                      style: TextStyle(
                          fontSize: 22,
                          color: Colors.white,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
                SizedBox(height: context.screenHeight * 0.01),
                CustomTextField(
                  inputFormatters: [CapitalizeFirstLetterFormatter()],
                  text: 'Degree',
                  hasdropDownButton: false,
                  controller: degreeController,
                  validator: (value) =>
                      value!.isEmpty ? 'Degree is required' : null,
                ),
                SizedBox(height: context.screenHeight * 0.01),
                CustomTextField(
                  inputFormatters: [CapitalizeFirstLetterFormatter()],
                  text: 'Institute',
                  hasdropDownButton: false,
                  controller: instituteController,
                  validator: (value) =>
                      value!.isEmpty ? 'Institute is required' : null,
                ),
                SizedBox(height: context.screenHeight * 0.01),
                DatePickerField(
                  text: 'From:',
                  controller: startDateController,
                  validationMessage: 'Start Date is required',
                ),
                SizedBox(height: context.screenHeight * 0.005),
                DatePickerField(
                  text: 'To:',
                  controller: endDateController,
                  validationMessage: 'End Date is required',
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
                SizedBox(height: context.screenHeight * 0.01),
                Obx(() {
                  return CustomTextField(
                    onPressed: () {
                      dropdownController.fetchCountry();
                    },
                    hasdropDownButton: true,
                    text: 'Country:',
                    hintText: "Select Country",
                    controller: countryController,
                    dropdownItems: dropdownController.countries
                        .map((countries) => countries.name)
                        .toList(),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Country is required';
                      }
                      return null;
                    },
                  );
                }),
                SizedBox(height: context.screenHeight * 0.01),
                CustomTextField(
                  inputFormatters: [CapitalizeFirstLetterFormatter()],
                  text: 'GPA',
                  hasdropDownButton: false,
                  controller: gpaController,
                  validator: (value) =>
                      value!.isEmpty ? 'GPA is required' : null,
                ),
                SizedBox(height: context.screenHeight * 0.01),
                CustomTextField(
                  inputFormatters: [CapitalizeFirstLetterFormatter()],
                  text: 'Major',
                  hasdropDownButton: false,
                  controller: majorController,
                  validator: (value) =>
                      value!.isEmpty ? 'Major is required' : null,
                ),
                SizedBox(height: context.screenHeight * 0.02),
                ResuableButtons(onTap: () async {
                  final CountryIndex = dropdownController.countries.indexWhere(
                    (countries) => countries.name == countryController.text,
                  );
                  log("Country index is: ${CountryIndex + 1}");
                  if (_formKey.currentState!.validate()) {
                    validateDateRange();
                    if (isValidDate.value) {
                      final updateData = {
                        'id': widget.educationData.id,
                        'institute': instituteController.text.trim(),
                        'degree': degreeController.text.trim(),
                        'majors': majorController.text.trim(),
                        'start_date': startDateController.text,
                        'end_date': endDateController.text,
                        'gpa':
                            double.tryParse(gpaController.text.trim()) ?? 0.0,
                        'country': CountryIndex + 1,
                      };

                      log(updateData.toString());

                      await controller.updateEducation(
                        updateData,
                        context,
                        widget.educationData.id!,
                      );
                    }
                  }
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
