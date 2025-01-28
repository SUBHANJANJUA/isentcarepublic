import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:isentcare/feature/isent_care/controller/profile_controller.dart';
import 'package:isentcare/models/perdiem_vieewController.dart';
import 'package:isentcare/network_data/response/status.dart';
import 'package:isentcare/resources/constants/app_strings.dart';
import 'package:isentcare/widget/container/completed_shift.dart';
import 'package:isentcare/widgets/No_Data_found.dart';

import '../../../../resources/constants/color.dart';
import '../../../../widget/container/icon_button_container.dart';
import '../../../../widget/container/shift_list_container.dart';

class ShiftsScreen extends StatefulWidget {
  const ShiftsScreen({super.key});

  @override
  State<ShiftsScreen> createState() => _ShiftsScreenState();
}

class _ShiftsScreenState extends State<ShiftsScreen>
    with SingleTickerProviderStateMixin {
  final controller = Get.put(ProfileController());

  late TabController tabController = TabController(
      length: 2, vsync: this, initialIndex: controller.tabIndex.value);

  @override
  void dispose() {
    controller.tabIndex.value;
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 70,
          width: double.infinity,
          child: TabBar(
            controller: tabController,
            indicatorColor: AppColors.primary,
            labelColor: AppColors.textPrimary,
            tabs: const [
              Tab(
                child: Text(
                  'Per Diem Shifts',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  softWrap: true,
                  maxLines: 2,
                ),
              ),
              Tab(
                child: Text(
                  'Completed Shifts',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  softWrap: true,
                  maxLines: 2,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: TabBarView(
            controller: tabController,
            children: [
              AvailableShifts(controller: controller),
              CompletedShifts(),
            ],
          ),
        ),
      ],
    );
  }
}

class CompletedShifts extends StatelessWidget {
  CompletedShifts({
    super.key,
  });

  final PerdiemController perdiem = Get.put(PerdiemController());

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Obx(() {
            if (perdiem.completedDetails.value.status == Status.LOADING) {
              return const Center(
                  child: Padding(
                padding: EdgeInsets.all(12.0),
                child: const CircularProgressIndicator(),
              ));
            } else if (perdiem.completedDetails.value.status == Status.ERROR) {
              return Padding(
                padding: const EdgeInsets.only(top: 170.0),
                child: NoInternet(
                    text: 'Error: ${perdiem.completedDetails.value.message}'),
              );
            } else if (perdiem.completedDetails.value.data?.results.isEmpty ??
                true) {
              return const Padding(
                padding: EdgeInsets.only(top: 170.0),
                child: NoDataFound(text: 'No Completed shifts availabe'),
              );
            }

            final completedData = perdiem.completedDetails.value.data!;

            return CompletedShiftContainer(shifts: completedData);
          }),
        ],
      ),
    );
  }
}

class AvailableShifts extends StatelessWidget {
  AvailableShifts({
    super.key,
    required this.controller,
  });

  final ProfileController controller;
  final PerdiemController perdiem = Get.put(PerdiemController());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Row(
              children: [
                Expanded(
                    child: Obx(
                  () => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        child: Text("${controller.miles.value.toInt()} miles"),
                      ),
                      SizedBox(
                        height: 20,
                        child: Slider(
                            activeColor: AppColors.primary,
                            min: 0,
                            max: 100,
                            divisions: 100,
                            value: controller.miles.value,
                            onChanged: (value) {
                              controller.miles.value = value;
                              perdiem.fetchperdiem(range: value);
                                 debugPrint("Slider value: $value");
                            }),
                      ),
                    ],
                  ),
                )),
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            Obx(() {
              if (perdiem.perdiemDetails.value.status == Status.LOADING) {
                return const Center(child: const CircularProgressIndicator());
              } else if (perdiem.perdiemDetails.value.status == Status.ERROR) {
                return Padding(
                  padding: const EdgeInsets.only(top: 120.0),
                  child: NoInternet(
                      text: 'Error: ${perdiem.perdiemDetails.value.message}'),
                );
              } else if (perdiem.perdiemDetails.value.data?.results.isEmpty ??
                  true) {
                return const Padding(
                  padding: EdgeInsets.only(top: 120.0),
                  child: NoDataFound(text: 'No shifts available for today'),
                );
              }

              final perdiemData = perdiem.perdiemDetails.value.data!;

              return ShiftListContainer(perDiemModel: perdiemData);
            }),
          ],
        ),
      ),
    );
  }
}
