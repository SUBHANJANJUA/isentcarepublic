import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:isentcare/resources/constants/app_strings.dart';
import 'package:isentcare/resources/constants/color.dart';

import '../signature/signature_pad.dart';

class SignatureDialog extends StatelessWidget {
  final String dilogdescription;
  const SignatureDialog(
      {super.key, required this.dilogdescription, required this.onTap});
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15)),
                color: AppColors.primary,
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Signature",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    InkWell(
                        onTap: () => Get.back(),
                        child: SvgPicture.asset(
                          '${AppStrings.imagePath}cross.svg',
                          colorFilter: const ColorFilter.mode(
                              Colors.white, BlendMode.srcIn),
                        ))
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.0),
              child: SignaturePad(
                width: 300,
                height: 300,
                penColor: Colors.black,
                backgroundColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
