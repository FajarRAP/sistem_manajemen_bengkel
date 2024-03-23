import 'package:flutter/material.dart';

import '../features/admin/invoice/presentation/pages/invoice.dart';
import '../features/login/view/login_page.dart';
import 'constants_finals.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case loginPage:
        return MaterialPageRoute(builder: (context) => const LoginPage());
      case invoicePage:
        return MaterialPageRoute(builder: (context) => const InvoicePage());
    }
    return MaterialPageRoute(
      builder: (context) => const Scaffold(
        body: Center(
          child: Text('Halaman Tidak Tersedia'),
        ),
      ),
    );
  }
}
