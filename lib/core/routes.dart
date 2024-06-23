import 'package:flutter/material.dart';

import '../features/auth/presentation/pages/login.dart';
import '../features/auth/presentation/pages/register.dart';
import '../features/invoice/presentation/pages/detail_invoice.dart';
import '../features/invoice/presentation/pages/make_invoice.dart';
import '../features/invoice/presentation/pages/preview_invoice.dart';
import '../features/queue/presentation/pages/queue.dart';
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
