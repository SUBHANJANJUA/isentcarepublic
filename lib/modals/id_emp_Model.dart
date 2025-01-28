class IdEmpModel {
  int? id;
  String? name;

  IdEmpModel({this.id, this.name});

  IdEmpModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id ?? 0;
    data['name'] = this.name ?? '';
    return data;
  }
}
