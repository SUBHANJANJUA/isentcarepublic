import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:isentcare/modals/employer_modal.dart';
import 'package:isentcare/models/employer_ViewController.dart';
import 'package:isentcare/network_data/response/status.dart';
import 'package:isentcare/widgets/No_Data_found.dart';
import 'package:isentcare/widgets/employ_card.dart';

class EmploymentHistory extends StatelessWidget {
  EmploymentHistory({super.key});
  final EmployerController employerController = Get.put(EmployerController());

  @override
  Widget build(BuildContext context) {
    employerController.fetchEmployers();

    return Scaffold(
      appBar: AppBar(title: const Text('Employment History')),
      body: Obx(() {
        final response = employerController.employDetails.value;

        if (response.status == Status.LOADING) {
          return const Center(child: CircularProgressIndicator());
        } else if (response.status == Status.COMPLETED) {
          final List<EmployerModel> employerList = response.data ?? [];

          return employerList.length == 0
              ? NoDataFound(text: "No Data found")
              : Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ListView.builder(
                    itemCount: employerList.length,
                    itemBuilder: (context, index) {
                      final employer = employerList[index];
                      return EmployCard(employer: employer);
                    },
                  ),
                );
        } else if (response.status == Status.ERROR) {
          return NoInternet(text: response.message ?? "Error occurred");
        }

        return const SizedBox.shrink();
      }),
    );
  }
}
