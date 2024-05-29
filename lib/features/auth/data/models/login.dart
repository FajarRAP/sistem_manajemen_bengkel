import 'dart:convert';

import '../../domain/entities/user.dart';

LoginModel loginFromJson(String str) => LoginModel.fromJson(jsonDecode(str));

class LoginModel extends User {
  LoginModel({
    super.name = '',
    required super.username,
    required super.password,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        username: json["username"],
        password: json["password"],
      );

  Map<String, dynamic> toJson() => {
        "username": username,
        "password": password,
      };
}
