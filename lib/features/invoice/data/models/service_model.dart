import '../../domain/entities/service_entity.dart';

class ServiceModel extends Service {
  ServiceModel({
    required super.name,
    required super.price,
  });

  factory ServiceModel.fromJson(Map<String, dynamic> json) =>
      ServiceModel(name: json['name'], price: json['price']);

  Map<String, dynamic> toJson() => {
        "name": name,
        "price": price,
      };
}
