import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../resources/constants/color.dart';

class CustomeTextFormField extends StatelessWidget {
  const CustomeTextFormField(
      {super.key,
      this.hintText = '',
      this.maxLines = 1,
      this.onTap,
      this.readOnly = false,
      this.controller,
      this.suffixIcon,
      this.inputFormatters,
      this.validator});

  final String hintText;
  final int maxLines;
  final VoidCallback? onTap;
  final bool readOnly;
  final TextEditingController? controller;
  final IconData? suffixIcon;
  final String? Function(String?)? validator;
  final List<TextInputFormatter>? inputFormatters;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        inputFormatters: inputFormatters ?? [],
        validator: validator,
        controller: controller,
        readOnly: readOnly,
        onTap: onTap,
        maxLines: maxLines,
        decoration: InputDecoration(
          fillColor: Colors.white,
          filled: true,
          hintText: hintText,
          suffixIcon: Icon(
            suffixIcon,
            color: AppColors.iconColor,
          ),
        ));
  }
}
