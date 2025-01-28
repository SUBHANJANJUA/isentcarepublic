import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:isentcare/feature/isent_care/view/profile/subProfileScreens/edit_education.dart';
import 'package:isentcare/modals/education_modal.dart';
import 'package:isentcare/models/education_viewController.dart';
import 'package:isentcare/resources/app_text_style.dart';
import 'package:isentcare/resources/constants/app_strings.dart';
import 'package:isentcare/resources/helper_functions.dart';
import 'package:isentcare/widget/dialog/confirmation_dialog.dart';
import 'package:isentcare/widgets/button_container.dart';

class EducationCard extends StatelessWidget {
  final EducationModel education;

  EducationCard({super.key, required this.education});
  final EducationController educationController =
      Get.put(EducationController());

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
                  education.degree,
                  style: AppTextStyle.tableheading,
                ),
                Row(children: [
                  ButtonContainer(
                    onTap: () {
                      showDialog(
                        context: Get.context!,
                        builder: (context) =>
                            EditEducationScreen(educationData: education),
                      );
                    },
                    iconString: '${AppStrings.imagePath}editicon.svg',
                  ),
                  const SizedBox(width: 10),
                  ButtonContainer(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) => ConfirmationDialog(
                          dilogdescription: "Are you sure you want to delete?",
                          onTap: () {
                            Get.back();
                            educationController.deleteEducations(
                                education.id!, context);
                          },
                        ),
                      );
                    },
                    iconString: '${AppStrings.imagePath}deleteicon.svg',
                  ),
                ])
              ],
            ),
            const SizedBox(height: 10),
            Table(columnWidths: const {
              0: FlexColumnWidth(1),
              1: FlexColumnWidth(2),
            }, children: [
              TableRow(children: [
                const LabelText(
                  label: 'Major',
                ),
                ValueText(
                  value: education.majors,
                ),
              ]),
              TableRow(children: [
                const LabelText(
                  label: 'Gpa',
                ),
                ValueText(
                  value: education.gpa.toString(),
                ),
              ]),
              TableRow(children: [
                const LabelText(
                  label: 'Institute',
                ),
                ValueText(
                  value: education.institute,
                ),
              ]),
              TableRow(children: [
                const LabelText(
                  label: 'Country',
                ),
                ValueText(
                  value: education.country!.name.toString(),
                ),
              ]),
              TableRow(children: [
                const LabelText(
                  label: 'From',
                ),
                ValueText(
                    value:
                        HelperUtil.formatDate(education.startDate.toString())),
              ]),
              TableRow(children: [
                const LabelText(
                  label: 'To',
                ),
                ValueText(
                  value: HelperUtil.formatDate(education.endDate.toString()),
                ),
              ])
            ]),
          ],
        ),
      ),
    );
  }
}

class LabelText extends StatelessWidget {
  final String label;

  const LabelText({
    super.key,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      '$label: ',
      style: const TextStyle(
        fontSize: 14,
        color: Colors.black,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}

class ValueText extends StatelessWidget {
  final String value;

  const ValueText({
    super.key,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      value,
      style: const TextStyle(
        fontSize: 14,
        color: Colors.black,
        fontWeight: FontWeight.w200,
      ),
    );
  }
}
