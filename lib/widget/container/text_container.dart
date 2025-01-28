import 'package:flutter/material.dart';

import '../../resources/constants/color.dart';

class TextContainer extends StatelessWidget {
  const TextContainer(
      {required this.text,
      super.key,
      this.textColor = AppColors.textSecondary,
      required this.containerColor,
      this.fontSize = 14,
      this.fontWeight = FontWeight.normal,
      this.border,
      this.verticalPadding = 4,
      this.radius = 5,
      this.width,
      this.onTap});

  final String text;
  final Color textColor;
  final Color containerColor;
  final double fontSize;
  final FontWeight fontWeight;
  final double verticalPadding;
  final VoidCallback? onTap;
  final Border? border;
  final double radius;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        padding: EdgeInsets.symmetric(vertical: verticalPadding, horizontal: 8),
        decoration: BoxDecoration(
            color: containerColor,
            border: border,
            borderRadius: BorderRadius.all(Radius.circular(radius))),
        child: Text(
          text ?? '',
          style: TextStyle(
              color: textColor, fontWeight: fontWeight, fontSize: fontSize),
        ),
      ),
    );
  }
}
