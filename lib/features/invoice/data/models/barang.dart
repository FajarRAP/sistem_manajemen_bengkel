import 'dart:convert';

import 'package:intl/intl.dart';

ServiceModel barangFromJson(String str) =>
    ServiceModel.fromJson(json.decode(str));

String barangToJson(ServiceModel data) => json.encode(data.toJson());

class ServiceModel {
  final String nama;
  final int harga;

  // Getter
  String get barangAsString => nama;
  String get formattedHarga => NumberFormat('###,###').format(harga);

  ServiceModel({
    required this.nama,
    required this.harga,
  });

  factory ServiceModel.fromJson(Map<String, dynamic> json) => ServiceModel(
        nama: json["nama"],
        harga: json["harga"],
      );

  Map<String, dynamic> toJson() => {
        "nama": nama,
        "harga": harga,
      };
}
