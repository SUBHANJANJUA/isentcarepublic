import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:isentcare/feature/isent_care/view/shifts/shift_detail_screen.dart';
import 'package:isentcare/modals/perdiem_modal.dart';
import 'package:isentcare/models/perdiem_vieewController.dart';
import 'package:isentcare/resources/helper_functions.dart';
import 'package:isentcare/widget/dialog/confirmation_dialog.dart';
import 'shift_card_container.dart';

class ShiftListContainer extends StatelessWidget {
  final PerDiemModel perDiemModel;

  ShiftListContainer({
    Key? key,
    required this.perDiemModel,
  }) : super(key: key);

  final PerdiemController controller = Get.put(PerdiemController());

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(10),
          bottomRight: Radius.circular(10),
        ),
        color: Colors.lightBlue.withOpacity(0.08),
      ),
      child: Obx(() {
        final shifts = controller.perdiemDetails.value.data?.results ?? [];
        final totalCount = controller.perdiemDetails.value.data?.count ?? 0;
        final hasMoreData = shifts.length < totalCount &&
            controller.perdiemDetails.value.data?.next != null;

        if (shifts.isEmpty && !controller.isLoadingMore.value) {
          return const Center(
            child: Text('No shifts available'),
          );
        }

        return SingleChildScrollView(
          child: Column(
            children: [
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: shifts.length,
                padding: const EdgeInsets.symmetric(vertical: 10),
                itemBuilder: (context, index) {
                  final shift = shifts[index];
                  return GestureDetector(
                    onTap: () {
                      Get.to(() => ShiftDetailScreen(
                            facility: shift.facility,
                            status: 'available',
                            date: HelperUtil.formatDate(
                                shift.startDate.toString()),
                            time: shift.timing,
                            price: "\$${shift.billRate.toString()}",
                          ));
                    },
                    child: ShiftCardContainer(
                      facility: shift.facility,
                      date: HelperUtil.formatDate(shift.startDate.toString()),
                      time: shift.timing,
                      price: "\$${shift.billRate.toString()}",
                      id: shift.id,
                      showButton: true,
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) => ConfirmationDialog(
                            onTap: () {
                              final jobData = {"job": shift.id};
                              controller.createJob(jobData, context);
                            },
                            dilogdescription:
                                "Are you sure to pick this job?",
                          ),
                        );
                      },
                    ),
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
                        if (!controller.isLoadingMore.value) {
                          controller.fetchperdiem(isLoadMore: true);
                        }
                      },
                      child: controller.isLoadingMore.value
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                  color: Colors.white))
                          : const Text('Load More'),
                    ),
                  ),
                ),
            ],
          ),
        );
      }),
    );
  }
}
