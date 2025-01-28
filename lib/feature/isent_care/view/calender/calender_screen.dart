import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:isentcare/feature/isent_care/controller/calenderController/calender_controller.dart';
import 'package:isentcare/modals/Calender_Model.dart';

import 'package:isentcare/widget/calender_widget/calender_event_countainer.dart';
import 'package:isentcare/widgets/No_Data_found.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../../network_data/response/status.dart';

class CalenderScreen extends StatefulWidget {
  const CalenderScreen({super.key});

  @override
  State<CalenderScreen> createState() => _CalenderScreenState();
}

class _CalenderScreenState extends State<CalenderScreen> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  final CalenderController calendercontroller = Get.put(CalenderController());
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    calendercontroller.fetchCalender();
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Card(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Calendar',
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
                    ),
                    TableCalendar(
                      firstDay: DateTime.utc(2000, 1, 1),
                      lastDay: DateTime.utc(2100, 12, 31),
                      focusedDay: _focusedDay,
                      selectedDayPredicate: (day) {
                        return isSameDay(_selectedDay, day);
                      },
                      onDaySelected: (selectedDay, focusedDay) {
                        setState(() {
                          _selectedDay = selectedDay;
                          _focusedDay = focusedDay;
                        });
                        calendercontroller.storeDate(
                            _selectedDay!.toIso8601String().split('T')[0]);
                      },
                      calendarStyle: const CalendarStyle(
                        selectedDecoration: BoxDecoration(
                          color: Colors.blue,
                          shape: BoxShape.circle,
                        ),
                        todayDecoration: BoxDecoration(
                          color: Colors.orange,
                          shape: BoxShape.circle,
                        ),
                        markerDecoration: BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                      ),
                      headerStyle: const HeaderStyle(
                        formatButtonVisible: false,
                        titleCentered: true,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Obx(() {
              final response = calendercontroller.CalenderDetails.value;

              if (response.status == Status.LOADING) {
                return const Center(child: CircularProgressIndicator());
              } else if (response.status == Status.COMPLETED) {
                final List<CalenderModel> calenderList = response.data ?? [];

                log("hello 112233 ${calenderList.map((e) => 'Title: ${e.job?.timing.toString()}, Date: ${e.job?.timing}').join(', ')}");

                final filteredList = calenderList
                    .where((item) =>
                        calendercontroller.ownDate == item.job?.startDate)
                    .toList();

                if (filteredList.isNotEmpty) {
                  // If you found matching items, store them in a new variable
                  var result = filteredList;
                  log("Filtered list: $result");
                  return ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: calenderList.length,
                    itemBuilder: (context, index) {
                      final calender = calenderList[index];
                      return CalenderEventContainer(
                        timing: calender.job?.timing ?? "N/A",
                        start_date: calender.job?.startDate ?? "N/A",
                        facility: calender.job?.facility ?? "N/A",
                        bill_rate: calender.job?.billRate?.toString() ?? "N/A",
                      );
                    },
                  );
                } else {
                  log("The list is empty");
                  return const NoDataFound(text: "Not record found");
                }
              } else {
                return const NoInternet(
                    text:
                        "Error: Error During Communication No Internet Connectios");
              }
            }),
          ],
        ),
      ),
    );
  }
}

extension DateTimeExtensions on DateTime {
  String get monthName {
    const months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December'
    ];
    return months[this.month - 1];
  }
}
