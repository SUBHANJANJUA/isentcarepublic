
import 'package:isentcare/resources/constants/enums.dart';

class UserModel {
  int count;
  String next;
  dynamic previous;
  List<User> results;
  int page;

  UserModel({
    required this.count,
    required this.next,
    required this.previous,
    required this.results,
    required this.page,
  });

  // fromJson method to parse JSON data into UserModel object
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      count: json['count'],
      next: json['next'],
      previous: json['previous'],
      results: (json['results'] as List)
          .map((result) => User.fromJson(result))
          .toList(),
      page: json['page'],
    );
  }

  // toJson method to convert UserModel object into JSON format
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

class User {
  int id;
  String firstName;
  String lastName;
  String phone;
  UserType type;
  String? dp;
  bool deleted;
  bool twoFactor;
  bool eec;
  bool eev;
  bool verified;

  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.type,
    required this.dp,
    required this.deleted,
    required this.twoFactor,
    required this.eec,
    required this.eev,
    required this.verified,
  });

  // fromJson method to parse JSON data into Result object
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      phone: json['phone'],
      type: UserType.values.firstWhere((e) => e.toString() == 'Type.' + json['type']),
      dp: json['dp'],
      deleted: json['deleted'],
      twoFactor: json['twoFactor'],
      eec: json['eec'],
      eev: json['eev'],
      verified: json['verified'],
    );
  }

  // toJson method to convert Result object into JSON format
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'phone': phone,
      'type': type.toString().split('.').last,
      'dp': dp,
      'deleted': deleted,
      'twoFactor': twoFactor,
      'eec': eec,
      'eev': eev,
      'verified': verified,
    };
  }
}