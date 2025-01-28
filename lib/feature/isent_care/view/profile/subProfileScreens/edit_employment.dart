import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:isentcare/modals/employer_modal.dart';
import 'package:isentcare/models/employer_ViewController.dart';
import 'package:isentcare/resources/constants/app_sizer.dart';
import 'package:isentcare/resources/constants/color.dart';
import 'package:isentcare/resources/helper_functions.dart';
import 'package:isentcare/widgets/datepicker_field.dart';
import 'package:isentcare/widgets/text_field.dart';
import 'package:isentcare/widgets/update_close_button.dart';

import '../../../../../resources/capitalize_first_letter_formatter.dart';
import '../../../../auth/controller/dropdown_controller.dart';
import '../../../../auth/controller/personal_information_controller.dart';

class EditEmploymentScreen extends StatefulWidget {
  final EmployerModel employData;

  const EditEmploymentScreen({super.key, required this.employData});

  @override
  State<EditEmploymentScreen> createState() => _EditEducationScreenState();
}

class _EditEducationScreenState extends State<EditEmploymentScreen> {
  final TextEditingController companyController = TextEditingController();
  final TextEditingController jobTitleController = TextEditingController();
  final TextEditingController supervisorController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController fromDateController = TextEditingController();
  final TextEditingController toDateController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController stateController = TextEditingController();
  final TextEditingController reasonController = TextEditingController();
  final TextEditingController zipController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final EmployerController controller = Get.put(EmployerController());
  final PersonalInformationController googleAddressControler =
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
  void initState() {
    super.initState();
    companyController.text = widget.employData.company!;
    jobTitleController.text = widget.employData.jobTitle!;
    supervisorController.text = widget.employData.supervisor!;
    phoneController.text = widget.employData.telephone!;
    cityController.text = widget.employData.city;
    stateController.text = widget.employData.state;
    reasonController.text = widget.employData.leavingReason;
    zipController.text = widget.employData.zipCode;
    fromDateController.text =
        HelperUtil.formatDate(widget.employData.fromDate.toString());
    toDateController.text =
        HelperUtil.formatDate(widget.employData.toDate.toString());
    addressController.text = widget.employData.address!;
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  height: 50,
                  color: AppColors.primary,
                  child: const Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text(
                      'Experience',
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
                  text: 'Company/Institute Name',
                  hasdropDownButton: false,
                  controller: companyController,
                  validator: (value) => value!.isEmpty
                      ? 'Company/Institute Name is required'
                      : null,
                ),
                SizedBox(height: context.screenHeight * 0.01),
                CustomTextField(
                  inputFormatters: [CapitalizeFirstLetterFormatter()],
                  text: 'Job Title',
                  hasdropDownButton: false,
                  controller: jobTitleController,
                  validator: (value) =>
                      value!.isEmpty ? 'Job Title is required' : null,
                ),
                SizedBox(height: context.screenHeight * 0.01),
                CustomTextField(
                  inputFormatters: [CapitalizeFirstLetterFormatter()],
                  text: 'Supervisor',
                  hasdropDownButton: false,
                  controller: supervisorController,
                  validator: (value) =>
                      value!.isEmpty ? 'Supervisor is required' : null,
                ),
                SizedBox(height: context.screenHeight * 0.01),
                CustomTextField(
                  inputFormatters: [CapitalizeFirstLetterFormatter()],
                  text: 'Telephone',
                  hasdropDownButton: false,
                  controller: phoneController,
                  validator: (value) =>
                      value!.isEmpty ? 'Telephone is required' : null,
                ),
                SizedBox(height: context.screenHeight * 0.01),
                DatePickerField(
                  text: 'From:',
                  controller: fromDateController,
                  validationMessage: 'Start Date is required',
                ),
                SizedBox(height: context.screenHeight * 0.005),
                DatePickerField(
                  text: 'To:',
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
                SizedBox(height: context.screenHeight * 0.01),
                CustomTextField(
                  inputFormatters: [CapitalizeFirstLetterFormatter()],
                  text: 'City',
                  hasdropDownButton: false,
                  controller: cityController,
                  validator: (value) =>
                      value!.isEmpty ? 'City is required' : null,
                ),
                SizedBox(height: context.screenHeight * 0.01),
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
                SizedBox(height: context.screenHeight * 0.01),
                CustomTextField(
                  inputFormatters: [CapitalizeFirstLetterFormatter()],
                  onChanged: (value) {
                    googleAddressControler.fetchPlaces(value.toString());
                    addressController.text.isEmpty
                        ? googleAddressControler.fetchedPlaces.clear()
                        : null;
                  },
                  text: 'Address',
                  hasdropDownButton: false,
                  controller: addressController,
                  validator: (value) =>
                      value!.isEmpty ? 'Address is required' : null,
                ),
                SizedBox(height: context.screenHeight * 0.01),
                Obx(() {
                  if (googleAddressControler.fetchedPlaces.isEmpty) {
                    return SizedBox.shrink();
                  }
                  log("this is our ${googleAddressControler.fetchedPlaces[0].toString()}");
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: googleAddressControler.fetchedPlaces.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        onTap: () {
                          addressController.text = googleAddressControler
                              .fetchedPlaces[index]
                              .toString();
                          googleAddressControler.fetchedPlaces.clear();
                        },
                        title:
                            Text(googleAddressControler.fetchedPlaces[index]),
                      );
                    },
                  );
                }),
                SizedBox(height: context.screenHeight * 0.01),
                CustomTextField(
                  text: 'ZipCode',
                  hasdropDownButton: false,
                  controller: zipController,
                  validator: (value) =>
                      value!.isEmpty ? 'ZipCode is required' : null,
                ),
                SizedBox(height: context.screenHeight * 0.01),
                CustomTextField(
                  inputFormatters: [CapitalizeFirstLetterFormatter()],
                  text: 'Leaving Reason',
                  hasdropDownButton: false,
                  controller: reasonController,
                  validator: (value) =>
                      value!.isEmpty ? 'Leaving Reason is required' : null,
                ),
                SizedBox(height: context.screenHeight * 0.02),
                ResuableButtons(onTap: () async {
                  if (_formKey.currentState!.validate()) {
                    validateDateRange();
                    if (isValidDate.value) {
                      final updateData = EmployerModel(
                          id: widget.employData.id,
                          company: companyController.text.trim(),
                          jobTitle: jobTitleController.text.trim(),
                          supervisor: supervisorController.text.trim(),
                          telephone: phoneController.text.trim(),
                          fromDate:
                              DateTime.parse(fromDateController.text.trim()),
                          toDate: DateTime.parse(toDateController.text.trim()),
                          address: addressController.text.trim(),
                          city: cityController.text.trim(),
                          leavingReason: reasonController.text.trim(),
                          state: stateController.text.trim(),
                          zipCode: zipController.text.trim());

                      log(updateData.toString());

                      await controller.updateEmployer(
                        updateData,
                        context,
                        widget.employData.id!,
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
