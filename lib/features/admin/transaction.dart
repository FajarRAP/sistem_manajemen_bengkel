import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

import '../invoice/presentation/cubit/invoice_cubit.dart';
import 'widgets/item_transaksi.dart';

class TransactionPage extends StatelessWidget {
  const TransactionPage({super.key});

  @override
  Widget build(BuildContext context) {
    final invoiceCubit = context.read<InvoiceCubit>();
    final color = Theme.of(context).colorScheme;

    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              backgroundColor: color.primary,
              centerTitle: true,
              leading: const SizedBox(),
              title: Text(
                'Riwayat Transaksi',
                style: GoogleFonts.plusJakartaSans(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ];
        },
        body: BlocBuilder<InvoiceCubit, InvoiceState>(
          bloc: invoiceCubit..getInvoices(),
          buildWhen: (previous, current) => current is GetInvoice,
          builder: (context, state) {
            print(state);
            // Loading
            if (state is GetInvoiceLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            // Loaded
            if (state is GetInvoiceLoaded) {
              return RefreshIndicator(
                displacement: 10,
                onRefresh: () async => invoiceCubit.getInvoices(),
                // onRefresh: () async {},
                child: ListView.separated(
                  padding: const EdgeInsets.all(20),
                  itemBuilder: (context, index) =>
                      ItemTransaksi(invoice: state.data[index]),
                  separatorBuilder: (context, index) => const Gap(12),
                  itemCount: state.data.length,
                ),
              );
            }

            // Empty
            if (state is GetInvoiceEmpty) {
              return const Center(
                child: Text(
                  'Belum Ada Transaksi',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
              );
            }

            if (state is GetInvoiceError) {
              return Center(
                child: Text(state.message),
              );
            }

            return const SizedBox();
          },
        ),
      ),
    );
  }
}
