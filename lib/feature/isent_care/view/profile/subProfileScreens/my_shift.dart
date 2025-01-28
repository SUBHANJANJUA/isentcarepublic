import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:isentcare/models/shift_viewController.dart';
import 'package:isentcare/network_data/response/status.dart';
import 'package:isentcare/widgets/No_Data_found.dart';
import 'package:isentcare/widgets/shift_card.dart';

class MyShiftScreen extends StatefulWidget {
  MyShiftScreen({super.key});

  @override
  State<MyShiftScreen> createState() => _MyShiftScreenState();
}

class _MyShiftScreenState extends State<MyShiftScreen> {
  final ShiftController controller = Get.put(ShiftController());
  @override
  void initState() {
    super.initState();
    controller.fetchMyShift();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('My Shift')),
        body: Obx(() {
          var myShift = controller.myshiftDetails.value;

          if (myShift.status == Status.LOADING) {
            return const Center(child: CircularProgressIndicator());
          }

          if (myShift.status == Status.ERROR) {
            return Center(child: NoInternet(text: 'Error: ${myShift.message}'));
          }
          if (myShift.data!.results.isEmpty) {
            return const Center(child: NoDataFound(text: 'No shifts Found'));
          }
          if (myShift.status == Status.COMPLETED) {
            var shiftList = myShift.data!.results;
            final totalCount = myShift.data?.count ?? 0;
            final hasMoreData =
                shiftList.length < totalCount && myShift.data?.next != null;

            return SingleChildScrollView(
              child: Column(
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.all(10),
                    itemCount: shiftList.length,
                    itemBuilder: (context, index) {
                      var shift = shiftList[index];

                      return ShiftCard(
                        shift: shift,
                        onTap: () {
                          controller.dropShift(shift.id, context);
                        },
                      );
                    },
                  ),
                  if (hasMoreData)
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            if (!controller.isshiftLoadingMore.value) {
                              controller.fetchMyShift(isLoadMore: true);
                            }
                          },
                          child: controller.isshiftLoadingMore.value
                              ? const SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(
                                      color: Colors.white),
                                )
                              : const Text('Load More'),
                        ),
                      ),
                    ),
                ],
              ),
            );
          }

          return const Center(child: Text('No data available.'));
        }));
  }
}
