import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:isentcare/modals/education_modal.dart';
import 'package:isentcare/models/education_viewController.dart';
import 'package:isentcare/network_data/response/status.dart';
import 'package:isentcare/widgets/No_Data_found.dart';
import 'package:isentcare/widgets/education_card.dart';

class Education extends StatelessWidget {
  const Education({super.key});

  @override
  Widget build(BuildContext context) {
    final EducationController educationController =
        Get.put(EducationController());

    educationController.fetchEducations();

    return Scaffold(
      appBar: AppBar(title: const Text('Education')),
      body: Obx(() {
        final response = educationController.educationDetails.value;

        if (response.status == Status.LOADING) {
          return const Center(child: CircularProgressIndicator());
        } else if (response.status == Status.COMPLETED) {
          final List<EducationModel> educationList = response.data ?? [];

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView.builder(
              itemCount: educationList.length,
              itemBuilder: (context, index) {
                final education = educationList[index];
                return EducationCard(education: education);
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
