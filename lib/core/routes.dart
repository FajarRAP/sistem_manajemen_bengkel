import 'package:bengkel_pak_bowo/queue/presentation/pages/queue.dart';
import 'package:flutter/material.dart';

import '../features/admin/transaction/presentation/pages/detail_invoice.dart';
import '../features/admin/transaction/presentation/pages/make_invoice.dart';
import '../features/admin/transaction/presentation/pages/preview_invoice.dart';
import '../features/auth/presentation/pages/login.dart';
import '../features/auth/presentation/pages/register.dart';
import '../init_screens/fragment_view.dart';
import 'constants_finals.dart';

class Routes {
  static Map<String, Widget Function(BuildContext context)> generateRoute = {
    loginPage: (context) => const LoginPage(),
    registerPage: (context) => const RegisterPage(),
    makeInvoicePage: (context) => const MakeInvoicePage(),
    detailInvoicePage: (context) => const DetailInvoicePage(),
    previewInvoicePage: (context) => const PreviewInvoicePage(),
    homePage: (context) => const FragmentPage(),
    queuePage: (context) => const QueuePage(),
  };
}
