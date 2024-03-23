import 'package:bengkel_pak_bowo/core/constants_finals.dart';
import 'package:bengkel_pak_bowo/features/admin/invoice/presentation/cubit/invoice_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class InvoicePage extends StatelessWidget {
  const InvoicePage({super.key});

  @override
  Widget build(BuildContext context) {
    final InvoiceCubit invoiceCubit = context.read<InvoiceCubit>();

    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            const SliverAppBar(
              centerTitle: true,
              title: Text('Transaksi'),
            ),
          ];
        },
        body: ListView.builder(
          itemBuilder: (context, index) {
            return ListTile(
              onTap: () {
                invoiceCubit.invoice = invoices[index];
                Navigator.of(context).pushNamed('/detailInvoice');
              },
              subtitle: Text(
                DateFormat('d-M-y H:m').format(invoices[index].date),
              ), // Isi nanti dengan tanggal transaksi
              title: Text(invoices[index].nama),
              trailing: Text(
                'Rp. ${invoices[index].getTotalHarga()}',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            );
          },
          itemCount: invoices.length,
        ),
      ),
    );
  }
}
