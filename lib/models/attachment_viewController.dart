import 'dart:developer';
import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';
import 'package:isentcare/modals/attachment_modal.dart';
import 'package:isentcare/repo/attachment_repo.dart';
import 'package:isentcare/resources/constants/app_strings.dart';

import '../network_data/response/api_response.dart';

class AttachmentController extends GetxController {
  // Reactive variable to hold the current file path
  var currentFilePath = ''.obs;
  void resetFilepath() {
    currentFilePath.value = "";
  }

  // Open file picker to select a new file
  void pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'jpeg', 'png', 'gif', 'pdf'],
    );

    if (result != null) {
      currentFilePath.value = result.files.single.path!;
    } else {
      log("file not selected");
    }
  }

  final _myRepo = AttachmentRepository();
  var attachmentDetails = ApiResponse<List<AttachmentModel>>.loading().obs;

  setAttachmentDetails(ApiResponse<List<AttachmentModel>> response) {
    attachmentDetails.value = response;
  }

  Future<void> fetchAttachments() async {
    setAttachmentDetails(ApiResponse.loading());
    try {
      List<AttachmentModel> attachments = await _myRepo.getAttachments();
      if (attachments.isNotEmpty) {
        setAttachmentDetails(ApiResponse.completed(attachments));
      } else {
        setAttachmentDetails(ApiResponse.error(AppStrings.somethingWentWrong));
      }
    } catch (e) {
      log(e.toString());
      setAttachmentDetails(ApiResponse.error(e.toString()));
    }
  }
}
