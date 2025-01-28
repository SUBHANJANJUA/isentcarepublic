import 'package:isentcare/resources/helper_functions.dart';

class EmployerModel {
  int? id;
  DateTime? createdAt;
  DateTime? updatedAt;
  String state;
  String supervisor;
  String jobTitle;
  String telephone;
  String address;
  String company;
  String zipCode;
  String city;
  String leavingReason;
  DateTime fromDate;
  DateTime toDate;

  EmployerModel({
    this.id,
    this.createdAt,
    this.updatedAt,
    required this.state,
   required this.supervisor,
   required this.jobTitle,
   required this.telephone,
   required this.address,
  required  this.company,
    required this.zipCode,
    required this.city,
    required this.leavingReason,
  required  this.fromDate,
  required  this.toDate,
  });

  factory EmployerModel.fromJson(Map<String, dynamic> json) {
    return EmployerModel(
      id: json['id'] ?? 0,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : DateTime.now(),
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'])
          : DateTime.now(),
      state: json['state'],
      supervisor: json['supervisor'] ?? '',
      jobTitle: json['job_title'] ?? '',
      telephone: json['telephone'] ?? '',
      address: json['address'] ?? '',
      company: json['company'] ?? '',
      zipCode: json['zip_code'],
      city: json['city'],
      leavingReason: json['leaving_reason'],
      fromDate: json['from_date'] != null
          ? DateTime.parse(json['from_date'])
          : DateTime.now(),
      toDate: json['to_date'] != null
          ? DateTime.parse(json['to_date'])
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
      'state': state,
      'supervisor': supervisor ?? '',
      'job_title': jobTitle ?? '',
      'telephone': telephone ?? '',
      'address': address ?? '',
      'company': company ?? '',
      'zip_code': zipCode,
      'city': city,
      'leaving_reason': leavingReason,
      'from_date': HelperUtil.formatDate(fromDate.toString()),
      'to_date': HelperUtil.formatDate(toDate.toString()),
    };
  }

  @override
  String toString() {
    return '''
EmployerModel {
  id: $id,
  createdAt: ${createdAt?.toIso8601String()},
  updatedAt: ${updatedAt?.toIso8601String()},
  state: $state,
  supervisor: $supervisor,
  jobTitle: $jobTitle,
  telephone: $telephone,
  address: $address,
  company: $company,
  zipCode: $zipCode,
  city: $city,
  leavingReason: $leavingReason,
  fromDate: ${fromDate?.toIso8601String()},
  toDate: ${toDate?.toIso8601String()}
}
    ''';
  }
}
