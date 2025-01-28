import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:isentcare/models/perdiem_vieewController.dart';
import 'package:isentcare/models/shift_viewController.dart';
import 'package:isentcare/models/todayshift_viewController.dart';
import 'package:isentcare/network_data/response/status.dart';
import 'package:isentcare/resources/constants/app_sizer.dart';
import 'package:isentcare/resources/constants/color.dart';
import 'package:isentcare/resources/helper_functions.dart';
import 'package:isentcare/widget/dialog/confirmation_dialog.dart';
import 'package:isentcare/widgets/todayshift_container.dart';

import '../../../../widget/container/earnings_card_container.dart';
import '../../../../widgets/No_Data_found.dart';
import '../earning/earning_screen.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TodayShiftController todayshift = Get.put(TodayShiftController());

  final PerdiemController perdiem = Get.put(PerdiemController());

  final ShiftController shiftController = Get.put(ShiftController());
  
  @override
  void initState() {
    perdiem.fetchCompleted();
    perdiem.fetchperdiem();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 150,
                  padding: const EdgeInsets.all(20.0),
                  decoration: const BoxDecoration(
                      color: AppColors.backgroundContainer,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(50),
                          bottomRight: Radius.circular(50))),
                  child: const Column(
                    children: [
                      Text(
                        "Welcome Back...!",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: AppColors.textPrimary),
                      ),
                      SizedBox(height: 10),
                      Text(
                        "Your trusted partner in healthcare staffing solutions.",
                        style: TextStyle(
                            fontSize: 16, color: AppColors.textPrimary),
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                ),
                SizedBox(height: context.screenHeight * 0.05),
                const Text(
                  "Today's Shifts",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                SizedBox(height: context.screenHeight * 0.03),
                Obx(() {
                  if (todayshift.todayshiftDetails.value.status ==
                      Status.LOADING) {
                    return const Center(
                        child: const CircularProgressIndicator());
                  } else if (todayshift.todayshiftDetails.value.status ==
                      Status.ERROR) {
                    return NoInternet(
                        text:
                            'Error: ${todayshift.todayshiftDetails.value.message}');
                  } else if (todayshift
                          .todayshiftDetails.value.data?.results.isEmpty ??
                      true) {
                    return NoDataFound(
                      text: 'No shifts available for today',
                    );
                  }

                  final todayshiftData =
                      todayshift.todayshiftDetails.value.data!;
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10)),
                          color: Colors.lightBlue.withOpacity(0.08)),
                      child: ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: todayshiftData.results.length,
                          itemBuilder: (context, index) {
                            final shift = todayshiftData;
                            final result = todayshiftData.results[index];

                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TodayShiftContainer(
                                shift: shift,
                                index: index,
                                onBreakShift: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) => ConfirmationDialog(
                                      onTap: () {
                                        todayshift.breakShift(result.shiftId!);
                                      },
                                      dilogdescription:
                                          "Are you sure you want to Break the Shift?",
                                    ),
                                  );
                                },
                                onCompleteShift: () {},
                                onEndShift: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) => ConfirmationDialog(
                                      onTap: () {
                                        todayshift.punchOut(result.shiftId!);
                                      },
                                      dilogdescription:
                                          "Are you sure you want to End the Shift?",
                                    ),
                                  );
                                },
                                onStartShift: () async {
                                  Position position =
                                      await HelperUtil.getLocation();
                                  showDialog(
                                    context: context,
                                    builder: (context) => ConfirmationDialog(
                                      onTap: () {
                                        final ShiftData = {
                                          "application": result.id,
                                          "latitude": position.latitude,
                                          "longitude": position.longitude
                                        };
                                        log(ShiftData.toString());
                                        shiftController.startShift(
                                            ShiftData, context);
                                      },
                                      dilogdescription:
                                          "Are you sure you want to start the Shift?",
                                    ),
                                  );
                                },
                              ),
                            );
                          }),
                    ),
                  );
                }),
                SizedBox(height: context.screenHeight * 0.01),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      EarningCardContainer(
                        onTap: () => Get.to(() => const EarningScreen()),
                      ),
                      SizedBox(height: context.screenHeight * 0.03),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Obx(
                              () => ShiftContainer(
                                title: "Available Shifts",
                                subtitle:
                                    perdiem.perdiemDetails.value.data?.count ??
                                        0,
                              ),
                            ),
                            Obx(
                              () => ShiftContainer(
                                  title: "Completed Shifts",
                                  subtitle: perdiem
                                          .completedDetails.value.data?.count ??
                                      0),
                            ),
                          ])
                    ],
                  ),
                )
              ])),
    );
  }
}

class ShiftContainer extends StatelessWidget {
  const ShiftContainer({
    required this.title,
    required this.subtitle,
    this.onTap,
    super.key,
  });

  final String title;
  final int subtitle;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.4),
                spreadRadius: 1,
                blurRadius: 3,
                offset: const Offset(0, 2),
              )
            ]),
        child: Column(children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
          Text(
            subtitle.toString(),
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          )
        ]),
      ),
    );
  }
}
