class CompletedShiftModel {
  int count;
  dynamic next;
  dynamic previous;
  List<CompleteResult> results;
  int page;

  CompletedShiftModel({
    required this.count,
    required this.next,
    required this.previous,
    required this.results,
    required this.page,
  });
     // CopyWith method
  CompletedShiftModel copyWith({
    int? count,
    dynamic next,
    dynamic previous,
  List<CompleteResult>? results,
    int? page,
  }) {
    return CompletedShiftModel(
      count: count ?? this.count,
      next: next ?? this.next,
      previous: previous ?? this.previous,
      results: results ?? this.results,
      page: page ?? this.page,
    );
  }

  // From JSON
  factory CompletedShiftModel.fromJson(Map<String, dynamic> json) {
    return CompletedShiftModel(
      count: json['count'],
      next: json['next'],
      previous: json['previous'],
      results: (json['results'] as List<dynamic>)
          .map((result) => CompleteResult.fromJson(result))
          .toList(),
      page: json['page'],
    );
  }

  // To JSON
  Map<String, dynamic> toJson() {
    return {
      'count': count,
      'next': next,
      'previous': previous,
      'results': results.map((result) => result.toJson()).toList(),
      'page': page,
    };
  }
}

class CompleteResult {
  int id;
  double pay;
  String? punchIn;
  bool? noBreak;
  String position;
  String facility;
  int facilityId;
  String? punchOut;
  String totalHours;
  DateTime date;
  String? timing;

  CompleteResult({
    required this.id,
    required this.pay,
     this.punchIn,
     this.noBreak,
    required this.position,
    required this.facility,
    required this.facilityId,
     this.punchOut,
    required this.totalHours,
    required this.date,
     this.timing,
  });

  // From JSON
  factory CompleteResult.fromJson(Map<String, dynamic> json) {
    return CompleteResult(
      id: json['id'],
      pay: (json['pay'] as num)
          .toDouble(), // Handle integer to double conversion
      punchIn: json['punch_in'],
      noBreak: json['break_shift'],
      position: json['position'],
      facility: json['facility'],
      facilityId: json['facility_id'],
      punchOut: json['punch_out'],
      totalHours: json['total_hours'],
      date: DateTime.parse(json['date']),
      timing: json['timing'],
    );
  }

  // To JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'pay': pay,
      'punch_in': punchIn,
      'break_shift': noBreak,
      'position': position,
      'facility': facility,
      'facility_id': facilityId,
      'punch_out': punchOut,
      'total_hours': totalHours,
      'date': date.toIso8601String(),
      'timing': timing,
    };
  }
}
