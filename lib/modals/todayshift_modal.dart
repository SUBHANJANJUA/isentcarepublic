import 'dart:developer';

import 'package:isentcare/modals/professiona_modal.dart';

class TodayShiftModel {
  List<Result> results;

  TodayShiftModel({
    required this.results,
  });

  factory TodayShiftModel.fromJson(Map<String, dynamic> json) {
    return TodayShiftModel(
      results: (json['results'] as List)
          .map((result) => Result.fromJson(result))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'results': results.map((result) => result.toJson()).toList(),
    };
  }
}

class Result {
  Job job;
  String status;
  int id;
  DateTime? punchIn;
  DateTime? punchOut;
  bool? noBreak;
  int? shiftId;

  Result(
      {required this.job,
      required this.status,
      required this.id,
      required this.noBreak,
      required this.shiftId,
      required this.punchIn,
      this.punchOut});

  factory Result.fromJson(Map<String, dynamic> json) {
    return Result(
      job: Job.fromJson(json['job']),
      status: json['status'] ?? '', // Handle nullable fields
      id: json['id'] ?? 0,
      punchIn:
          json['punch_in'] != null ? DateTime.parse(json['punch_in']) : null,
      punchOut:
          json['punch_out'] != null ? DateTime.parse(json['punch_out']) : null,
      noBreak: json['break_shift'] ?? true,
      shiftId: json['shift_id'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'job': job.toJson(),
      'status': status,
      'id': id,
      'punch_in': punchIn?.toIso8601String(),
      'punch_out': punchOut?.toIso8601String(),
      'break_shift': noBreak,
      'shift_id': shiftId,
    };
  }
}

class Job {
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

  Job({
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

  factory Job.fromJson(Map<String, dynamic> json) {
    return Job(
      id: json['id'] ?? 0,
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      startDate: DateTime.parse(json['start_date']),
      timing: json['timing'] ?? '', // Handle nullable timing
      profession: Profession.fromJson(json['profession'] ?? {}),
      state: json['state'] ?? '', // Handle nullable state
      billRate: (json['bill_rate'] as num?)?.toDouble() ??
          0.0, // Safely parse nullable double
      facility: json['facility'] ?? '',

      // Handle nullable facility
      facilityId: json['facility_id'] ??
          0, // Provide default value for nullable facilityId
    );
  }

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
