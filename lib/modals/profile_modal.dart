class ProfileModel {
  int id;
  String firstName;
  String lastName;
  String phone;
  String type;
  String dp;
  bool deleted;
  bool twoFactor;
  String email;
  bool eec;
  bool eev;
  Address address;
  String ssn;
  DateTime joiningDate;
  String title;
  DateTime dob;
  bool perDiem;
  bool fixTime;
  bool traAssign;
  bool perPlace;
  bool? verified;
  bool employmentCompleted;
  bool educationCompleted;
  bool attachmentCompleted;
  bool referenceCompleted;

  ProfileModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.type,
    required this.dp,
    required this.deleted,
    required this.twoFactor,
    required this.email,
    required this.eec,
    required this.eev,
    required this.address,
    required this.ssn,
    required this.joiningDate,
    required this.title,
    required this.dob,
    required this.perDiem,
    required this.fixTime,
    required this.traAssign,
    required this.perPlace,
    this.verified,
    required this.employmentCompleted,
    required this.educationCompleted,
    required this.attachmentCompleted,
    required this.referenceCompleted,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      id: json['id'],
      firstName: json['first_name'] ?? '',
      lastName: json['last_name'] ?? '',
      phone: json['phone'],
      type: json['type'],
      dp: json['dp'] ?? "",
      deleted: json['deleted'],
      twoFactor: json['two_factor'],
      email: json['email'] ?? '',
      eec: json['eec'],
      eev: json['eev'],
      address: Address.fromJson(json['address']),
      ssn: json['ssn'],
      joiningDate: DateTime.parse(json['joining_date']),
      title: json['title'],
      dob: DateTime.parse(json['dob']),
      perDiem: json['per_diem'],
      fixTime: json['fix_time'],
      traAssign: json['tra_assign'],
      perPlace: json['per_place'],
      verified: json['verified'],
      employmentCompleted: json['employment_completed'],
      educationCompleted: json['education_completed'],
      attachmentCompleted: json['attachment_completed'],
      referenceCompleted: json['reference_completed'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'first_name': firstName,
      'last_name': lastName,
      'phone': phone,
      'type': type,
      'dp': dp,
      'deleted': deleted,
      'two_factor': twoFactor,
      'email': email,
      'eec': eec,
      'eev': eev,
      'address': address.toJson(),
      'ssn': ssn,
      'joining_date': joiningDate.toIso8601String(),
      'title': title,
      'dob': dob.toIso8601String(),
      'per_diem': perDiem,
      'fix_time': fixTime,
      'tra_assign': traAssign,
      'per_place': perPlace,
      'verified': verified,
      'employment_completed': employmentCompleted,
      'education_completed': educationCompleted,
      'attachment_completed': attachmentCompleted,
      'reference_completed': referenceCompleted,
    };
  }
}

class Address {
  int id;
  DateTime createdAt;
  DateTime updatedAt;
  String address;
  String city;
  String zipCode;
  String latitude;
  String longitude;
  int state;

  Address({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.address,
    required this.city,
    required this.zipCode,
    required this.latitude,
    required this.longitude,
    required this.state,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      id: json['id'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      address: json['address'],
      city: json['city'],
      zipCode: json['zip_code'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      state: json['state'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'address': address,
      'city': city,
      'zip_code': zipCode,
      'latitude': latitude,
      'longitude': longitude,
      'state': state,
    };
  }
}
