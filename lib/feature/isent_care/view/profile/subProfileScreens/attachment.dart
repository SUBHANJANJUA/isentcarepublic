import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:isentcare/modals/attachment_modal.dart';
import 'package:isentcare/models/attachment_viewController.dart';
import 'package:isentcare/network_data/response/status.dart';
import 'package:isentcare/resources/constants/app_strings.dart';
import 'package:isentcare/widgets/No_Data_found.dart';
import 'package:isentcare/widgets/attachment_card.dart';

class AttachmentScreen extends StatelessWidget {
  AttachmentScreen({super.key});

  final AttachmentController attachmentController =
      Get.put(AttachmentController());

  @override
  Widget build(BuildContext context) {
    attachmentController.fetchAttachments();
    return Scaffold(
      appBar: AppBar(title: const Text('Attachment')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Obx(() {
          if (attachmentController.attachmentDetails.value.status ==
              Status.LOADING) {
            return const Center(child: CircularProgressIndicator());
          } else if (attachmentController.attachmentDetails.value.status ==
              Status.ERROR) {
            return NoInternet(
                text: attachmentController.attachmentDetails.value.message ??
                    AppStrings.somethingWentWrong);
          } else if (attachmentController.attachmentDetails.value.status ==
              Status.COMPLETED) {
            List<AttachmentModel> attachments =
                attachmentController.attachmentDetails.value.data ?? [];
            return ListView.builder(
              itemCount: attachments.length,
              itemBuilder: (context, index) {
                final attachment = attachments[index];
                return AttachmentCard(attachment: attachment);
              },
            );
          } else {
            return const Center(child: Text('No attachments found.'));
          }
        }),
      ),
    );
  }
}
