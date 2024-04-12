import 'package:bengkel_pak_bowo/features/admin/invoice/data/models/barang.dart';

// API
const String url = 'https://bengkel-pak-bowo-services.vercel.app/';
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

final List<BarangModel> items = [
  BarangModel(nama: 'Cat Full Body', harga: 12000000),
  BarangModel(nama: 'Cat Per Panel', harga: 700000),
  BarangModel(nama: 'Poles Cat Body', harga: 800000),
  BarangModel(nama: 'Servis AC', harga: 1100000),
  BarangModel(nama: 'Tune Up', harga: 600000),
  BarangModel(nama: 'Modif Body Full Cat', harga: 15000000),
  BarangModel(nama: 'Ganti Kapas Kopling', harga: 500000),
];
