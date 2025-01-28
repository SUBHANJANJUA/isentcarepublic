class ShiftModel {
  int count;
  dynamic next;
  dynamic previous;
  List<Result> results;
  int page;

  ShiftModel({
    required this.count,
    required this.next,
    required this.previous,
    required this.results,
    required this.page,
  });
       // CopyWith method
  ShiftModel copyWith({
    int? count,
    dynamic next,
    dynamic previous,
    List<Result>? results,
    int? page,
  }) {
    return ShiftModel(
      count: count ?? this.count,
      next: next ?? this.next,
      previous: previous ?? this.previous,
      results: results ?? this.results,
      page: page ?? this.page,
    );
  }

  factory ShiftModel.fromJson(Map<String, dynamic> json) {
    return ShiftModel(
      count: json['count'],
      next: json['next'],
      previous: json['previous'],
      results: List<Result>.from(json['results'].map((x) => Result.fromJson(x))),
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

class Result {
  int id;
  double pay;
  String punchIn;
  bool noBreak;
  String position;
  String facility;
  int facilityId;
  String? punchOut;
  String totalHours;
  DateTime date;
  String timing;

  Result({
    required this.id,
    required this.pay,
    required this.punchIn,
    required this.noBreak,
    required this.position,
    required this.facility,
    required this.facilityId,
     this.punchOut,
    required this.totalHours,
    required this.date,
    required this.timing,
  });

  factory Result.fromJson(Map<String, dynamic> json) {
    return Result(
      id: json['id'],
      pay: json['pay'].toDouble(),
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
