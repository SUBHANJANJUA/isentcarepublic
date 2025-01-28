import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:isentcare/modals/completedshift_modal.dart';
import 'package:isentcare/models/perdiem_vieewController.dart';
import 'package:isentcare/resources/helper_functions.dart';

import 'shift_card_container.dart';

class CompletedShiftContainer extends StatelessWidget {
  CompletedShiftContainer({
    super.key,
    required this.shifts,
  });

  final CompletedShiftModel shifts;

  final PerdiemController controller = Get.put(PerdiemController());

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10)),
          color: Colors.lightBlue.withOpacity(0.08)),
      child: Obx(() {
        final shifts = controller.completedDetails.value.data?.results ?? [];

        final totalCount = controller.completedDetails.value.data?.count ?? 0;
        final hasMoreData = shifts.length < totalCount &&
            controller.completedDetails.value.data?.next != null;
        if (shifts.isEmpty && !controller.isCompletedLoadingMore.value) {
          return const Center(
            child: Text('No shifts available'),
          );
        }
        return Column(
          children: [
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: shifts.length,
              padding: const EdgeInsets.symmetric(vertical: 10),
              itemBuilder: (context, index) {
                final shift = shifts[index];

                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ShiftCardContainer(
                      facility: shift.facility,
                      date: HelperUtil.formatDate(shift.date.toString()),
                      time: shift.timing ?? '',
                      price: "\$${shift.pay.toString()}",
                      id: shift.id,
                      showButton: false,
                      onTap: () {},
                    ),
                  ],
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
                      if (!controller.isCompletedLoadingMore.value) {
                        controller.fetchCompleted(isLoadMore: true);
                      }
                    },
                    child: controller.isCompletedLoadingMore.value
                        ? SizedBox(
                            width: 20,
                            height: 20,
                            child: const CircularProgressIndicator(
                                color: Colors.white))
                        : const Text('Load More'),
                  ),
                ),
              ),
          ],
        );
      }),
    );
  }
}
