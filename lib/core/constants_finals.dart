import 'package:bengkel_pak_bowo/features/admin/invoice/data/models/barang.dart';
import 'package:bengkel_pak_bowo/features/admin/invoice/data/models/invoice.dart';

// route name
const String loginPage = '/login';
const String invoicePage = '/invoice';
const String detailInvoicePage = '/detailInvoice';
const String previewInvoicePage = '/previewInvoice';

// barang
final List<Invoice> invoices = [
  Invoice(
    nama: 'Fajar Riansyah Aryda Putra',
    barangs: [
      Barang(
        nama: 'Gamepad Rexus Daxa Asteria AX1 Wireless Black',
        harga: 379000,
        n: 1,
      ),
      Barang(
        nama: 'Digital Alliance Meca Air S Cerullean White',
        harga: 339000,
        n: 1,
      ),
      Barang(
        nama: 'Coffee Milk Rum M',
        harga: 19000,
        n: 2,
      ),
    ],
    date: DateTime.now(),
  ),
];
