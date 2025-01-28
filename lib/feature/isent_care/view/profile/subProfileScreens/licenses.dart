import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:isentcare/modals/license_modal.dart';
import 'package:isentcare/models/license_viewController.dart';
import 'package:isentcare/network_data/response/status.dart';
import 'package:isentcare/widgets/No_Data_found.dart';
import 'package:isentcare/widgets/license_card.dart';

class LicenseScreen extends StatelessWidget {
  LicenseScreen({super.key});

  final LicenseController licenseController = Get.put(LicenseController());

  @override
  Widget build(BuildContext context) {
    licenseController.fetchLicense();
    return Scaffold(
      appBar: AppBar(title: const Text('License')),
      body: Obx(() {
        final licenseResponse = licenseController.licenseDetails.value;

        if (licenseResponse.status == Status.LOADING) {
          return const Center(child: CircularProgressIndicator());
        } else if (licenseResponse.status == Status.ERROR) {
          return NoInternet(text: 'Error: ${licenseResponse.message}');
        } else if (licenseResponse.status == Status.COMPLETED) {
          final List<LicenseModel> results = licenseResponse.data!;
          return ListView.builder(
            padding: const EdgeInsets.all(8.0),
            itemCount: results.length,
            itemBuilder: (context, index) {
              final license = results[index];
              return LicenseCard(license: license);
            },
          );
        } else {
          return NoDataFound(text: 'Unknown License');
        }
      }),
    );
  }
}
