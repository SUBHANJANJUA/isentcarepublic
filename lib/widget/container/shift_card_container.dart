import 'package:flutter/material.dart';

import '../../resources/constants/color.dart';

class ShiftCardContainer extends StatelessWidget {
  const ShiftCardContainer({
    super.key,
    required this.facility,
    required this.date,
    required this.time,
    required this.price,
    required this.id,
    required this.onTap,
    required this.showButton,
  });

  final String facility;
  final String date;
  final String time;
  final String price;
  final int id;
  final VoidCallback onTap;
  final bool showButton;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Container(
        margin: const EdgeInsets.only(top: 10),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                facility,
                overflow: TextOverflow.clip,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.calendar_today,
                          size: 16, color: AppColors.iconColor),
                      const SizedBox(width: 4),
                      Text(
                        date,
                        style: const TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Icon(Icons.access_time,
                          size: 16, color: AppColors.iconColor),
                      const SizedBox(width: 4),
                      Text(
                        time == 'Morning'
                            ? "7AM-3PM"
                            : time == "Evening"
                                ? "3PM-11PM"
                                : "11PM-7AM",
                        style: const TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                  Text(
                    price,
                    style: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              showButton
                  ? SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: onTap,
                        child: const Text('Pick'),
                      ),
                    )
                  : const SizedBox.shrink(),
            ],
          ),
        ),
      ),
    );
  }
}
