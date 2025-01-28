import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:isentcare/modals/attachment_modal.dart';
import 'package:isentcare/models/attachment_viewController.dart';
import 'package:isentcare/resources/constants/app_sizer.dart';
import 'package:isentcare/resources/constants/color.dart';
import 'package:isentcare/widgets/network_image.dart';
import 'package:isentcare/widgets/text_field.dart';
import 'package:isentcare/widgets/update_close_button.dart';
import 'package:path/path.dart' as p;

import '../../../../../resources/capitalize_first_letter_formatter.dart';
import '../../../../../resources/helper_functions.dart';
import '../../../../../widgets/datepicker_field.dart';

class Edit_Attachment extends StatelessWidget {
  Edit_Attachment({super.key, required this.attachmentData});

  final AttachmentModel attachmentData;
  final AttachmentController attachmentController =
      Get.put(AttachmentController());
  // Controllers initialized with data from AttachmentModel
  final TextEditingController typeController = TextEditingController();
  final TextEditingController expiryDateController = TextEditingController();

  var isExpire1 = true.obs;
  void expireDate1() {
    String pickedDate = expiryDateController.text;
    if (pickedDate.isEmpty) {
      isExpire1.value = false;
    } else {
      isExpire1.value = isFutureDate(pickedDate);
    }
  }

  bool isFutureDate(String pickedDate) {
    try {
      DateTime selectedDate = DateTime.parse(pickedDate);
      DateTime today = DateTime.now();

      return selectedDate.isAfter(today);
    } catch (e) {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    // Set initial values for controllers
    typeController.text = attachmentData.type;
    expiryDateController.text =
        HelperUtil.formatDate(attachmentData.expiryDate.toString());

    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Obx(
              () => attachmentController.currentFilePath.value == ""
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        if (attachmentData.file.contains(".jpg") ||
                            attachmentData.file.contains(".jpeg") ||
                            attachmentData.file.contains(".png") ||
                            attachmentData.file.contains(".gif"))
                          Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.grey, width: 1),
                            ),
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: DisplayNetworkImage(
                                  image: attachmentData.file,
                                  width: 100,
                                  height: 100,
                                  isprofleImage: false,
                                )),
                          )
                        else
                          Column(
                            children: [
                              Container(
                                width: 100,
                                height: 100,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  border:
                                      Border.all(color: Colors.grey, width: 1),
                                ),
                                child: const Center(
                                    child: Icon(
                                  Icons.file_copy_outlined,
                                  color: AppColors.primary,
                                  size: 40,
                                )),
                              ),
                              Text(
                                attachmentController.currentFilePath
                                        .contains(".pdf")
                                    ? p.basename(attachmentController
                                        .currentFilePath.value)
                                    : (attachmentController.currentFilePath
                                                .contains(".jpg") ||
                                            attachmentController.currentFilePath
                                                .contains(".jpeg") ||
                                            attachmentController.currentFilePath
                                                .contains(".png") ||
                                            attachmentController.currentFilePath
                                                .contains(".gif"))
                                        ? ""
                                        : "Unknown File",
                                style: const TextStyle(
                                    fontSize: 14, color: Colors.black),
                              ),
                            ],
                          ),
                        const SizedBox(
                          width: 5,
                        ),
                      ],
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        if (attachmentController.currentFilePath
                                .contains(".jpg") ||
                            attachmentController.currentFilePath
                                .contains(".jpeg") ||
                            attachmentController.currentFilePath
                                .contains(".png") ||
                            attachmentController.currentFilePath
                                .contains(".gif"))
                          Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.grey, width: 1),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.file(
                                File(
                                    attachmentController.currentFilePath.value),
                                fit: BoxFit.cover,
                              ),
                            ),
                          )
                        else
                          Column(
                            children: [
                              Container(
                                width: 100,
                                height: 100,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  border:
                                      Border.all(color: Colors.grey, width: 1),
                                ),
                                child: const Center(
                                    child: Icon(
                                  Icons.file_copy_outlined,
                                  color: AppColors.primary,
                                  size: 40,
                                )),
                              ),
                              Text(
                                attachmentController.currentFilePath
                                        .contains(".pdf")
                                    ? p.basename(attachmentController
                                        .currentFilePath.value)
                                    : "Unknown File",
                                style: const TextStyle(
                                    fontSize: 14, color: Colors.black),
                              ),
                            ],
                          ),
                        const SizedBox(
                          width: 5,
                        ),
                      ],
                    ),
            ),
            SizedBox(height: context.screenHeight * 0.01),
            GestureDetector(
              onTap: attachmentController.pickFile,
              child: const Text(
                "Edit attachment",
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Colors.blue),
              ),
            ),
            SizedBox(height: context.screenHeight * 0.01),
            CustomTextField(
              inputFormatters: [CapitalizeFirstLetterFormatter()],
              text: 'Type',
              hasdropDownButton: false,
              controller: typeController,
              validator: (value) => value!.isEmpty ? 'Type is required' : null,
            ),
            SizedBox(height: context.screenHeight * 0.01),
            DatePickerField(
              text: 'Expiry Date:',
              controller: expiryDateController,
              validationMessage: 'Expaire Date is required',
            ),
            Obx(() {
              return isExpire1.value
                  ? const SizedBox.shrink()
                  : const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Please enter valid Expiry Date",
                        style: TextStyle(color: AppColors.error),
                      ),
                    );
            }),
            SizedBox(height: context.screenHeight * 0.01),
            ResuableButtons(onTap: () {
              expireDate1();
              if (isExpire1.value) {
                log('Updated Type: ${typeController.text}');
                log('Updated Expiry Date: ${expiryDateController.text}');
                log('Updated File: ${p.basename(attachmentController.currentFilePath.value)}');

                attachmentController.resetFilepath();
                Get.back();
              }
            }),
          ],
        ),
      ),
    );
  }
}
