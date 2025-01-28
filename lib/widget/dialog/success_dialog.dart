import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:isentcare/resources/constants/app_strings.dart';

class SuccessDialog extends StatelessWidget {
  final String dilogdescription;
  const SuccessDialog({super.key, required this.dilogdescription});
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                    onTap: () => Navigator.of(context).pop(),
                    child: SvgPicture.asset('${AppStrings.imagePath}cross.svg'))
              ],
            ),
            SvgPicture.asset('${AppStrings.imagePath}Successmark.svg'),
            const SizedBox(height: 10),
            Text(
              dilogdescription,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
