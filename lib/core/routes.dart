import 'package:bengkel_pak_bowo/core/constants_finals.dart';
import 'package:bengkel_pak_bowo/features/admin/transaction/presentation/pages/detail_invoice.dart';
import 'package:bengkel_pak_bowo/features/admin/transaction/presentation/pages/transaction.dart';
import 'package:bengkel_pak_bowo/features/admin/transaction/presentation/pages/make_invoice.dart';
import 'package:bengkel_pak_bowo/features/admin/transaction/presentation/pages/preview_invoice.dart';
import 'package:bengkel_pak_bowo/features/auth/presentation/pages/register.dart';
import 'package:bengkel_pak_bowo/features/auth/presentation/pages/login.dart';
import 'package:bengkel_pak_bowo/init_screens/fragment_view.dart';
import 'package:flutter/material.dart';

class Routes {
  static Map<String, Widget Function(BuildContext context)> generateRoute = {
    loginPage: (context) => const LoginPage(),
    registerPage: (context) => const RegisterPage(),
    makeInvoicePage: (context) => const MakeInvoicePage(),
    detailInvoicePage: (context) => const DetailInvoicePage(),
    previewInvoicePage: (context) => const PreviewInvoicePage(),
    homePage: (context) => const FragmentPage(),
  };
}
