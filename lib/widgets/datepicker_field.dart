import 'package:flutter/material.dart';
import 'package:isentcare/resources/constants/app_sizer.dart';
import 'package:isentcare/resources/constants/color.dart';
import 'package:isentcare/resources/helper_functions.dart';

class DatePickerField extends StatelessWidget {
  final TextEditingController controller;
  final String text;
  final bool dob;
  final String validationMessage;

  const DatePickerField({
    super.key,
    required this.controller,
    required this.text,
    required this.validationMessage,
    this.dob = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          text,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
        ),
        SizedBox(
          height: context.screenHeight * 0.005,
        ),
        TextFormField(
          controller: controller,
          readOnly: true,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return validationMessage;
            }
            return null;
          },
          onTap: () async {
            DateTime? pickedDate = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(1900),
              lastDate: DateTime(2100),
            );
            if (pickedDate != null) {
              controller.text = HelperUtil.formatDate(pickedDate.toString());
            }
          },
          decoration: InputDecoration(
            fillColor: Colors.white,
            hintText: 'YYYY-MM-DD',
            hintStyle:
                const TextStyle(fontSize: 12, fontWeight: FontWeight.w700),
            filled: true,
            errorBorder: const OutlineInputBorder().copyWith(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(width: 1, color: Colors.grey),
            ),
            focusedErrorBorder: const OutlineInputBorder().copyWith(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(width: 1, color: Colors.grey),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
            suffixIcon: const Icon(
              Icons.calendar_month,
              color: AppColors.iconColor,
            ),
          ),
        ),
      ],
    );
  }
}
