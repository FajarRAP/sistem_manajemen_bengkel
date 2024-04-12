import 'dart:convert';

import 'package:intl/intl.dart';

BarangModel barangFromJson(String str) =>
    BarangModel.fromJson(json.decode(str));

String barangToJson(BarangModel data) => json.encode(data.toJson());

class BarangModel {
  final String nama;
  final int harga;

  // Getter
  String get barangAsString => nama;
  String get formattedHarga => NumberFormat('###,###').format(harga);

  BarangModel({
    required this.nama,
    required this.harga,
  });

  factory BarangModel.fromJson(Map<String, dynamic> json) => BarangModel(
        nama: json["nama"],
        harga: json["harga"],
      );

  Map<String, dynamic> toJson() => {
        "nama": nama,
        "harga": harga,
      };
}
