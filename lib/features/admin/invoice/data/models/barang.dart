import 'dart:convert';

BarangModel barangFromJson(String str) =>
    BarangModel.fromJson(json.decode(str));

String barangToJson(BarangModel data) => json.encode(data.toJson());

class BarangModel {
  final String nama;
  final int harga;
  int n;

  String barangAsString() => '$nama Rp. $harga';

  // Getter
  int get getSubTotal => harga * n;

  // Setter
  set setN(final int n) => this.n = n;

  BarangModel({
    required this.nama,
    required this.harga,
    required this.n,
  });

  factory BarangModel.fromJson(Map<String, dynamic> json) => BarangModel(
        nama: json["nama"],
        harga: json["harga"],
        n: json["n"],
      );

  Map<String, dynamic> toJson() => {
        "nama": nama,
        "harga": harga,
        "n": n,
      };
}
