import 'package:bengkel_pak_bowo/core/constants_finals.dart';
import 'package:bengkel_pak_bowo/features/admin/invoice/presentation/pages/detail_invoice.dart';
import 'package:bengkel_pak_bowo/features/admin/invoice/presentation/pages/invoice.dart';
import 'package:bengkel_pak_bowo/features/admin/invoice/presentation/pages/make_invoice.dart';
import 'package:bengkel_pak_bowo/features/admin/invoice/presentation/pages/preview_invoice.dart';
import 'package:bengkel_pak_bowo/features/auth/presentation/pages/login.dart';
import 'package:flutter/material.dart';

class Routes {
  static Map<String, Widget Function(BuildContext context)> generateRoute = {
    loginPage: (context) => const LoginPage(),
    invoicePage: (context) => const InvoicePage(),
    makeInvoicePage: (context) => const MakeInvoicePage(),
    detailInvoicePage: (context) => const DetailInvoicePage(),
    previewInvoicePage: (context) => const PreviewInvoicePage(),
  };
}
