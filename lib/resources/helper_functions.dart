import 'dart:io';

import 'dart:developer';
import 'dart:math' as math;

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:isentcare/resources/utils.dart';
import 'package:url_launcher/url_launcher.dart';

import 'constants/app_strings.dart';
import 'constants/color.dart';

class HelperUtil {
  static Future<String> getFcmToken() async {
    final firebaseMessaging = FirebaseMessaging.instance;
    String token = "";
    try {
      await firebaseMessaging.deleteToken();
      token = await FirebaseMessaging.instance.getToken() ?? "";
      if (token.isEmpty) {
        log("FCM Token is empty. There may be an issue with Firebase initialization.");
      }
    } catch (e) {
      log("Failed to get FCM token: $e");
      // Optionally, handle the error more gracefully or notify the user/application
    }
    return token;
  }

  static Future<Position> getLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      Utils.showError(
          'Location services are disabled.Enable first to start shift');
    }

    // Check for location permission
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception('Location permissions are denied.');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw Exception('Location permissions are permanently denied.');
    }

    // Get current position
    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
  }

  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return "Email is required";
    }
    if (!RegExp(r"^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]+$")
        .hasMatch(value)) {
      return "Enter a valid email";
    }
    return null;
  }

  static double calculateAverageRating(List items) {
    if (items.isEmpty) {
      return 0.0;
    }
    double sum = items.fold(0.0, (previousValue, item) => previousValue + item);
    return sum / items.length;
  }

  static double calculateNetAmount(double amount) {
    const platformFeePercentage = 10.0;
    double platformFee = (amount * platformFeePercentage) / 100;
    return amount - platformFee;
  }

  static String getInitials(String firstName, String lastName) {
    String firstInitial = firstName.isNotEmpty ? firstName[0] : '';
    String lastInitial = lastName.isNotEmpty ? lastName[0] : '';

    return '$firstInitial$lastInitial'.toUpperCase();
  }

  static String capitaliseFirstLetter(String input) {
    return input[0].toUpperCase() + input.substring(1);
  }

  static String calculateDateDifference(DateTime givenDate) {
    DateTime currentDate = DateTime.now();
    Duration difference = currentDate.difference(givenDate);

    if (difference.inDays == 0) {
      return 'Today';
    } else if (difference.inDays == 1) {
      return '1 day ago';
    } else {
      return '${difference.inDays} days ago';
    }
  }

  static launchgmailApp({required String userName}) async {
    String? encodeQueryParameters(Map<String, String> params) {
      return params.entries
          .map((MapEntry<String, String> e) =>
              '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
          .join('&');
    }

    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: AppStrings.appEmail,
      query: encodeQueryParameters(<String, String>{
        'subject': 'Query from $userName',
      }),
    );
    if (await canLaunchUrl(emailLaunchUri)) {
      launchUrl(emailLaunchUri);
    } else {
      throw Exception('Could not launch $emailLaunchUri');
    }
  }

  static Future<String?> selectPreviousDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: const ColorScheme.light().copyWith(
              primary: AppColors
                  .primary, // background color of the header and selected date
              onPrimary:
                  Colors.white, // text color of the header and selected date
            ),
            dialogBackgroundColor:
                Colors.white, // background color of the date picker
          ),
          child: child!,
        );
      },
    );

    return formatDate(picked.toString());
  }

  static Future<String?> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2050),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: const ColorScheme.light().copyWith(
              primary: AppColors
                  .primary, // background color of the header and selected date
              onPrimary:
                  Colors.white, // text color of the header and selected date
            ),
            dialogBackgroundColor:
                Colors.white, // background color of the date picker
          ),
          child: child!,
        );
      },
    );

    return formatDate(picked.toString());
  }

  static Future<List<XFile>> pickMedia(ImageSource source) async {
    List<XFile> mediaUrls = [];

    final ImagePicker picker = ImagePicker();
    XFile? pickedFile;
    pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      mediaUrls.add(pickedFile);
    }
    return mediaUrls;
  }

  static Future<TimeOfDay?> selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: const ColorScheme.light().copyWith(
              primary: AppColors.primary,
              onPrimary: Colors.white,
            ),
            dialogBackgroundColor: Colors.white,
          ),
          child: child!,
        );
      },
    );

    return (picked);
  }

  static Future<File?> pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      return File(pickedFile.path);
    } else {
      return null;
    }
  }

  static String formatTime(String time) {
    DateTime dateTime = DateTime.parse(time);
    DateFormat formatter = DateFormat('HH:mm:ss');
    return formatter.format(dateTime);
  }

  static String formatDate(String date) {
    DateTime dateTime = DateTime.parse(date);
    DateFormat formatter = DateFormat('yyyy-MM-dd');
    return formatter.format(dateTime);
  }

  static String dateWithMonthName(String date) {
    DateTime dateTime = DateTime.parse(date);
    DateFormat formatter = DateFormat('d-MMM-y'); // Changed format pattern
    return formatter.format(dateTime);
  }

//   String formatDateAndTime(String date) {
//     DateTime dateTime = DateTime.parse(date);
//     DateFormat formatter = DateFormat('yyyy-MM-dd HH:mm:ss');
//     return formatter.format(dateTime);
//   }

  static String generateOtp(int number) {
    final random = math.Random();
    final otpDigits = List.generate(number, (index) => random.nextInt(10));
    return otpDigits.join();
  }

  static String timeAgo(DateTime dateTime) {
  final difference = DateTime.now().difference(dateTime);

  if (difference.inMinutes == 0) return 'Just now';
  if (difference.inMinutes == 1) return '1 min ago';
  if (difference.inMinutes < 60) return '${difference.inMinutes} mins ago';
  if (difference.inHours == 1) return '1 hour ago';
  if (difference.inHours < 24) return '${difference.inHours} hours ago';
  if (difference.inDays == 1) return '1 day ago';
  if (difference.inDays < 7) return '${difference.inDays} days ago';
  if (difference.inDays < 30) return '${(difference.inDays / 7).floor()} weeks ago';
  if (difference.inDays < 365) return '${(difference.inDays / 30).floor()} months ago';
  return '${(difference.inDays / 365).floor()} years ago';
}

}
