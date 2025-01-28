import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:isentcare/feature/auth/controller/dropdown_controller.dart';
import 'package:isentcare/modals/license_modal.dart';
import 'package:isentcare/resources/constants/app_sizer.dart';
import 'package:isentcare/resources/constants/color.dart';
import 'package:isentcare/resources/helper_functions.dart';
import 'package:isentcare/widgets/datepicker_field.dart';
import 'package:isentcare/widgets/text_field.dart';
import 'package:isentcare/widgets/update_close_button.dart';

import '../../../../../repo/dropdown_repo.dart';

class EditLicenseScreen extends StatefulWidget {
  final LicenseModel licenseData;

  const EditLicenseScreen({super.key, required this.licenseData});

  @override
  State<EditLicenseScreen> createState() => _EditEducationScreenState();
}

class _EditEducationScreenState extends State<EditLicenseScreen> {
  final TextEditingController professionController = TextEditingController();
  final TextEditingController licensenumberController = TextEditingController();
  final TextEditingController licensestateController = TextEditingController();

  final TextEditingController expirydateController = TextEditingController();
  final TextEditingController fromDateController = TextEditingController();
  final TextEditingController toDateController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final DropdownController dropdownController = Get.put(DropdownController());
  final stateapicontroller = Get.put(DropDownRepository());

  @override
  void initState() {
    super.initState();
    professionController.text = widget.licenseData.profession.name;
    licensenumberController.text = widget.licenseData.number;
    licensestateController.text = widget.licenseData.primaryState!.name;
    expirydateController.text =
        HelperUtil.formatDate(widget.licenseData.expiryDate.toString());
    dropdownController.fetchStates();
    dropdownController.fetchProfessions();
    dropdownController.selectedProfessionId.value =
        widget.licenseData.profession.id;
    dropdownController.selectedProfessionName.value =
        widget.licenseData.profession.name;

    dropdownController.selectedStateId.value =
        widget.licenseData.primaryState!.id;
    dropdownController.selectedStateName.value =
        widget.licenseData.primaryState!.name;
  }

  @override
  Widget build(BuildContext context) {
    stateapicontroller.getStates();
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: double.infinity,
                height: 50,
                color: AppColors.primary,
                child: const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    'License',
                    style: TextStyle(
                        fontSize: 22,
                        color: Colors.white,
                        fontWeight: FontWeight.w700),
                  ),
                ),
              ),
              SizedBox(height: context.screenHeight * 0.01),
              CustomTextField(
                text: 'Professional License',
                hasdropDownButton: true,
                controller: professionController,
                dropdownItems: dropdownController.professions
                    .map((professions) => professions.name)
                    .toList(),
              ),
              SizedBox(height: context.screenHeight * 0.01),
              CustomTextField(
                text: 'License Number',
                hasdropDownButton: false,
                controller: licensenumberController,
              ),
              SizedBox(height: context.screenHeight * 0.01),
              CustomTextField(
                text: 'License State',
                hasdropDownButton: true,
                controller: licensestateController,
                dropdownItems: dropdownController.states
                    .map((state) => state.name)
                    .toList(),
                onChanged: (value) {
                  final selectedIndex = dropdownController.states.indexWhere(
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
              ),
              SizedBox(height: context.screenHeight * 0.01),
              DatePickerField(
                text: 'Expiry Date',
                controller: expirydateController,
                validationMessage: 'Expiry  Date is required',
              ),
              SizedBox(height: context.screenHeight * 0.02),
              ResuableButtons(onTap: () {
                final LicenceStateIndex = dropdownController.states.indexWhere(
                  (state) => state.name == licensestateController.text,
                );
                final ProfessionalIndex =
                    dropdownController.professions.indexWhere(
                  (professions) =>
                      professions.name == professionController.text,
                );
                log("licence state index is: $LicenceStateIndex");
                log(dropdownController.indexvalue.toString());
                // log('Saved Profession ID: ${dropdownController.selectedProfessionId.value}');
                // log('Saved State ID: ${dropdownController.selectedStateId.value}');
                // log('Saved Profession ID: ${dropdownController.selectedProfessionName.value}');
                // log('Saved State ID: ${dropdownController.selectedStateName.value}');
                // log("this is vlaue of the professtiona ${professionController.text}");
                // log("this is vlaue of the license ${licensestateController.text}");
                // log("Selected State Index: ${LicenceStateIndex}");
                // log("Selected Professional Index: ${ProfessionalIndex}");

                // final updateData = {
                //   'id': widget.licenseData.id,
                //   'number': licensenumberController.text.trim(),
                //   'profession': ProfessionalIndex,
                //   'state': LicenceStateIndex,
                //   'expiry_date': DateTime.parse(expirydateController.text),
                // };
                // log(updateData.toString());
              }),
            ],
          ),
        ),
      ),
    );
  }
}
