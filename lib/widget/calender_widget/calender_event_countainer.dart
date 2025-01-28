import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:isentcare/feature/isent_care/controller/calenderController/calender_controller.dart';

class CalenderEventContainer extends StatelessWidget {
  CalenderEventContainer({
    super.key,
    required this.facility,
    required this.bill_rate,
    required this.timing,
    required this.start_date,
  });
  final String facility;
  final String bill_rate;
  final String timing;
  final String start_date;

  final CalenderController calendercontroller = Get.put(CalenderController());

  @override
  Widget build(BuildContext context) {
    return
        // ignore: unrelated_type_equality_checks
        Obx(() => calendercontroller.ownDate == start_date
            ? Column(
                children: [
                  (timing == "Morning" || timing == "morning")
                      ? CalenderEventshow(
                          facility: facility,
                          bill_rate: bill_rate,
                          timing: timing)
                      : const SizedBox.shrink(),
                  (timing == "Evening" || timing == "evening")
                      ? CalenderEventshow(
                          facility: facility,
                          bill_rate: bill_rate,
                          timing: timing)
                      : const SizedBox.shrink(),
                  (timing == "Night" || timing == "night")
                      ? CalenderEventshow(
                          facility: facility,
                          bill_rate: bill_rate,
                          timing: timing)
                      : const SizedBox.shrink(),
                ],
              )
            : SizedBox.shrink());
  }
}

class CalenderEventshow extends StatelessWidget {
  CalenderEventshow({
    super.key,
    required this.facility,
    required this.bill_rate,
    required this.timing,
  });
  final String facility;
  final String bill_rate;
  final String timing;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
              color: Colors.blue.shade50,
              borderRadius: BorderRadius.circular(8)),
          child: Padding(
            padding: EdgeInsets.all(12.0),
            child: Column(
              spacing: 5,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        facility,
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 16),
                      ),
                    ),
                    Text(
                      bill_rate,
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    (timing == "Morning" || timing == "morning")
                        ? Text("07:00 AM to 03:00 PM")
                        : (timing == "Evening" || timing == "evening")
                            ? Text("03:00 PM to 11:00 PM")
                            : (timing == "Night" || timing == "night")
                                ? Text("11:00 PM to 07:00 AM")
                                : Text('Invalid time'),
                    //Text(timing),
                  ],
                )
              ],
            ),
          )),
    );
  }
}
