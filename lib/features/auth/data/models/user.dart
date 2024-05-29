import 'dart:convert';

import '../../domain/entities/user.dart';

UserModel userFromJson(String str) => UserModel.fromJson(jsonDecode(str));

class UserModel extends User {
  UserModel({
    required super.name,
    required super.username,
    required super.password,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        name: json["name"],
        username: json["username"],
        password: json["password"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "username": username,
        "password": password,
      };
}
