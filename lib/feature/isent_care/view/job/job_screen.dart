import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:isentcare/models/permanentjobs_viewController.dart';
import 'package:isentcare/network_data/response/status.dart';
import 'package:isentcare/widgets/No_Data_found.dart';
import 'package:isentcare/widgets/jobs_card.dart';

class JobScreen extends StatelessWidget {
  JobScreen({super.key});
  final PermanentJobsController controller = Get.put(PermanentJobsController());
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      var jobsState = controller.jobsDetails.value;
      var jobList = controller.jobList;
      final totalCount = controller.jobsDetails.value.data?.count ?? 0;
      final hasMoreData = jobList.length < totalCount &&
          controller.jobsDetails.value.data?.next != null;

      if (jobsState.status == Status.LOADING) {
        return const Center(child: CircularProgressIndicator());
      }

      if (jobsState.status == Status.ERROR) {
        return NoInternet(text: 'Error: ${jobsState.message}');
      }
      if (jobsState.data!.results.isEmpty) {
        return const NoDataFound(text: 'No Jobs Found');
      }
      if (jobsState.status == Status.COMPLETED) {
        // Observe the job list

        var jobList = controller.jobList;

        return SingleChildScrollView(
          child: Column(
            children: [
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: jobList.length,
                itemBuilder: (context, index) {
                  var job = jobList[index];

                  // Pass the job data to JobCard widget
                  return JobCard(job: job);
                },
              ),
              if (hasMoreData)
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        if (!controller.isJobsLoadingMore.value) {
                          controller.fetchPermanentJobs(isLoadMore: true);
                        }
                      },
                      child: controller.isJobsLoadingMore.value
                          ? SizedBox(
                              height: 20,
                              width: 20,
                              child: const CircularProgressIndicator(
                                  color: Colors.white))
                          : const Text('Load More'),
                    ),
                  ),
                ),
            ],
          ),
        );
      }

      return const NoDataFound(text: 'No data available.');
    });
  }
}
