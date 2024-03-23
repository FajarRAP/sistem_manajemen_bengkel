import 'package:bengkel_pak_bowo/features/admin/invoice/data/models/barang.dart';

class Invoice {
  final String nama;
  final List<Barang> barangs;
  final DateTime date;

  int getTotalHarga() => barangs.fold(
      0, (previousValue, element) => previousValue + element.harga);

  Invoice({
    required this.nama,
    required this.barangs,
    required this.date,
  });
}
