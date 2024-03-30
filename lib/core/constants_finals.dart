import 'dart:math';

import 'package:bengkel_pak_bowo/features/admin/invoice/data/models/barang.dart';

// API
const String url = 'http://10.0.2.2:3000/';
final Map<String, String> endpoint = {
  'invoice': 'invoice',
};
final Map<String, String> headers = {'Content-Type': 'application/json'};

// route name
const String initialRoute = '/';
const String loginPage = '${initialRoute}login/';
const String invoicePage = '${initialRoute}invoice/';
const String makeInvoicePage = '${invoicePage}make/';
const String detailInvoicePage = '${invoicePage}detail/';
const String previewInvoicePage = '${invoicePage}preview/';

final List<BarangModel> barangs = List.generate(
  100,
  (index) => BarangModel(
    nama: 'Barang ke-$index',
    harga: Random().nextInt(50000) % 1000 * 100,
    n: 1,
  ),
);
