import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

import '../admin/widgets/item_transaksi.dart';
import '../auth/presentation/cubit/auth_cubit.dart';
import '../invoice/presentation/cubit/invoice_cubit.dart';

class TransactionPage extends StatelessWidget {
  const TransactionPage({super.key});

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    final invoiceCubit = context.read<InvoiceCubit>();
    final authCubit = context.read<AuthCubit>();

    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverAppBar(
            automaticallyImplyLeading: false,
            backgroundColor: color.primary,
            centerTitle: true,
            title: Text(
              'Riwayat Transaksi',
              style: GoogleFonts.plusJakartaSans(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
        body: BlocBuilder<InvoiceCubit, InvoiceState>(
          bloc: invoiceCubit..getInvoiceByUsername(authCubit.getUsername),
          buildWhen: (previous, current) => current is GetInvoice,
          builder: (context, state) {
            // Loading
            if (state is GetInvoiceLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            // Loaded
            if (state is GetInvoiceLoaded) {
              return RefreshIndicator(
                displacement: 10,
                onRefresh: () async =>
                    invoiceCubit.getInvoiceByUsername(authCubit.getUsername),
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

            return const SizedBox();
          },
        ),
      ),
    );
  }
}
