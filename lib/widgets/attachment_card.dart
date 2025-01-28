import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:isentcare/feature/isent_care/view/profile/subProfileScreens/edit_attachment.dart';
import 'package:isentcare/modals/attachment_modal.dart';
import 'package:isentcare/resources/constants/app_strings.dart';
import 'package:isentcare/resources/constants/color.dart';
import 'package:isentcare/resources/helper_functions.dart';
import 'package:isentcare/widget/dialog/confirmation_dialog.dart';
import 'package:isentcare/widget/heading/text_field_heading.dart';
import 'package:isentcare/widgets/button_container.dart';
import 'package:isentcare/widgets/education_card.dart';
import 'package:isentcare/widgets/network_image.dart';
import 'package:isentcare/widgets/update_close_button.dart';

class AttachmentCard extends StatelessWidget {
  final AttachmentModel attachment;

  const AttachmentCard({super.key, required this.attachment});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.withOpacity(0.50)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    if (attachment.file.contains(".jpg") ||
                        attachment.file.contains(".jpeg") ||
                        attachment.file.contains(".png") ||
                        attachment.file.contains(".gif"))
                      Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.grey, width: 1),
                          ),
                          child: DisplayNetworkImage(
                            image: attachment.file,
                            width: 100,
                            height: 100,
                            isprofleImage: false,
                          ))
                    else
                      Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.grey, width: 1),
                        ),
                        child: const Center(
                            child: Icon(
                          Icons.file_copy_outlined,
                          color: AppColors.primary,
                          size: 40,
                        )),
                      ),
                    const SizedBox(
                      width: 5,
                    ),
                  ],
                ),
                Row(
                  children: [
                    ButtonContainer(
                      onTap: () {
                        showDialog(
                          context: Get.context!,
                          builder: (context) => Edit_Attachment(
                            attachmentData: attachment,
                          ),
                        );
                      },
                      iconString: '${AppStrings.imagePath}editicon.svg',
                    ),
                    const SizedBox(width: 10),
                    ButtonContainer(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) => ConfirmationDialog(
                            dilogdescription:
                                "Are you sure you want to delete?",
                            onTap: () {},
                          ),
                        );
                      },
                      iconString: '${AppStrings.imagePath}deleteicon.svg',
                    ),
                  ],
                )
              ],
            ),
            const SizedBox(height: 10),
            attachment.file.contains(".pdf")
                ? const Text(
                    "name.pdf",
                    style: TextStyle(fontSize: 14, color: Colors.black),
                  )
                : (attachment.file.contains(".jpg") ||
                        attachment.file.contains(".jpeg") ||
                        attachment.file.contains(".png") ||
                        attachment.file.contains(".gif"))
                    ? const SizedBox.shrink()
                    : const Text("Unknown File",
                        style: TextStyle(fontSize: 14, color: Colors.black)),
            const SizedBox(height: 10),
            Table(
              columnWidths: const {
                0: FlexColumnWidth(1.5),
                1: FlexColumnWidth(2),
              },
              children: [
                TableRow(children: [
                  const LabelText(
                    label: 'Type',
                  ),
                  ValueText(
                    value: attachment.type,
                  ),
                ]),
                TableRow(children: [
                  const LabelText(
                    label: 'Expiry Date',
                  ),
                  ValueText(
                    value:
                        HelperUtil.formatDate(attachment.expiryDate.toString()),
                  ),
                ]),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
