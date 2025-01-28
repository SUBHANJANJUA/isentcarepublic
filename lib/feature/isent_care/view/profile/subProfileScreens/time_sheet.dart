import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:isentcare/models/shift_viewController.dart';
import 'package:isentcare/network_data/response/status.dart';
import 'package:isentcare/resources/helper_functions.dart';
import 'package:isentcare/widgets/No_Data_found.dart';
import 'package:isentcare/widgets/timeshift_card.dart';

class TimeSheetsScreen extends StatefulWidget {
  TimeSheetsScreen({Key? key}) : super(key: key);

  @override
  State<TimeSheetsScreen> createState() => _TimeSheetsScreenState();
}

class _TimeSheetsScreenState extends State<TimeSheetsScreen> {
  final ShiftController controller = Get.put(ShiftController());
  @override
  void initState() {
    controller.fetchShift();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Time Sheets"),
      ),
      body: Obx(() {
        final state = controller.shiftDetails.value;
        if (state.status == Status.LOADING) {
          return const Center(child: CircularProgressIndicator());
        } else if (state.status == Status.ERROR) {
          return NoInternet(text: 'Error: ${state.message}');
        } else if (state.data!.results.isEmpty) {
          return const Center(child: NoDataFound(text: 'Time sheet not available.'));
        } else if (state.status == Status.COMPLETED) {
          final shiftModel = state.data!;
          final results = shiftModel.results;
          final totalCount = shiftModel.count;
          final hasMoreData =
              results.length < totalCount && shiftModel.next != null;
          return SingleChildScrollView(
            child: Column(
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.all(8.0),
                  itemCount: results.length,
                  itemBuilder: (context, index) {
                    final result = results[index];
                    return TimeSheetCard(
                      facilityName: result.facility,
                      position: result.position,
                      hours: result.totalHours,
                      payRate: result.pay.toString(),
                      shiftDate: HelperUtil.formatDate(result.date.toString()),
                      startTime: result.punchIn,
                      endTime: result.punchOut ?? '0',
                      shift: result.timing,
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
                            controller.fetchShift(isLoadMore: true);
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
        } else {
          return const NoDataFound(text: 'Unknown state');
        }
      }),
    );
  }
}
