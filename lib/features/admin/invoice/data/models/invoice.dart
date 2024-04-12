import 'dart:convert';

import 'package:bengkel_pak_bowo/features/admin/invoice/data/models/barang.dart';
import 'package:intl/intl.dart';

List<InvoiceModel> invoiceFromJson(String str) => List<InvoiceModel>.from(
    (json.decode(str) as List).map((x) => InvoiceModel.fromJson(x)));

String invoiceToJson(InvoiceModel data) => json.encode(data.toJson());

class InvoiceModel {
  final String namaPelanggan;
  final List<ServiceModel> services;
  final DateTime boughtAt;

  // Getter
  int get getTotalHarga => services.fold(
      0, (previousValue, element) => previousValue + element.harga);
  String get formattedTotalHarga =>
      NumberFormat('###,###').format(getTotalHarga);

  InvoiceModel({
    required this.namaPelanggan,
    required this.services,
    required this.boughtAt,
  });

  factory InvoiceModel.fromJson(Map<String, dynamic> json) => InvoiceModel(
        namaPelanggan: json["nama_pelanggan"],
        services: List<ServiceModel>.from(
            (json["services"] as List).map((x) => ServiceModel.fromJson(x))),
        boughtAt: DateTime.parse(json["bought_at"]),
      );

  Map<String, dynamic> toJson() => {
        "nama_pelanggan": namaPelanggan,
        "services": List<dynamic>.from(services.map((x) => x.toJson())),
        "bought_at": boughtAt.toIso8601String(),
      };
}
