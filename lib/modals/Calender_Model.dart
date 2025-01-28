class CalenderModel {
  Job? job;
  String? status;
  int? id;

  CalenderModel({this.job, this.status, this.id});

  CalenderModel.fromJson(Map<String, dynamic> json) {
    job = json['job'] != null ? new Job.fromJson(json['job']) : null;
    status = json['status'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.job != null) {
      data['job'] = this.job!.toJson();
    }
    data['status'] = this.status;
    data['id'] = this.id;
    return data;
  }
}

class Job {
  int? id;
  String? createdAt;
  String? updatedAt;
  String? startDate;
  String? timing;
  Profession? profession;
  String? state;
  double? billRate;
  String? facility;
  int? facilityId;

  Job(
      {this.id,
      this.createdAt,
      this.updatedAt,
      this.startDate,
      this.timing,
      this.profession,
      this.state,
      this.billRate,
      this.facility,
      this.facilityId});

  Job.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    startDate = json['start_date'];
    timing = json['timing'];
    profession = json['profession'] != null
        ? new Profession.fromJson(json['profession'])
        : null;
    state = json['state'];
    billRate = json['bill_rate'];
    facility = json['facility'];
    facilityId = json['facility_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['start_date'] = this.startDate;
    data['timing'] = this.timing;
    if (this.profession != null) {
      data['profession'] = this.profession!.toJson();
    }
    data['state'] = this.state;
    data['bill_rate'] = this.billRate;
    data['facility'] = this.facility;
    data['facility_id'] = this.facilityId;
    return data;
  }
}

class Profession {
  int? id;
  String? name;

  Profession({this.id, this.name});

  Profession.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}
