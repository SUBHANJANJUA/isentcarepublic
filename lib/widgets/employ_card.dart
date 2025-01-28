import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:isentcare/feature/isent_care/view/profile/subProfileScreens/edit_employment.dart';
import 'package:isentcare/modals/employer_modal.dart';
import 'package:isentcare/models/employer_ViewController.dart';
import 'package:isentcare/resources/app_text_style.dart';
import 'package:isentcare/resources/constants/app_strings.dart';
import 'package:isentcare/resources/helper_functions.dart';
import 'package:isentcare/widget/dialog/confirmation_dialog.dart';
import 'package:isentcare/widgets/button_container.dart';
import 'package:isentcare/widgets/education_card.dart';

class EmployCard extends StatelessWidget {
  final EmployerModel employer;

  EmployCard({super.key, required this.employer});
  final EmployerController employerController = Get.put(EmployerController());

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.withOpacity(0.50)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  employer.jobTitle.toString(),
                  style: AppTextStyle.tableheading,
                ),
                Row(
                  children: [
                    ButtonContainer(
                      onTap: () {
                        showDialog(
                            context: Get.context!,
                            builder: (context) =>
                                EditEmploymentScreen(employData: employer));
                      },
                      iconString: '${AppStrings.imagePath}editicon.svg',
                    ),
                    const SizedBox(width: 10),
                    ButtonContainer(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) => ConfirmationDialog(
                            dilogdescription:
                                "Are you sure you want to delete?",
                            onTap: () {
                              Get.back();
                              employerController.deleteEmployee(
                                  employer.id!, context);
                            },
                          ),
                        );
                      },
                      iconString: '${AppStrings.imagePath}deleteicon.svg',
                    ),
                  ],
                )
              ],
            ),
            SizedBox(height: 10),
            Table(columnWidths: {
              0: const FlexColumnWidth(1),
              1: const FlexColumnWidth(2),
            }, children: [
              TableRow(children: [
                const LabelText(
                  label: 'Telephone',
                ),
                ValueText(
                  value: employer.telephone.toString(),
                ),
              ]),
              TableRow(children: [
                const LabelText(
                  label: 'SuperVisor',
                ),
                ValueText(
                  value: employer.supervisor.toString(),
                ),
              ]),
              TableRow(children: [
                const LabelText(
                  label: 'Company',
                ),
                ValueText(
                  value: employer.company.toString(),
                ),
              ]),
              TableRow(children: [
                const LabelText(
                  label: 'Address',
                ),
                ValueText(
                  value: employer.address.toString(),
                ),
              ]),
              TableRow(children: [
                const LabelText(
                  label: 'From',
                ),
                ValueText(
                  value: HelperUtil.formatDate(employer.fromDate.toString()),
                ),
              ]),
              TableRow(children: [
                const LabelText(
                  label: 'To',
                ),
                ValueText(
                  value: HelperUtil.formatDate(employer.toDate.toString()),
                ),
              ]),
            ]),
          ],
        ),
      ),
    );
  }
}
