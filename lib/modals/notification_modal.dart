class NotificationModel {
  int count;
  dynamic next;
  dynamic previous;
  List<Result> results;
  int page;

  NotificationModel({
    required this.count,
    required this.next,
    required this.previous,
    required this.results,
    required this.page,
  });
  // CopyWith method
  NotificationModel copyWith({
    int? count,
    dynamic next,
    dynamic previous,
    List<Result>? results,
    int? page,
  }) {
    return NotificationModel(
      count: count ?? this.count,
      next: next ?? this.next,
      previous: previous ?? this.previous,
      results: results ?? this.results,
      page: page ?? this.page,
    );
  }

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      count: json['count'],
      next: json['next'],
      previous: json['previous'],
      results: (json['results'] as List)
          .map((result) => Result.fromJson(result))
          .toList(),
      page: json['page'],
    );
  }
}

class Result {
  int id;
  DateTime createdAt;
  DateTime updatedAt;
  String message;
  int user;

  Result({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.message,
    required this.user,
  });

  factory Result.fromJson(Map<String, dynamic> json) {
    return Result(
      id: json['id'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      message: json['message'],
      user: json['user'],
    );
  }
}
