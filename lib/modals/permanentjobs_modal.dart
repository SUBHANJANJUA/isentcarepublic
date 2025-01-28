class PermanentJobsModel {
  int count;
  dynamic next;
  dynamic previous;
  List<Result> results;
  int page;

  PermanentJobsModel({
    required this.count,
    required this.next,
    required this.previous,
    required this.results,
    required this.page,
  });
      // CopyWith method
  PermanentJobsModel copyWith({
    int? count,
    dynamic next,
    dynamic previous,
    List<Result>? results,
    int? page,
  }) {
    return PermanentJobsModel(
      count: count ?? this.count,
      next: next ?? this.next,
      previous: previous ?? this.previous,
      results: results ?? this.results,
      page: page ?? this.page,
    );
  }

  // Convert PermanentJobsModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'count': count,
      'next': next,
      'previous': previous,
      'results': results.map((result) => result.toJson()).toList(),
      'page': page,
    };
  }

  // Convert JSON to PermanentJobsModel
  factory PermanentJobsModel.fromJson(Map<String, dynamic> json) {
    return PermanentJobsModel(
      count: json['count'] ?? 0,
      next: json['next'],
      previous: json['previous'],
      results: (json['results'] as List<dynamic>? ?? [])
          .map((item) => Result.fromJson(item))
          .toList(),
      page: json['page'] ?? 1,
    );
  }
}

class Result {
  int id;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic facilityName;
  Profession? profession; // Made nullable
  String duration;
  bool fixTime;
  bool traAssign;
  bool perPlace;
  String detail;
  String status;
  Speciality speciality;
  String state;
  String facility;
  int facilityId;

  Result({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    this.facilityName,
    this.profession, // Nullable profession
    required this.duration,
    required this.fixTime,
    required this.traAssign,
    required this.perPlace,
    required this.detail,
    required this.status,
    required this.speciality,
    required this.state,
    required this.facility,
    required this.facilityId,
  });

  // Convert Result to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'facility_name': facilityName,
      'profession': profession?.toJson(), // Nullable handling
      'duration': duration,
      'fix_time': fixTime,
      'tra_assign': traAssign,
      'per_place': perPlace,
      'detail': detail,
      'status': status,
      'speciality': speciality.toJson(),
      'state': state,
      'facility': facility,
      'facility_id': facilityId,
    };
  }

  // Convert JSON to Result
  factory Result.fromJson(Map<String, dynamic> json) {
    return Result(
      id: json['id'] ?? 0,
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      facilityName: json['facility_name'],
      profession: json['profession'] != null
          ? Profession.fromJson(json['profession'])
          : null, // Handle nullable profession
      duration: json['duration'] ?? '',
      fixTime: json['fix_time'] ?? false,
      traAssign: json['tra_assign'] ?? false,
      perPlace: json['per_place'] ?? false,
      detail: json['detail'] ?? '',
      status: json['status'] ?? '',
      speciality: Speciality.fromJson(json['speciality']),
      state: json['state'] ?? '',
      facility: json['facility'] ?? '',
      facilityId: json['facility_id'] ?? 0,
    );
  }
}

class Profession {
  String name;

  Profession({
    required this.name,
  });

  // Convert Profession to JSON
  Map<String, dynamic> toJson() {
    return {
      'name': name,
    };
  }

  // Convert JSON to Profession
  factory Profession.fromJson(Map<String, dynamic> json) {
    return Profession(
      name: json['name'] ?? '',
    );
  }
}

class Speciality {
  int id;
  String name;

  Speciality({
    required this.id,
    required this.name,
  });

  // Convert Speciality to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }

  // Convert JSON to Speciality
  factory Speciality.fromJson(Map<String, dynamic> json) {
    return Speciality(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
    );
  }
}
