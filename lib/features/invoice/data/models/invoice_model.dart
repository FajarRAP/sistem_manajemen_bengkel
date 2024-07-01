import '../../domain/entities/invoice_entity.dart';
import 'customer_model.dart';
import 'service_model.dart';

class InvoiceModel extends Invoice {
  InvoiceModel({
    required super.queueNum,
    required super.customer,
    required super.service,
    required super.boughtAt,
  });

  factory InvoiceModel.fromJson(Map<String, dynamic> json) => InvoiceModel(
        queueNum: json['queue_no'],
        customer: CustomerModel.fromJson(json['customer']),
        service: ServiceModel.fromJson(json['service']),
        boughtAt: DateTime.parse(json["bought_at"]),
      );

  Map<String, dynamic> toJson() => {
        "queue_no": queueNum,
        "customer": {
          "username": customer.username,
          "name": customer.name,
        },
        "service": {
          "name": service.name,
          "price": service.price,
        },
        "bought_at": DateTime.now().toIso8601String(),
      };
}