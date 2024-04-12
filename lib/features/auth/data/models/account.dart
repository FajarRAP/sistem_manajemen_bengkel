import 'dart:convert';

AccountModel accountFromJson(String str) =>
    AccountModel.fromJson(jsonDecode(str));
String accountToJson(AccountModel acc) => jsonEncode(acc);

class AccountModel {
  final String name;
  final String email;
  final String password;

  AccountModel({
    required this.name,
    required this.email,
    required this.password,
  });

  factory AccountModel.fromJson(Map<String, dynamic> json) => AccountModel(
        name: json["name"],
        email: json["email"],
        password: json["password"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "password": password,
      };
}
