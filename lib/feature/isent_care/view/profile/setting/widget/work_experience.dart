import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:isentcare/modals/employer_modal.dart';
import 'package:isentcare/models/employer_ViewController.dart';
import 'package:isentcare/resources/constants/app_sizer.dart';

import '../../../../../../resources/capitalize_first_letter_formatter.dart';
import '../../../../../../resources/constants/color.dart';
import '../../../../../../resources/helper_functions.dart';
import '../../../../../../widget/heading/text_field_heading.dart';
import '../../../../../../widget/textfield/custom_text_field.dart';
import '../../../../../../widgets/datepicker_field.dart';
import '../../../../../../widgets/text_field.dart';
import '../../../../../auth/controller/dropdown_controller.dart';
import '../../../../../auth/controller/personal_information_controller.dart';

class WorkExperienceForm extends StatelessWidget {
  WorkExperienceForm({super.key});
  final toDateController = TextEditingController();
  final fromDateController = TextEditingController();
  final company = TextEditingController();
  final jobTitle = TextEditingController();
  final supervisor = TextEditingController();
  final phone = TextEditingController();
  final leave = TextEditingController();
  final stateController = TextEditingController();
  final city = TextEditingController();
  final addressContrller = TextEditingController();
  final zipcode = TextEditingController();

  final formKey = GlobalKey<FormState>();
  final EmployerController employerController = Get.put(EmployerController());
  final PersonalInformationController controller =
      Get.put(PersonalInformationController());
  final DropdownController dropdownController = Get.put(DropdownController());
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 10,
        ),
        const Text(
          "Providing the following information at least [3]",
          style: TextStyle(
            fontSize: 12,
          ),
        ),
        const Text(
          "Employers, Assignments or Volunteer Activities starting with the most recent. Give the complete Address, Telephone Number and Full Name of Supervisor",
          style: TextStyle(fontSize: 12),
        ),
        const SizedBox(
          height: 20,
        ),
        Form(
            key: formKey,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const TextFieldHeading(
                text: "Company/Institute Name",
              ),
              const SizedBox(
                height: 5,
              ),
              CustomeTextFormField(
                inputFormatters: [CapitalizeFirstLetterFormatter()],
                controller: company,
                hintText: "Company/Institute",
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter Company/Institute Name';
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
                  if (value == null || value.isEmpty) {
                    return 'Please enter Job Title';
                  } else {
                    return null;
                  }
                },
              ),
              const SizedBox(
                height: 10,
              ),
              const TextFieldHeading(
                text: "Supervisor",
              ),
              const SizedBox(
                height: 5,
              ),
              CustomeTextFormField(
                inputFormatters: [CapitalizeFirstLetterFormatter()],
                controller: supervisor,
                hintText: "Supervisor Name",
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter Supervisor Name';
                  } else {
                    return null;
                  }
                },
              ),
              const SizedBox(
                height: 10,
              ),
              const TextFieldHeading(
                text: "Telephone",
              ),
              const SizedBox(
                height: 5,
              ),
              CustomeTextFormField(
                controller: phone,
                hintText: "Telephone Number",
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter Telephone Number';
                  } else {
                    return null;
                  }
                },
              ),
              const SizedBox(
                height: 10,
              ),
              CustomTextField(
                  inputFormatters: [CapitalizeFirstLetterFormatter()],
                  onChanged: (value) {
                    controller.fetchPlaces(value.toString());
                    addressContrller.text.isEmpty
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
                  controller: addressContrller),
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
                        addressContrller.text =
                            controller.fetchedPlaces[index].toString();
                        controller.fetchedPlaces.clear();
                      },
                      title: Text(controller.fetchedPlaces[index]),
                    );
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
                  if (value == null || value.isEmpty) {
                    return 'Please enter City';
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
                  controller: stateController,
                  dropdownItems: dropdownController.states
                      .map((state) => state.name)
                      .toList(),
                );
              }),
              const SizedBox(
                height: 10,
              ),
              const TextFieldHeading(
                text: "Zip Code",
              ),
              const SizedBox(
                height: 5,
              ),
              CustomeTextFormField(
                controller: zipcode,
                hintText: "Zip Code",
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter Zip Code';
                  } else {
                    return null;
                  }
                },
              ),
              const SizedBox(
                height: 10,
              ),
              DatePickerField(
                text: 'From',
                controller: fromDateController,
                validationMessage: 'Start Date is required',
              ),
              SizedBox(height: context.screenHeight * 0.005),
              DatePickerField(
                text: 'To',
                controller: toDateController,
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
              const SizedBox(
                height: 10,
              ),
              const TextFieldHeading(
                text: "Reason for Leaving",
              ),
              const SizedBox(
                height: 5,
              ),
              CustomeTextFormField(
                inputFormatters: [CapitalizeFirstLetterFormatter()],
                controller: leave,
                hintText: "Reason for Leaving",
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter Reason for Leaving';
                  } else {
                    return null;
                  }
                },
              ),
            ])),
        const SizedBox(
          height: 10,
        ),
        Center(
            child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () {
                      final LicenceStateIndex =
                          dropdownController.states.indexWhere(
                        (state) => state.name == stateController.text,
                      );
                      if (formKey.currentState!.validate()) {
                        validateDateRange();
                        if (isValidDate.value) {
                          log(company.text);
                          log(jobTitle.text);
                          log(supervisor.text);
                          log(phone.text);
                          log(addressContrller.text);
                          log(city.text);
                          log(stateController.text);
                          log(zipcode.text);
                          log(fromDateController.text);
                          log(toDateController.text);
                          log(leave.text);
                          log("Selected State Index: $LicenceStateIndex");

                          EmployerModel employData = EmployerModel(
                              state: stateController.text,
                              supervisor: supervisor.text,
                              jobTitle: jobTitle.text,
                              telephone: phone.text,
                              address: addressContrller.text,
                              company: company.text,
                              zipCode: zipcode.text,
                              city: city.text,
                              leavingReason: leave.text,
                              fromDate: DateTime.parse(fromDateController.text),
                              toDate: DateTime.parse(toDateController.text));
                          employerController.addEmployer(employData, context);
                        }
                      } else {
                        log("Something went wrong");
                      }
                    },
                    child: const Text("Add"))))
      ],
    );
  }
}
