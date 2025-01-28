import 'package:flutter/material.dart';
import 'package:isentcare/modals/todayshift_modal.dart';
import 'package:isentcare/resources/helper_functions.dart';

import '../../resources/constants/color.dart';

class TodayShiftContainer extends StatelessWidget {
  const TodayShiftContainer({
    super.key,
    required this.shift,
    required this.onStartShift,
    required this.onBreakShift,
    required this.onEndShift,
    required this.onCompleteShift,
    required this.index,
  });

  final TodayShiftModel shift;
  final int index;
  final VoidCallback onStartShift;
  final VoidCallback onBreakShift;
  final VoidCallback onEndShift;
  final VoidCallback onCompleteShift;
  @override
  Widget build(BuildContext context) {
    final shiftData = shift.results[index];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2.0),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(10)),
        child: Padding(
            padding: const EdgeInsets.all(16.0),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      shiftData.job.facility ?? '',
                      overflow: TextOverflow.clip,
                      maxLines: 1,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Icon(Icons.calendar_today,
                      size: 16, color: AppColors.iconColor),
                  const SizedBox(width: 4),
                  Text(
                    HelperUtil.formatDate(
                        shiftData.job.startDate.toString() ?? ''),
                    style: const TextStyle(fontSize: 14),
                  ),
                  const SizedBox(width: 10),
                  const Icon(Icons.access_time,
                      size: 16, color: AppColors.iconColor),
                  const SizedBox(width: 4),
                  Text(
                    shiftData.job.timing == 'Morning'
                        ? "7AM-3PM"
                        : shiftData.job.timing == "Evening"
                            ? "3 PM-11PM"
                            : "11PM-7AM",
                    style: const TextStyle(fontSize: 14),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    shiftData.job.billRate.toString() ?? '',
                    style: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              // Render buttons based on conditions
              const SizedBox(height: 10),
              // Render buttons based on conditions
              Column(
                children: [
                  if (shiftData.punchOut != null)
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: onCompleteShift,
                        child: const Text("Completed"),
                      ),
                    )
                  else if (shiftData.shiftId == 0)
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: onStartShift,
                        child: const Text("Start Shift"),
                      ),
                    )
                  else if (shiftData.shiftId != 0 && shiftData.noBreak == true)
                    Column(
                      spacing: 10,
                      children: [
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: onBreakShift,
                            child: const Text("No Break"),
                          ),
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: onEndShift,
                            child: const Text("End Shift"),
                          ),
                        ),
                      ],
                    )
                  else if (shiftData.shiftId != 0)
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: onEndShift,
                        child: const Text("End Shift"),
                      ),
                    ),
                ],
              ),
            ])),
      ),
    );
  }
}
