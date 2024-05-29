import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../home/presentation/pages/home.dart';
import '../cubit/invoice_cubit.dart';

class TransactionPage extends StatelessWidget {
  const TransactionPage({super.key});

  @override
  Widget build(BuildContext context) {
    final InvoiceCubit invoiceCubit = context.read<InvoiceCubit>();
    final color = Theme.of(context).colorScheme;

    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              backgroundColor: color.primary,
              centerTitle: true,
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
          buildWhen: (previous, current) => current is ReadInvoice,
          builder: (context, state) {
            // Loading
            if (state is ReadInvoiceLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            // Loaded
            if (state is ReadInvoiceLoaded) {
              return RefreshIndicator(
                displacement: 10,
                onRefresh: () async => invoiceCubit.getInvoices(),
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
            if (state is ReadInvoiceEmpty) {
              return const Center(
                child: Text(
                  'Belum Ada Transaksi',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              );
            }

            // Error
            if (state is ReadInvoiceError) {
              return Center(
                child: TextButton(
                  onPressed: () async {
                    // print(prefs.getString('token'));
                    // await prefs.remove('token');
                    // await Future.delayed(const Duration(seconds: 1));
                    // if (!context.mounted) return;
                    // Navigator.pushReplacementNamed(context, loginPage);
                  },
                  child: Text(state.message),
                ),
              );
            }

            return Center(
              child: ElevatedButton(
                onPressed: () => invoiceCubit.getInvoices(),
                child: const Text('Ulangi'),
              ),
            );
          },
        ),
      ),
    );
  }
}
