import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ButtonContainer extends StatelessWidget {
  const ButtonContainer({
    super.key,
    required this.onTap,
    required this.iconString,
  });

  final VoidCallback onTap;
  final String iconString;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 40,
        width: 40,
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
    
          border: Border.all(
            color: Colors.grey.shade300,
            width: 0.8,
          ),
        ),
        child: SvgPicture.asset(
          iconString,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}