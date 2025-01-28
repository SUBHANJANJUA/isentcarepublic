import 'package:isentcare/modals/professiona_modal.dart';

class PerDiemModel {
  int count;
  dynamic next;
  dynamic previous;
  List<Result> results;
  int page;
  bool licenseExpired;

  PerDiemModel({
    required this.count,
    required this.next,
    required this.previous,
    required this.results,
    required this.page,
    required this.licenseExpired,
  });
    // CopyWith method
  PerDiemModel copyWith({
    int? count,
    dynamic next,
    dynamic previous,
    List<Result>? results,
    int? page,
    bool? licenseExpired,
  }) {
    return PerDiemModel(
      count: count ?? this.count,
      next: next ?? this.next,
      previous: previous ?? this.previous,
      results: results ?? this.results,
      page: page ?? this.page,
      licenseExpired: licenseExpired ?? this.licenseExpired,
    );
  }
  

  // From JSON
  factory PerDiemModel.fromJson(Map<String, dynamic> json) {
    return PerDiemModel(
      count: json['count'],
      next: json['next'],
      previous: json['previous'],
      results: List<Result>.from(json['results'].map((x) => Result.fromJson(x))),
      page: json['page'],
      licenseExpired: json['license_expired'],
    );
  }

  // To JSON
  Map<String, dynamic> toJson() {
    return {
      'count': count,
      'next': next,
      'previous': previous,
      'results': results.map((x) => x.toJson()).toList(),
      'page': page,
      'license_expired': licenseExpired,
    };
  }
}

class Result {
  int id;
  DateTime createdAt;
  DateTime updatedAt;
  DateTime startDate;
  String timing;
  Profession profession;
  String state;
  double billRate;
  String facility;
  int facilityId;

  Result({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.startDate,
    required this.timing,
    required this.profession,
    required this.state,
    required this.billRate,
    required this.facility,
    required this.facilityId,
  });

  // From JSON
  factory Result.fromJson(Map<String, dynamic> json) {
    return Result(
      id: json['id'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      startDate: DateTime.parse(json['start_date']),
      timing: json['timing'],
      profession: Profession.fromJson(json['profession']),
      state: json['state'],
      billRate: json['bill_rate'].toDouble(),
      facility: json['facility'],
      facilityId: json['facility_id'],
    );
  }

  // To JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'start_date': startDate.toIso8601String(),
      'timing': timing,
      'profession': profession.toJson(),
      'state': state,
      'bill_rate': billRate,
      'facility': facility,
      'facility_id': facilityId,
    };
  }
}
