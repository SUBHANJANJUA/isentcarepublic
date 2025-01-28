import 'package:flutter/material.dart';
import 'package:isentcare/resources/constants/color.dart';

class TimeSheetCard extends StatelessWidget {
  final String facilityName;
  final String position;
  final String hours;
  final String payRate;
  final String shiftDate;
  final String startTime;
  final String endTime;
  final String shift;

  const TimeSheetCard({
    super.key,
    required this.facilityName,
    required this.position,
    required this.hours,
    required this.payRate,
    required this.shiftDate,
    required this.startTime,
    required this.endTime,
    required this.shift,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(width: 0.5),
      ),
      child: Column(
        children: [
          const ResuableConatiner(
            value1: 'Facility Name',
            value2: 'Position',
            value3: 'No. of Hours',
          ),
          ResuableRow(value1: facilityName, value2: position, value3: hours),
          const ResuableConatiner(
            value1: 'Pay Rate',
            value2: 'Shift Date',
            value3: 'Start Time',
          ),
          ResuableRow(value1: payRate, value2: shiftDate, value3: startTime),
          const ResuableConatiner(
            value1: 'End Time',
            value2: 'Shift',
            value3: '',
          ),
          ResuableRow(
            value1: endTime,
            value2: shift == 'Morning'
                ? "7AM-3PM"
                : shift == "Evening"
                    ? "3 PM-11PM"
                    : "11PM-7AM",
            value3: '',
          ),
        ],
      ),
    );
  }
}

class ResuableRow extends StatelessWidget {
  const ResuableRow({
    super.key,
    required this.value1,
    required this.value2,
    required this.value3,
  });

  final String value1;
  final String value2;
  final String value3;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              value1,
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
            ),
          ),
          Expanded(
            child: Text(
              value2,
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: Text(
              value3,
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }
}

class ResuableConatiner extends StatelessWidget {
  const ResuableConatiner({
    super.key,
    required this.value1,
    required this.value2,
    required this.value3,
  });
  final String value1;
  final String value2;
  final String value3;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.backgroundContainer,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              value1,
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: AppColors.textPrimary),
            ),
          ),
          Expanded(
            child: Text(
              value2,
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: AppColors.textPrimary),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: Text(
              value3,
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: AppColors.textPrimary),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }
}
