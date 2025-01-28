import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:isentcare/modals/education_modal.dart';
import 'package:isentcare/models/education_viewController.dart';
import 'package:isentcare/resources/constants/app_sizer.dart';

import '../../../../../../network_data/response/status.dart';
import '../../../../../../repo/dropdown_repo.dart';
import '../../../../../../resources/capitalize_first_letter_formatter.dart';
import '../../../../../../resources/constants/color.dart';
import '../../../../../../resources/helper_functions.dart';
import '../../../../../../widget/heading/text_field_heading.dart';
import '../../../../../../widget/textfield/custom_text_field.dart';
import '../../../../../../widgets/datepicker_field.dart';
import '../../../../../../widgets/text_field.dart';
import '../../../../../auth/controller/dropdown_controller.dart';
import '../../../../../auth/controller/personal_information_controller.dart';

class EducationForm extends StatelessWidget {
  EducationForm({super.key});

  final startDateController = TextEditingController();
  final endDateController = TextEditingController();
  final degree = TextEditingController();
  final college = TextEditingController();
  final gpa = TextEditingController();
  final major = TextEditingController();
  final state = TextEditingController();
  final stateController = TextEditingController();
  final city = TextEditingController();
  final countryController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final DropdownController dropdownController = Get.put(DropdownController());
  final PersonalInformationController controller =
      Get.put(PersonalInformationController());
  final EducationController educationController =
      Get.put(EducationController());

  final _myRepo = DropDownRepository();
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
  Widget build(BuildContext context) {
    dropdownController.fetchStates();
    dropdownController.fetchCountry();
    _myRepo.getStates();

    return Column(
      children: [
        Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
              const TextFieldHeading(
                text: "Degree",
              ),
              const SizedBox(
                height: 5,
              ),
              CustomeTextFormField(
                inputFormatters: [CapitalizeFirstLetterFormatter()],
                controller: degree,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please enter degree";
                  } else {
                    return null;
                  }
                },
                hintText: "Degree",
              ),
              const SizedBox(
                height: 10,
              ),
              const TextFieldHeading(
                text: "College",
              ),
              const SizedBox(
                height: 5,
              ),
              CustomeTextFormField(
                inputFormatters: [CapitalizeFirstLetterFormatter()],
                controller: college,
                hintText: "College",
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please enter college";
                  } else {
                    return null;
                  }
                },
              ),
              const SizedBox(
                height: 10,
              ),
              DatePickerField(
                text: 'Start Date',
                controller: startDateController,
                validationMessage: 'Start Date is required',
              ),
              SizedBox(height: context.screenHeight * 0.005),
              DatePickerField(
                text: 'End Date',
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
              const SizedBox(
                height: 10,
              ),
              const TextFieldHeading(
                text: "City",
              ),
              const SizedBox(
                height: 5,
              ),
              CustomeTextFormField(
                inputFormatters: [CapitalizeFirstLetterFormatter()],
                controller: city,
                hintText: "City",
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please enter city";
                  } else {
                    return null;
                  }
                },
              ),
              const SizedBox(
                height: 10,
              ),
              Obx(() {
                return CustomTextField(
                  onPressed: () {
                    dropdownController.fetchStates();
                  },
                  hasdropDownButton: true,
                  text: 'State:',
                  hintText: "Select State",
                  controller: stateController,
                  dropdownItems: dropdownController.states
                      .map((state) => state.name)
                      .toList(),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'State is required';
                    }
                    return null;
                  },
                );
              }),
              const SizedBox(
                height: 10,
              ),
              const TextFieldHeading(
                text: "GPA",
              ),
              const SizedBox(
                height: 5,
              ),
              CustomeTextFormField(
                inputFormatters: [CapitalizeFirstLetterFormatter()],
                controller: gpa,
                hintText: "GPA",
                validator: (value) {
                  if (gpa.text.isEmpty) {
                    return "Please enter gpa";
                  } else {
                    return null;
                  }
                },
              ),
              const SizedBox(
                height: 10,
              ),
              const TextFieldHeading(
                text: "Major",
              ),
              const SizedBox(
                height: 5,
              ),
              CustomeTextFormField(
                inputFormatters: [CapitalizeFirstLetterFormatter()],
                controller: major,
                hintText: "Major",
                validator: (value) {
                  if (major.text.isEmpty) {
                    return "Please enter major";
                  } else {
                    return null;
                  }
                },
              ),
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
                      final StateIndex = dropdownController.states.indexWhere(
                        (state) => state.name == stateController.text,
                      );
                      final CountryIndex =
                          dropdownController.countries.indexWhere(
                        (countries) => countries.name == countryController.text,
                      );
                      log("stete index is: ${StateIndex + 1}");
                      log("Country index is: ${CountryIndex + 1}");
                      if (formKey.currentState!.validate()) {
                        validateDateRange();
                        if (isValidDate.value) {
                          final educationData = {
                            "state": StateIndex + 1,
                            "institute": college.text,
                            "degree": degree.text,
                            "majors": major.text,
                            "city": city.text,
                            "start_date": startDateController.text,
                            "end_date": endDateController.text,
                            "gpa": double.parse(gpa.text),
                            "country": CountryIndex + 1
                          };
                          educationController.addEducations(
                              educationData, context);
                        }
                      } else {
                        log("Not Done");
                      }
                    },
                    child: const Text("Add"))))
      ],
    );
  }
}
