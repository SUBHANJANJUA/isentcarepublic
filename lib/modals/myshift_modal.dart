import 'package:isentcare/modals/professiona_modal.dart';

class MyShiftModel {
  int count;
  dynamic next;
  dynamic previous;
  List<ShiftResult> results;
  int page;

  MyShiftModel({
    required this.count,
    required this.next,
    required this.previous,
    required this.results,
    required this.page,
  });
     // CopyWith method
  MyShiftModel copyWith({
    int? count,
    dynamic next,
    dynamic previous,
    List<ShiftResult>? results,
    int? page,
  }) {
    return MyShiftModel(
      count: count ?? this.count,
      next: next ?? this.next,
      previous: previous ?? this.previous,
      results: results ?? this.results,
      page: page ?? this.page,
    );
  }


  factory MyShiftModel.fromJson(Map<String, dynamic> json) {
    return MyShiftModel(
      count: json['count'],
      next: json['next'],
      previous: json['previous'],
      results: List<ShiftResult>.from(json['results'].map((x) => ShiftResult.fromJson(x))),
      page: json['page'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'count': count,
      'next': next,
      'previous': previous,
      'results': results.map((x) => x.toJson()).toList(),
      'page': page,
    };
  }
}

class ShiftResult {
  ShiftJob job;
  String status;
  int id;

  ShiftResult({
    required this.job,
    required this.status,
    required this.id,
  });

  factory ShiftResult.fromJson(Map<String, dynamic> json) {
    return ShiftResult(
      job: ShiftJob.fromJson(json['job']),
      status: json['status'],
      id: json['id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'job': job.toJson(),
      'status': status,
      'id': id,
    };
  }
}

class ShiftJob {
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

  ShiftJob({
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

  factory ShiftJob.fromJson(Map<String, dynamic> json) {
    return ShiftJob(
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


