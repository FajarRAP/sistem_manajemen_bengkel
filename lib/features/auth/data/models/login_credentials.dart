import 'dart:convert';

LoginCredentials loginFromJson(String str) =>
    LoginCredentials.fromJson(jsonDecode(str));

String loginToJson(LoginCredentials data) => json.encode(data);

class LoginCredentials {
  final String email;
  final String password;

  LoginCredentials({required this.email, required this.password});

  factory LoginCredentials.fromJson(Map<String, dynamic> json) =>
      LoginCredentials(
        email: json["email"],
        password: json["password"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "password": password,
      };
}
