import 'dart:io';

import 'package:isentcare/resources/helper_functions.dart';

class SingUpModal {
  final String firstName;
  final String lastName;
  final String email;
  final String phone;
  final String password;
  final String confirmPassword;
  final String dob;
  final String ssn;
  final String address;
  final String city;
  final int state;
  final String zipCode;
  final double latitude;
  final double longitude;
  final String type;
  final DateTime joiningDate;
  final File? dp;
  final String title;
  final bool perdiem;
  final bool fixTime;
  final bool traAssign;
  final bool perPlace;

  SingUpModal(
      {required this.firstName,
      required this.lastName,
      required this.email,
      required this.phone,
      required this.password,
      required this.confirmPassword,
      required this.dob,
      required this.ssn,
      required this.address,
      required this.city,
      required this.state,
      required this.zipCode,
      required this.latitude,
      required this.longitude,
      required this.type,
      required this.joiningDate,
      required this.dp,
      required this.title,
      required this.fixTime,
      required this.traAssign,
      required this.perPlace,
      required this.perdiem});

  // Convert model to map for API request
  Map<String, String> toMap() {
    return {
      'first_name': firstName ?? '',
      'last_name': lastName ?? '',
      'email': email ?? '',
      'phone': phone ?? '',
      'password': password ?? '',
      'confirm_password': confirmPassword ?? '',
      'dob': dob ?? '',
      'ssn': ssn ?? '',
      'address': address ?? '',
      'city': city ?? '',
      'state': state.toString() ?? '',
      'zip_code': zipCode ?? '',
      'latitude': latitude.toString() ,
      'longitude': longitude.toString() ,
      'type': type ?? '',
      'title': title ?? '',
      'per_diem': perdiem.toString(),
      'fix_time': fixTime.toString(),
      'tra_assign': traAssign.toString(),
      'per_place': perPlace.toString(),
      'joining_date': HelperUtil.formatDate(joiningDate.toString()),
    };
  }
}
