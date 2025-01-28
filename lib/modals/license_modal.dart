class LicenseModel {
  int? id;
  DateTime? createdAt;
  DateTime? updatedAt;
  String number;
  DateTime expiryDate;
  PrimaryState profession;
  PrimaryState? primaryState;
  List<PrimaryState> state;

  LicenseModel({
     this.id,
     this.createdAt,
     this.updatedAt,
    required this.number,
    required this.expiryDate,
    required this.profession,
     this.primaryState,
    required this.state,
  });

  // Factory constructor to parse JSON for a single LicenseModel object
  factory LicenseModel.fromJson(Map<String, dynamic> json) {
    return LicenseModel(
      id: json['id'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      number: json['number'],
      expiryDate: DateTime.parse(json['expiry_date']),
      profession: PrimaryState.fromJson(json['profession']),
      primaryState: PrimaryState.fromJson(json['primary_state']),
      state: (json['state'] as List)
          .map((item) => PrimaryState.fromJson(item))
          .toList(),
    );
  }

  // Static method to parse a list of LicenseModel objects
  static List<LicenseModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => LicenseModel.fromJson(json)).toList();
  }

  // Converts LicenseModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
      'number': number,
      'expiry_date': expiryDate.toIso8601String(),
      'profession': profession.toJson(),
      'primary_state': primaryState!.toJson(),
      'state': state.map((item) => item.toJson()).toList(),
    };
  }
}

class PrimaryState {
  int id;
  String name;

  PrimaryState({
    required this.id,
    required this.name,
  });

  // Factory constructor to parse JSON for a single PrimaryState object
  factory PrimaryState.fromJson(Map<String, dynamic> json) {
    return PrimaryState(
      id: json['id'],
      name: json['name'],
    );
  }

  // Converts PrimaryState to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}
