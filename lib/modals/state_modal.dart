class StateModel {
  int count;
  String next;
  dynamic previous;
  List<Result> results;
  int page;

  StateModel({
    required this.count,
    required this.next,
    required this.previous,
    required this.results,
    required this.page,
  });

  // fromJson method to convert JSON to StateModel
  factory StateModel.fromJson(Map<String, dynamic> json) {
    return StateModel(
      count: json['count'],
      next: json['next'],
      previous: json['previous'],
      results: (json['results'] as List)
          .map((result) => Result.fromJson(result))
          .toList(),
      page: json['page'],
    );
  }

  // toJson method to convert StateModel to JSON
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

class Result {
  int id;
  String name;

  Result({
    required this.id,
    required this.name,
  });

  // fromJson method to convert JSON to Result
  factory Result.fromJson(Map<String, dynamic> json) {
    return Result(
      id: json['id'],
      name: json['name'],
    );
  }

  // toJson method to convert Result to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}
