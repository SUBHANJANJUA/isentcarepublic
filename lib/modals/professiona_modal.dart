class ProfessionModel {
  int count;
  String next;
  dynamic previous;
  List<Profession> results;
  int page;

  ProfessionModel({
    required this.count,
    required this.next,
    required this.previous,
    required this.results,
    required this.page,
  });

  // Convert JSON to ProfessionModel object
  factory ProfessionModel.fromJson(Map<String, dynamic> json) {
    return ProfessionModel(
      count: json['count'],
      next: json['next'],
      previous: json['previous'],
      results: (json['results'] as List)
          .map((resultJson) => Profession.fromJson(resultJson))
          .toList(),
      page: json['page'],
    );
  }

  // Convert ProfessionModel object to JSON
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

class Profession {
  int id;
  String name;

  Profession({
    required this.id,
    required this.name,
  });

  // Convert JSON to Result object
  factory Profession.fromJson(Map<String, dynamic> json) {
    return Profession(
      id: json['id'],
      name: json['name'],
    );
  }

  // Convert Result object to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}
