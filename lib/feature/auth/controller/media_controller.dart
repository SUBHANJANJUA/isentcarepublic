import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';

class SelectMediaController extends GetxController {
  final RxMap<String, File?> selectedFiles = <String, File?>{}.obs;
  RxBool otherAttachments = false.obs;
  void setOtherAttachment() {
    otherAttachments.value = true;
  }

  RxBool cprAttachments = false.obs;
  void setCprAttachment() {
    cprAttachments.value = true;
  }

  Future<void> pickFile(String cardKey) async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowMultiple: false, // Allow selecting only one file at a time
      );

      if (result != null) {
        final file = File(result.files.single.path!);
        selectedFiles[cardKey] = file;
      } else {
        selectedFiles[cardKey] = null; // No file was selected
      }
    } catch (e) {
      print("Error picking file: $e");
    }
  }

  File? getSelectedFile(String cardKey) {
    return selectedFiles[cardKey];
  }

  bool isImageFile(String path) {
    final extensions = ['jpg', 'jpeg', 'png', 'gif'];
    final fileExtension = path.split('.').last.toLowerCase();
    return extensions.contains(fileExtension);
  }
}
