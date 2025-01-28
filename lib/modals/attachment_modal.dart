class AttachmentModel {
  int id;
  String type;
  DateTime createdAt;
  DateTime updatedAt;
  DateTime? expiryDate;
  String file;
  int professional;

  AttachmentModel({
    required this.id,
    required this.type,
    required this.createdAt,
    required this.updatedAt,
    required this.expiryDate,
    required this.file,
    required this.professional,
  });

  // fromJson method
  factory AttachmentModel.fromJson(Map<String, dynamic> json) {
    return AttachmentModel(
      id: json['id'] ,
      type: json['type'] ?? '',
      createdAt: DateTime.parse(json['created_at']) ,
      updatedAt: DateTime.parse(json['updated_at']),
      expiryDate: json['expiry_date'] != null ? DateTime.parse(json['expiry_date']) :  DateTime.now(),
      file: json['file'] ?? '',
      professional: json['professional']??'',
    );
  }

  // toJson method
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'expiryDate': expiryDate?.toIso8601String(),
      'file': file,
      'professional': professional,
    };
  }
}
