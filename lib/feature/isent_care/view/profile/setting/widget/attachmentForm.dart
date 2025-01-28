import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:isentcare/feature/auth/controller/attachmentFormController.dart';
import 'package:isentcare/feature/auth/controller/jobtype_controller.dart';
import 'package:isentcare/feature/auth/controller/media_controller.dart';
import 'package:isentcare/modals/emp_auth_model.dart';
import 'package:isentcare/modals/id_doc_model.dart';
import 'package:isentcare/modals/id_emp_Model.dart';
import 'package:isentcare/resources/constants/app_sizer.dart';
import 'package:isentcare/resources/utils.dart';
import 'package:isentcare/widgets/citizenship_form.dart';
import 'package:isentcare/widgets/datepicker_field.dart';
import 'package:isentcare/widgets/image_card.dart';
import 'package:isentcare/widgets/text_field.dart';

import '../../../../../../resources/capitalize_first_letter_formatter.dart';
import '../../../../../../resources/constants/color.dart';
import '../../../../../auth/controller/citizenship_controller.dart';
import '../../../../../auth/controller/dropdown_controller.dart';
import '../../../../../auth/controller/personal_information_controller.dart';

class AttachmentForm extends StatelessWidget {
  AttachmentForm({super.key});

  final JobTypeController controller = Get.put(JobTypeController());
  final DropdownController dropdownController = Get.put(DropdownController());
  final CitizenshipController radioController =
      Get.put(CitizenshipController());
  final SelectMediaController selectMediaController =
      Get.put(SelectMediaController());
  final PersonalInformationController googleAddressControler =
      Get.put(PersonalInformationController());
  final Attachmentformcontroller attachmentformcontroller =
      Get.put(Attachmentformcontroller());
  final formKey1 = GlobalKey<FormState>();
  final formKey2 = GlobalKey<FormState>();
  final formKey3 = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    dropdownController.fetchIdEmpList();
    dropdownController.fetchEmpAuthList();
    dropdownController.fetchIdDocList();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Form(
            key: formKey1,
            child: Column(
              children: [
                SizedBox(height: context.screenHeight * 0.02),
                GridView.count(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  crossAxisCount: 2,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 10,
                  children: [
                    UploadCard(
                        title: 'Physical Exam', cardKey: 'physical_exam'),
                    UploadCard(title: 'Exam', cardKey: 'exam'),
                    UploadCard(
                        title: 'TB Test or Chest X-Ray', cardKey: 'tb_test'),
                    UploadCard(
                        title: 'Covid-19 Vaccination',
                        cardKey: 'covid_vaccination'),
                    UploadCard(
                        title: 'Dementia Training Proof',
                        cardKey: 'dementia_training'),
                    UploadCard(
                        title: 'Flu Vaccination', cardKey: 'flu_vaccination'),
                    UploadCard(
                      title: 'CPR Card or Certificate',
                      cardKey: 'cpr_certificate',
                      setvalue: () => selectMediaController.setCprAttachment(),
                    ),
                    UploadCard(
                      title: 'Other Attachments',
                      cardKey: 'other_attachments',
                      setvalue: () =>
                          selectMediaController.setOtherAttachment(),
                    ),
                  ],
                ),
                Obx(
                  () => selectMediaController.otherAttachments.value
                      ? CustomTextField(
                          hasdropDownButton: false,
                          text: 'Other Attachment Name:',
                          hintText: 'Attachment',
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Other Attachment name is required';
                            }
                            return null;
                          },
                          controller:
                              attachmentformcontroller.otherAttachController)
                      : const SizedBox.shrink(),
                ),
                SizedBox(height: context.screenHeight * 0.02),
                Obx(
                  () => selectMediaController.cprAttachments.value
                      ? Column(
                          children: [
                            DatePickerField(
                              text: 'Expiry Date:',
                              controller:
                                  attachmentformcontroller.expiredobController1,
                              validationMessage: 'Expaire Date is required',
                            ),
                            Obx(() {
                              return attachmentformcontroller.isExpire1.value
                                  ? const SizedBox.shrink()
                                  : const Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        "Please enter valid Expiry Date",
                                        style:
                                            TextStyle(color: AppColors.error),
                                      ),
                                    );
                            }),
                          ],
                        )
                      : SizedBox.shrink(),
                ),
                SizedBox(height: context.screenHeight * 0.02),
                Center(
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        final selectedFiles =
                            selectMediaController.selectedFiles;

                        if (formKey1.currentState?.validate() ?? false) {
                          attachmentformcontroller.expireDate1();
                          if (selectMediaController.cprAttachments.value
                              ? attachmentformcontroller.isExpire1.value
                              : (selectedFiles.isNotEmpty ||
                                  selectedFiles.isEmpty)) {
                            if (selectedFiles.isNotEmpty) {
                              selectedFiles.forEach((key, file) {
                                if (file != null) {
                                  log("Selected file for $key: ${file.path}");
                                } else {
                                  log("No file selected for $key");
                                }
                              });
                            } else {
                              Utils.showInfo(
                                  'Select at least one file to proceede next.');
                            }
                            log(attachmentformcontroller
                                .otherAttachController.text);
                            log(attachmentformcontroller
                                .expiredobController1.text);
                          }
                        }
                      },
                      child: const Text('Save'),
                    ),
                  ),
                ),
              ],
            )),
        SizedBox(height: context.screenHeight * 0.02),
        Form(
            key: formKey2,
            child: Obx(
              () => Column(
                children: [
                  const Text('Employment Eligibility Verification',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
                  SizedBox(height: context.screenHeight * 0.01),
                  const Text(
                      'Check one of the following boxes to attest to your citizenship or immigration status',
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w400)),
                  SizedBox(height: context.screenHeight * 0.02),
                  CitizenshipForm(),
                  SizedBox(height: context.screenHeight * 0.02),
                  radioController.selectedOption.value == 4
                      ? DatePickerField(
                          text: 'Expiry Date:',
                          controller:
                              attachmentformcontroller.expiredobController2,
                          validationMessage: 'Expire Date is required',
                        )
                      : SizedBox.shrink(),
                  radioController.selectedOption.value == 4
                      ? attachmentformcontroller.isExpire2.value
                          ? const SizedBox.shrink()
                          : const Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Please enter valid Expiry Date",
                                style: TextStyle(color: AppColors.error),
                              ),
                            )
                      : SizedBox.shrink(),
                  SizedBox(height: context.screenHeight * 0.02),
                  CustomTextField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Identity is required';
                      }
                      return null;
                    },
                    onPressed: () {
                      attachmentformcontroller.idEmpController.clear();
                      attachmentformcontroller.empAuthController.clear();
                      attachmentformcontroller.idDocController.clear();
                      selectMediaController.selectedFiles.clear();
                    },
                    heightDialog: 0.35,
                    hasdropDownButton: true,
                    text: 'Select Identity:',
                    hintText: "Select",
                    controller: attachmentformcontroller.identityController,
                    dropdownItems: dropdownController.identity,
                  ),
                  SizedBox(height: context.screenHeight * 0.02),
                  attachmentformcontroller.selectedIdentity.value ==
                          "Identity/Employment"
                      ? Column(
                          children: [
                            CustomTextField(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Identity/Employment is required';
                                }
                                return null;
                              },
                              heightDialog: 0.385,
                              hasdropDownButton: true,
                              text: 'Identity/Employment:',
                              hintText: "Select",
                              controller:
                                  attachmentformcontroller.idEmpController,
                              dropdownItems: dropdownController.idEmpList
                                  .map((idEmp) => idEmp.name ?? "Unknown")
                                  .toList(),
                            ),
                            UploadCard(
                              title: '',
                              cardKey: 'id_emp',
                            ),
                          ],
                        )
                      : SizedBox.shrink(),
                  attachmentformcontroller.selectedIdentity.value ==
                          "Employment Authorization"
                      ? Column(
                          children: [
                            CustomTextField(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Employment Authorization is required';
                                }
                                return null;
                              },
                              heightDialog: 0.300,
                              hasdropDownButton: true,
                              text: 'Employment Authorization:',
                              hintText: "Select",
                              controller:
                                  attachmentformcontroller.empAuthController,
                              dropdownItems: dropdownController.empAuthList
                                  .map((idEmp) => idEmp.name ?? "Unknown")
                                  .toList(),
                            ),
                            SizedBox(height: context.screenHeight * 0.02),
                            CustomTextField(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Identity Document is required';
                                }
                                return null;
                              },
                              heightDialog: 0.280,
                              hasdropDownButton: true,
                              text: 'Identity Document:',
                              hintText: "Select",
                              controller:
                                  attachmentformcontroller.idDocController,
                              dropdownItems: dropdownController.idDocList
                                  .map((idEmp) => idEmp.name ?? "Unknown")
                                  .toList(),
                            ),
                            SizedBox(height: context.screenHeight * 0.02),
                            SizedBox(
                              child: Row(
                                children: [
                                  Expanded(
                                    child: UploadCard(
                                      title: 'Identity Document',
                                      cardKey: 'id_doc',
                                    ),
                                  ),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  Expanded(
                                    child: UploadCard(
                                      title: 'Emp Authorization',
                                      cardKey: 'emp_auth',
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )
                      : SizedBox.shrink(),
                  attachmentformcontroller.selectedIdentity.value ==
                          "Identity Document"
                      ? Column(
                          children: [
                            CustomTextField(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Identity Document is required';
                                }
                                return null;
                              },
                              onPressed: () {
                                // dropdownController.fetchStates();
                              },
                              heightDialog: 0.280,
                              hasdropDownButton: true,
                              text: 'Identity Document:',
                              hintText: "Select",
                              controller:
                                  attachmentformcontroller.idDocController,
                              dropdownItems: dropdownController.idDocList
                                  .map((idEmp) => idEmp.name ?? "Unknown")
                                  .toList(),
                            ),
                            SizedBox(height: context.screenHeight * 0.02),
                            CustomTextField(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Employment Authorization is required';
                                }
                                return null;
                              },
                              onPressed: () {
                                // dropdownController.fetchStates();
                              },
                              heightDialog: 0.300,
                              hasdropDownButton: true,
                              text: 'Employment Authorization:',
                              hintText: "Select",
                              controller:
                                  attachmentformcontroller.empAuthController,
                              dropdownItems: dropdownController.empAuthList
                                  .map((idEmp) => idEmp.name ?? "Unknown")
                                  .toList(),
                            ),
                            SizedBox(height: context.screenHeight * 0.02),
                            SizedBox(
                              child: Row(
                                children: [
                                  Expanded(
                                    child: UploadCard(
                                      title: 'Emp Authorization',
                                      cardKey: 'emp_auth',
                                    ),
                                  ),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  Expanded(
                                    child: UploadCard(
                                      title: 'Identity Document',
                                      cardKey: 'id_doc',
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )
                      : SizedBox.shrink(),
                  SizedBox(height: context.screenHeight * 0.02),
                  Center(
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          final idEmpIndex =
                              dropdownController.idEmpList.indexWhere(
                            (IdEmpModel) =>
                                IdEmpModel.name ==
                                attachmentformcontroller.idEmpController.text,
                          );

                          final empAuthIndex =
                              dropdownController.empAuthList.indexWhere(
                            (EmpAuthModel) =>
                                EmpAuthModel.name ==
                                attachmentformcontroller.empAuthController.text,
                          );
                          final idDocIndex =
                              dropdownController.idDocList.indexWhere(
                            (IdDocModel) =>
                                IdDocModel.name ==
                                attachmentformcontroller.idDocController.text,
                          );

                          final selectedFiles =
                              selectMediaController.selectedFiles;
                          if (formKey2.currentState?.validate() ?? false) {
                            attachmentformcontroller.expireDate2();

                            if (radioController.selectedOption.value == 4
                                ? attachmentformcontroller.isExpire2.value
                                : (selectedFiles.isNotEmpty ||
                                    selectedFiles.isEmpty)) {
                              log("index of idEmp: ${idEmpIndex + 1}");
                              log("index of empAuth: ${empAuthIndex + 4}");
                              log("index of idDoc: ${idDocIndex + 6}");
                              log(attachmentformcontroller
                                  .expiredobController2.text);
                              if (selectedFiles.isNotEmpty) {
                                selectedFiles.forEach((key, file) {
                                  if (file != null) {
                                    log("Selected file for $key: ${file.path}");
                                  } else {
                                    log("No file selected for $key");
                                  }
                                });
                              } else {
                                Utils.showInfo(
                                    'Select at least one file to proceede next.');
                              }
                            }
                          }
                        },
                        child: const Text('Save'),
                      ),
                    ),
                  ),
                ],
              ),
            )),
        SizedBox(height: context.screenHeight * 0.02),
        const Text('Employee Emergency Contact Information',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
        SizedBox(height: context.screenHeight * 0.02),
        Form(
            key: formKey3,
            child: Column(
              children: [
                CustomTextField(
                    inputFormatters: [CapitalizeFirstLetterFormatter()],
                    hasdropDownButton: false,
                    text: 'Name:',
                    hintText: 'Name',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Name is required';
                      }
                      return null;
                    },
                    controller: attachmentformcontroller.nameController),
                SizedBox(height: context.screenHeight * 0.01),
                CustomTextField(
                    hasdropDownButton: false,
                    text: 'Phone:',
                    hintText: 'Phone',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Phone is required';
                      }
                      return null;
                    },
                    controller: attachmentformcontroller.phoneController),
                SizedBox(height: context.screenHeight * 0.01),
                CustomTextField(
                    inputFormatters: [CapitalizeFirstLetterFormatter()],
                    hasdropDownButton: false,
                    text: 'Relationship:',
                    hintText: 'Relationship',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Relationship is required';
                      }
                      return null;
                    },
                    controller: attachmentformcontroller.relationController),
                SizedBox(height: context.screenHeight * 0.01),
                CustomTextField(
                    inputFormatters: [CapitalizeFirstLetterFormatter()],
                    onChanged: (value) {
                      googleAddressControler.fetchPlaces(value.toString());
                      attachmentformcontroller.addressController.text.isEmpty
                          ? googleAddressControler.fetchedPlaces.clear()
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
                    controller: attachmentformcontroller.addressController),
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
                          attachmentformcontroller.addressController.text =
                              googleAddressControler.fetchedPlaces[index]
                                  .toString();
                          googleAddressControler.fetchedPlaces.clear();
                        },
                        title:
                            Text(googleAddressControler.fetchedPlaces[index]),
                      );
                    },
                  );
                }),
                SizedBox(height: context.screenHeight * 0.02),
                Center(
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        if (formKey3.currentState?.validate() ?? false) {
                          log(attachmentformcontroller.nameController.text);
                          log(attachmentformcontroller.phoneController.text);
                          log(attachmentformcontroller.relationController.text);
                          log(attachmentformcontroller.addressController.text);
                        }
                      },
                      child: const Text('Submit'),
                    ),
                  ),
                ),
              ],
            ))
      ],
    );
  }
}
