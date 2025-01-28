import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:isentcare/feature/isent_care/view/earning/earning_screen.dart';
import 'package:isentcare/feature/isent_care/view/profile/subProfileScreens/attachment.dart';
import 'package:isentcare/feature/isent_care/view/profile/subProfileScreens/education.dart';
import 'package:isentcare/feature/isent_care/view/profile/subProfileScreens/employment_history.dart';
import 'package:isentcare/feature/isent_care/view/profile/subProfileScreens/licenses.dart';
import 'package:isentcare/feature/isent_care/view/profile/subProfileScreens/my_profile.dart';
import 'package:isentcare/feature/isent_care/view/profile/subProfileScreens/my_shift.dart';
import 'package:isentcare/feature/isent_care/view/profile/subProfileScreens/time_sheet.dart';
import 'package:isentcare/models/auth_Viewmodel.dart';
import 'package:isentcare/models/perdiem_vieewController.dart';
import 'package:isentcare/network_data/response/status.dart';
import 'package:isentcare/resources/constants/color.dart';
import 'package:isentcare/resources/helper_functions.dart';
import 'package:isentcare/widgets/network_image.dart';

import '../../../../widget/dialog/confirmation_dialog.dart';
import 'setting/setting.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  AuthViewModel authcontroller = Get.put(AuthViewModel());
  PerdiemController controller = Get.put(PerdiemController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: ProfileRow(),
        ),
        const Divider(thickness: 1),
        Expanded(
          child: ListView(
            children: [
              _buildMenuItem(
                Icons.person,
                'My Profile',
                () {
                  final profile = authcontroller.profileDetails.value.data;
                  if (profile != null) {
                    Get.to(() => MyProfileScreen(profile: profile));
                    controller.fetchCompleted();
                  }
                },
              ),
              _buildMenuItem(
                Icons.calendar_today,
                'My Shifts',
                () {
                  Get.to(() => MyShiftScreen());
                },
              ),
              _buildMenuItem(
                Icons.access_time,
                'TimeSheets',
                () {
                  Get.to(() => TimeSheetsScreen());
                },
              ),
              _buildMenuItem(
                Icons.attach_money,
                'My Earnings',
                () {
                  Get.to(() => const EarningScreen());
                },
              ),
              _buildMenuItem(
                Icons.headset_mic,
                'Support',
                () {
                  HelperUtil.launchgmailApp(userName: "Nisar");
                },
              ),
              _buildMenuItem(
                Icons.share,
                'Share with others',
                () {},
              ),
              _buildMenuItem(
                Icons.settings,
                'Setting',
                () {
                  Get.to(() => const SettingScreen());
                },
              ),
              _buildMenuItem(
                Icons.history,
                'EmploymentHistory',
                () {
                  Get.to(() => EmploymentHistory());
                },
              ),
              _buildMenuItem(
                Icons.school,
                'Education',
                () {
                  Get.to(() => const Education());
                },
              ),
              _buildMenuItem(
                Icons.attach_email_outlined,
                'Attachment',
                () {
                  Get.to(() => AttachmentScreen());
                },
              ),
              _buildMenuItem(
                Icons.screen_search_desktop_outlined,
                'Licenses',
                () {
                  Get.to(() => LicenseScreen());
                },
              ),
              _buildMenuItem(Icons.logout, 'Logout', () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return ConfirmationDialog(
                        onTap: () => AuthViewModel().signOut(context: context),
                        dilogdescription:
                            "Are you sure to logout for this account?",
                      );
                    });
              }),
            ],
          ),
        ),
      ],
    ));
  }
}

class ProfileRow extends StatelessWidget {
  ProfileRow({super.key});

  final AuthViewModel authController = Get.put(AuthViewModel());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final status = authController.profileDetails.value;
      if (status.status == Status.LOADING) {
        return const Center(child: CircularProgressIndicator());
      } else if (status.status == Status.ERROR) {
        return const Center(child: Text("No data found"));
      } else if (status.status == Status.COMPLETED) {
        final profile = status.data;
        return Row(
          children: [
            DisplayNetworkImage(
              image: profile!.dp,
              height: 50,
              width: 50,
              isprofleImage: true,
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${profile.firstName} ${profile.lastName}',
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  profile.email,
                  style: const TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ],
        );
      } else {
        throw StateError('Unexpected status: ${status.status}');
      }
    });
  }
}

ListTile _buildMenuItem(IconData icon, String title, VoidCallback onTap) {
  return ListTile(
    leading: Icon(icon, color: AppColors.iconColor),
    title: Text(title, style: const TextStyle(fontSize: 16)),
    onTap: onTap,
  );
}
