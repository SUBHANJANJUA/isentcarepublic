import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:isentcare/feature/auth/controller/media_controller.dart';

class UploadCard extends StatelessWidget {
  final String title;
  final String cardKey;
  final Function? setvalue;

  final SelectMediaController mediacontroller =
      Get.put(SelectMediaController());

  UploadCard({
    super.key,
    required this.title,
    required this.cardKey,
    this.setvalue,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: () async {
            await mediacontroller.pickFile(cardKey);
            if (setvalue != null) {
              setvalue!();
            }
          },
          child: Obx(() {
            final selectedFile = mediacontroller.getSelectedFile(cardKey);
            return Container(
              height: 113,
              width: context.width * 0.5,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black.withOpacity(0.1),
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: selectedFile == null
                  ? Center(
                      child: Text(
                        "Tap to upload",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black.withOpacity(0.6),
                        ),
                      ),
                    )
                  : mediacontroller.isImageFile(selectedFile.path)
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.file(
                            selectedFile,
                            fit: BoxFit.cover,
                          ),
                        )
                      : const Center(
                          child: Icon(
                            Icons.picture_as_pdf,
                            size: 50,
                            color: Colors.red,
                          ),
                        ),
            );
          }),
        ),
        const SizedBox(
          height: 5,
        ),
      ],
    );
  }
}
