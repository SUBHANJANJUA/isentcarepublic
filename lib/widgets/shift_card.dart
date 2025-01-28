import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:isentcare/feature/isent_care/view/profile/subProfileScreens/shift_details.dart';
import 'package:isentcare/modals/myshift_modal.dart';
import 'package:isentcare/resources/constants/app_sizer.dart';
import 'package:isentcare/resources/constants/color.dart';
import 'package:isentcare/resources/helper_functions.dart';
import 'package:isentcare/widget/dialog/confirmation_dialog.dart';

class ShiftCard extends StatelessWidget {
  const ShiftCard({
    super.key,
    required this.shift,
    required this.onTap,
  });
  final ShiftResult shift;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.to(() => const ShiftDetailsScreen()),
      child: Container(
        margin: const EdgeInsets.only(top: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: Colors.black.withOpacity(0.10),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                shift.job.profession.name,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
              ),
              SizedBox(height: context.screenHeight * 0.01),
              Row(
                children: [
                  const Icon(
                    Icons.add,
                    color: AppColors.iconColor,
                  ),
                  Expanded(child: Text(shift.job.facility))
                ],
              ),
              Row(
                children: [
                  const Icon(Icons.location_on, color: AppColors.iconColor),
                  Text(shift.job.state)
                ],
              ),
              SizedBox(height: context.screenHeight * 0.01),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ResuableRow(
                      text:
                          HelperUtil.formatDate(shift.job.startDate.toString()),
                      icon: Icons.calendar_month),
                  ResuableRow(
                    text: shift.job.timing == 'Morning'
                        ? "7AM-3PM"
                        : shift.job.timing == "Evening"
                            ? "3 PM-11PM"
                            : "11PM-7AM",
                    icon: Icons.timer,
                  ),
                  ResuableRow(
                    icon: Icons.attach_money,
                    text: shift.job.billRate.toString(),
                  ),
                ],
              ),
              SizedBox(height: context.screenHeight * 0.02),
              shift.status == "Approved"
                  ? SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () => showDialog(
                            context: Get.context!,
                            builder: (context) => ConfirmationDialog(
                                  dilogdescription:
                                      "Are you sure you want to Drop the request?",
                                  onTap: onTap,
                                )),
                        child: const Text('Drop'),
                      ),
                    )
                  : const SizedBox.shrink()
            ],
          ),
        ),
      ),
    );
  }
}

class ResuableRow extends StatelessWidget {
  const ResuableRow({
    super.key,
    required this.text,
    required this.icon,
  });

  final String text;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: AppColors.iconColor),
        const SizedBox(width: 5),
        Text(text),
      ],
    );
  }
}
