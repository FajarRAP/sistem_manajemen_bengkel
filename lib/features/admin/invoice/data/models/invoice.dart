import 'dart:convert';

import 'package:bengkel_pak_bowo/features/admin/invoice/data/models/barang.dart';

List<InvoiceModel> invoiceFromJson(String str) => List<InvoiceModel>.from(
    json.decode(str).map((x) => InvoiceModel.fromJson(x)));

String invoiceToJson(InvoiceModel data) => json.encode(data.toJson());

class InvoiceModel {
  final String namaPelanggan;
  final List<BarangModel> barangs;
  final DateTime boughtAt;

  // Getter
  int get getTotalHarga => barangs.fold(
      0, (previousValue, element) => previousValue + element.harga);

  InvoiceModel({
    required this.namaPelanggan,
    required this.barangs,
    required this.boughtAt,
  });

  factory InvoiceModel.fromJson(Map<String, dynamic> json) => InvoiceModel(
        namaPelanggan: json["nama_pelanggan"],
        barangs: List<BarangModel>.from(
            json["barangs"].map((x) => BarangModel.fromJson(x))),
        boughtAt: DateTime.parse(json["bought_at"]),
      );

  Map<String, dynamic> toJson() => {
        "nama_pelanggan": namaPelanggan,
        "barangs": List<dynamic>.from(barangs.map((x) => x.toJson())),
        "bought_at": boughtAt.toIso8601String(),
      };
}
