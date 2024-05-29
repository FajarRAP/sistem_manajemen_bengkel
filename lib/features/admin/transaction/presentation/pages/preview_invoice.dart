import '../cubit/invoice_cubit.dart';
import '../widgets/make_invoice_pdf.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:printing/printing.dart';

class PreviewInvoicePage extends StatelessWidget {
  const PreviewInvoicePage({super.key});

  @override
  Widget build(BuildContext context) {
    final InvoiceCubit invoiceCubit = context.read<InvoiceCubit>();

    return Scaffold(
      body: PdfPreview(
        build: (format) => makePDF(invoiceCubit.getInvoice),
      ),
    );
  }
}
