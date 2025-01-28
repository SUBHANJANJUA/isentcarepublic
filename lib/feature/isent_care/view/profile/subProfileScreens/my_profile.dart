import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:isentcare/feature/isent_care/view/profile/subProfileScreens/edit_profile.dart';
import 'package:isentcare/feature/isent_care/view/shifts/shifts_screen.dart';
import 'package:isentcare/modals/profile_modal.dart';
import 'package:isentcare/resources/constants/color.dart';
import 'package:isentcare/widgets/network_image.dart';

class MyProfileScreen extends StatelessWidget {
  const MyProfileScreen({super.key, required this.profile});
  final ProfileModel profile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: GestureDetector(
              onTap: () => Get.to(() => EditProfile(profile: profile)),
              child: const Row(
                children: [
                  Icon(Icons.edit_square, color: AppColors.iconColor),
                  SizedBox(width: 5),
                  Text('Edit Profile')
                ],
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Column(
                  children: [
                    DisplayNetworkImage(
                      image: profile.dp,
                      height: 80,
                      width: 80,
                      isprofleImage: true,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '${profile.firstName} ${profile.lastName}',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Basic Information:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.black.withOpacity(0.15))),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildInfoRow('First name', profile.firstName),
                      _buildInfoRow('Last name', profile.lastName),
                      _buildInfoRow('Email', profile.email),
                      _buildInfoRow('Phone Number', profile.phone),
                      _buildInfoRow('Address', profile.address.address),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'My Shifts:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              CompletedShifts(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(fontSize: 14, color: Colors.grey[600]),
          ),
          SizedBox(
            width: 15,
          ),
          Expanded(
            child: Align(
              alignment: Alignment.centerRight,
              child: Text(
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                value,
                style:
                    const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
