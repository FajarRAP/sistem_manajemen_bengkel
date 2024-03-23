import 'package:bengkel_pak_bowo/core/constants_finals.dart';
import 'package:bengkel_pak_bowo/features/admin/invoice/presentation/cubit/invoice_cubit.dart';
import 'package:bengkel_pak_bowo/features/admin/invoice/presentation/pages/detail_invoice.dart';
import 'package:bengkel_pak_bowo/features/admin/invoice/presentation/pages/invoice.dart';
import 'package:bengkel_pak_bowo/features/admin/invoice/presentation/pages/preview_invoice.dart';
import 'package:bengkel_pak_bowo/features/login/view/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => InvoiceCubit()),
      ],
      child: MaterialApp(
        title: 'Bengkel Pak Bowo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xFF62C696),
          ),
          useMaterial3: true,
        ),
        initialRoute: '/',
        routes: {
          loginPage: (context) => const LoginPage(),
          invoicePage: (context) => const InvoicePage(),
          detailInvoicePage: (context) => const DetailInvoicePage(),
          previewInvoicePage: (context) => const PreviewInvoicePage(),
        },
        home: const LoginPage(),
      ),
    );
  }
}
