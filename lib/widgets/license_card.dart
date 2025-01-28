import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:isentcare/feature/isent_care/view/profile/subProfileScreens/edit_license.dart';
import 'package:isentcare/modals/license_modal.dart';
import 'package:isentcare/resources/app_text_style.dart';
import 'package:isentcare/resources/constants/app_strings.dart';
import 'package:isentcare/resources/helper_functions.dart';
import 'package:isentcare/widget/dialog/confirmation_dialog.dart';
import 'package:isentcare/widgets/button_container.dart';
import 'package:isentcare/widgets/education_card.dart';

class LicenseCard extends StatelessWidget {
  final LicenseModel license;

  const LicenseCard({super.key, required this.license});

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
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    license.profession.name,
                    style: AppTextStyle.tableheading,
                  ),
                  // Row(
                  //   children: [
                  //     ButtonContainer(
                  //       onTap: () {
                  //         showDialog(
                  //             context: Get.context!,
                  //             builder: (context) =>
                  //                 EditLicenseScreen(licenseData: license));
                  //       },
                  //       iconString: '${AppStrings.imagePath}editicon.svg',
                  //     ),
                  //     const SizedBox(width: 10),
                  //     ButtonContainer(
                  //       onTap: () {
                  //         showDialog(
                  //           context: context,
                  //           builder: (context) => ConfirmationDialog(
                  //             dilogdescription:
                  //                 "Are you sure you want to delete?",
                  //             onTap: () {},
                  //           ),
                  //         );
                  //       },
                  //       iconString: '${AppStrings.imagePath}deleteicon.svg',
                  //     ),
                  //   ],
                  // )
                ],
              ),
              SizedBox(height: 10),
              Table(
                columnWidths: {
                  0: FlexColumnWidth(1.5),
                  1: FlexColumnWidth(2),
                },
                children: [
                  TableRow(children: [
                    const LabelText(
                      label: 'License Number',
                    ),
                    ValueText(
                      value: license.number,
                    ),
                  ]),
                  TableRow(children: [
                    const LabelText(
                      label: 'Primary State',
                    ),
                    ValueText(
                      value: license.primaryState!.name,
                    ),
                  ]),
                  TableRow(children: [
                    const LabelText(
                      label: 'License State',
                    ),
                    ValueText(
                      value: license.state.first.name,
                    ),
                  ]),
                  TableRow(children: [
                    const LabelText(
                      label: 'Expiry Date',
                    ),
                    ValueText(
                      value:
                          HelperUtil.formatDate(license.expiryDate.toString()),
                    ),
                  ]),
                ],
              ),
            ])));
  }
}
