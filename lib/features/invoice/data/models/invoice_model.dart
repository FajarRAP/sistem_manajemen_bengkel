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

// class InvoiceModel {
//   final String namaPelanggan;
//   final List<ServiceModel> services;
//   final DateTime boughtAt;

//   // Getter
//   int get getTotalHarga => services.fold(
//       0, (previousValue, element) => previousValue + element.harga);
//   String get formattedTotalHarga =>
//       NumberFormat('###,###').format(getTotalHarga);
//   String get getDate => DateFormat('d MMMM y').format(boughtAt);
//   String get getTime => DateFormat('HH:mm').format(boughtAt);

//   InvoiceModel({
//     required this.namaPelanggan,
//     required this.services,
//     required this.boughtAt,
//   });

//   factory InvoiceModel.fromJson(Map<String, dynamic> json) => InvoiceModel(
//         namaPelanggan: json["nama_pelanggan"],
//         services: List<ServiceModel>.from(
//             (json["services"] as List).map((x) => ServiceModel.fromJson(x))),
//         boughtAt: DateTime.parse(json["bought_at"]),
//       );

//   Map<String, dynamic> toJson() => {
//         "nama_pelanggan": namaPelanggan,
//         "services": List<dynamic>.from(services.map((x) => x.toJson())),
//         "bought_at": boughtAt.toIso8601String(),
//       };
// }
