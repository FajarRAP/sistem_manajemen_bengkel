import '../../domain/entities/customer_entity.dart';

class CustomerModel extends Customer {
  CustomerModel({
    required super.username,
    required super.name,
  });

  factory CustomerModel.fromJson(Map<String, dynamic> json) =>
      CustomerModel(username: json['username'], name: json['name']);

  Map<String, dynamic> toJson() => {
        "username": username,
        "name": name,
      };
}
