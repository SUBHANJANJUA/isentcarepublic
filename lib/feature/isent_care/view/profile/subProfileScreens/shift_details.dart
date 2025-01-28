import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:isentcare/resources/constants/app_sizer.dart';
import 'package:isentcare/resources/constants/color.dart';
import 'package:isentcare/widget/dialog/success_dialog.dart';

class ShiftDetailsScreen extends StatelessWidget {
  const ShiftDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Shift Details')),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Registration Nurse RN - Long Term care',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
            ),
            SizedBox(height: context.screenHeight * 0.01),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Facility Name',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
                ),
                Container(
                  height: 25,
                  width: 35,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.blueGrey.withOpacity(0.30),
                  ),
                  child: const Center(
                    child: Text(
                      'RN',
                      style: TextStyle(
                          fontSize: 14,
                          color: AppColors.iconColor,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(height: context.screenHeight * 0.01),
            const Row(
              children: [
                Icon(Icons.location_on, color: AppColors.iconColor),
                Text(
                  'location',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
                )
              ],
            ),
            const Row(
              children: [
                Icon(
                  Icons.calendar_month,
                  color: AppColors.iconColor,
                ),
                Text(
                  '8 AM - 5 PM',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
                )
              ],
            ),
            SizedBox(height: context.screenHeight * 0.01),
            const Text(
              'Job Description',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
            ),
            SizedBox(height: context.screenHeight * 0.01),
            const Text(
                'when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.')
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
        child: SizedBox(
          child: ElevatedButton(
              onPressed: () {
                showDialog(
                    context: Get.context!,
                    builder: (context) => const SuccessDialog(
                          dilogdescription:
                              "Drop Request is sent. We will confirm you about the approval soon.",
                        ));
              },
              child: const Text('Drop')),
        ),
      ),
    );
  }
}
