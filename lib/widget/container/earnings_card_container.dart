import 'package:flutter/material.dart';

import '../../resources/constants/color.dart';

class EarningCardContainer extends StatelessWidget {
  const EarningCardContainer({
    this.onTap,
    super.key,
  });

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
            border: Border.all(color: AppColors.primary),
            color: AppColors.backgroundContainer,
            borderRadius: BorderRadius.circular(10)),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(6.0),
              decoration: BoxDecoration(
                color: AppColors.grayBackgroundContainer,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(
                Icons.business_center_rounded,
                color: AppColors.primary,
                size: 40,
              ),
            ),
            const SizedBox(width: 10),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Total Earnings",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: AppColors.primary),
                ),
                Text(
                  "\$5.1k",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: AppColors.primary),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
