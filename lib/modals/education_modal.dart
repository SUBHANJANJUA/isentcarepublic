class EducationModel {
  int? id;
  DateTime? createdAt;
  DateTime? updatedAt;
  String state;
  String institute;
  String degree;
  String majors;
  String city;
  DateTime startDate;
  DateTime endDate;
  double gpa;
  Country? country;

  EducationModel({
     this.id,
     this.createdAt,
     this.updatedAt,
    required this.state,
    required this.institute,
    required this.degree,
    required this.majors,
    required this.city,
    required this.startDate,
    required this.endDate,
    required this.gpa,
     this.country,
  });
  // fromJson factory constructor
  factory EducationModel.fromJson(Map<String, dynamic> json) {
    return EducationModel(
      id: json['id'] ?? 0,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : DateTime.now(),
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'])
          : DateTime.now(),
      state: json['state'] ?? '',
      institute: json['institute'] ?? '',
      degree: json['degree'] ?? '',
      majors: json['majors'] ?? '',
      city: json['city'] ?? '',
      startDate: json['start_date'] != null
          ? DateTime.parse(json['start_date'])
          : DateTime.now(),
      endDate: json['end_date'] != null
          ? DateTime.parse(json['end_date'])
          : DateTime.now(),
      gpa: json['gpa'] != null ? json['gpa'].toDouble() : 0.0,
      country: json['country'] != null
          ? Country.fromJson(json['country'])
          : Country(id: 0, name: ''),
    );
  }

  // toJson method
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'createdAt': createdAt!.toIso8601String(),
      'updatedAt': updatedAt!.toIso8601String(),
      'state': state,
      'institute': institute,
      'degree': degree,
      'majors': majors,
      'city': city,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
      'gpa': gpa,
      'country': country!.toJson(),
    };
  }
  // Override toString for logging all values
  @override
  String toString() {
    return 'EducationModel(id: $id, createdAt: $createdAt, updatedAt: $updatedAt, state: $state, institute: $institute, degree: $degree, majors: $majors, city: $city, startDate: $startDate, endDate: $endDate, gpa: $gpa, country: $country)';
  }
}

class Country {
  int id;
  String name;

  Country({
    required this.id,
    required this.name,
  });

  // fromJson factory constructor
  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(
      id: json['id'],
      name: json['name'],
    );
  }

  // toJson method
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
  // Override toString method
  @override
  String toString() {
    return '{id: $id, name: $name}';
  }
}
