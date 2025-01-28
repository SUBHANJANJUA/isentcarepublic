import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:isentcare/feature/isent_care/controller/profile_controller.dart';
import 'package:isentcare/feature/isent_care/view/job/job_screen.dart';
import 'package:isentcare/feature/isent_care/view/profile/profile_screen.dart';
import 'package:isentcare/feature/isent_care/view/shifts/shifts_screen.dart';
import 'package:isentcare/feature/notification/view/notification_screen.dart';
import 'package:isentcare/models/auth_Viewmodel.dart';
import 'package:isentcare/models/perdiem_vieewController.dart';
import 'package:isentcare/models/permanentjobs_viewController.dart';
import 'package:isentcare/models/todayshift_viewController.dart';

import 'package:isentcare/resources/constants/app_sizer.dart';
import 'package:isentcare/resources/constants/app_strings.dart';
import 'package:isentcare/resources/constants/color.dart';
import 'feature/isent_care/view/calender/calender_screen.dart';
import 'feature/isent_care/view/home/home_screen.dart';

class NavigationMenu extends StatefulWidget {
  final int index;
  const NavigationMenu({super.key, this.index = 0});

  @override
  State<NavigationMenu> createState() => _LawyerNavigationMenuState();
}

class _LawyerNavigationMenuState extends State<NavigationMenu> {
  late int currentIndex;

  final TodayShiftController todayshift = Get.put(TodayShiftController());

  final PerdiemController perdiem = Get.put(PerdiemController());
  final AuthViewModel authController = Get.put(AuthViewModel());
  final ProfileController controller = Get.put(ProfileController());

  final PermanentJobsController jobsController =
      Get.put(PermanentJobsController());
  @override
  void initState() {
    super.initState();

    currentIndex = widget.index;
    _callApiMethod(currentIndex);
  }

  void _callApiMethod(int index) {
    switch (index) {
      case 0:
        todayshift.fetchTodayShift();
        break;
      case 1:
        perdiem.fetchperdiem();
        perdiem.fetchCompleted();
        controller.miles.value = 0.0;

        break;
      case 2:
        jobsController.fetchPermanentJobs();
        break;

      case 4:
        authController.fetchProfileDetails();
        break;
    }
  }

  final List<Widget> screens = [
    HomeScreen(),
    const ShiftsScreen(),
    JobScreen(),
    const CalenderScreen(),
    ProfileScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Image.asset(
            "${AppStrings.imagePath}logo.png",
            fit: BoxFit.contain,
            height: 60,
          ),
          actions: [
            Padding(
              padding: EdgeInsets.only(right: context.screenWidth * 0.04),
              child: IconButton(
                  onPressed: () {
                    Get.to(() => NotificationScreen());
                  },
                  icon: const Icon(
                    Icons.notifications_none,
                    size: 35,
                  )),
            )
          ],
        ),
        body: IndexedStack(
          index: currentIndex,
          children: screens,
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: AppColors.navigationBackground,
          iconSize: 30,
          selectedItemColor: AppColors.primary,
          unselectedItemColor: AppColors.primary,
          showUnselectedLabels: true,
          showSelectedLabels: true,
          currentIndex: currentIndex,
          selectedLabelStyle: const TextStyle(
            fontSize: 14,
          ),
          unselectedLabelStyle: const TextStyle(
            fontSize: 14,
          ),
          onTap: (value) {
            setState(() {
              currentIndex = value;
            });
            _callApiMethod(value);
          },
          items: [
            _buildBottomNavigationBarItem(
              icon: Icons.home_outlined,
              label: 'Home',
              index: 0,
            ),
            _buildBottomNavigationBarItem(
              icon: Icons.stacked_line_chart,
              label: "Shifts",
              index: 1,
            ),
            _buildBottomNavigationBarItem(
              icon: Icons.add_to_photos_outlined,
              label: 'Jobs',
              index: 2,
            ),
            _buildBottomNavigationBarItem(
              icon: Icons.calendar_month_outlined,
              label: "Clander",
              index: 3,
            ),
            _buildBottomNavigationBarItem(
              icon: Icons.person,
              label: "Profile",
              index: 4,
            ),
          ],
        ));
  }

  BottomNavigationBarItem _buildBottomNavigationBarItem({
    required IconData icon,
    required String label,
    required int index,
  }) {
    return BottomNavigationBarItem(
      icon: Container(
        decoration: BoxDecoration(
          color: currentIndex == index ? AppColors.primary : Colors.transparent,
          borderRadius: BorderRadius.circular(15),
          shape: BoxShape.rectangle,
        ),
        padding: const EdgeInsets.all(8), // Add some padding for the circle
        child: Icon(
          icon,
          color: currentIndex == index ? Colors.white : AppColors.primary,
        ),
      ),
      label: label,
    );
  }
}
