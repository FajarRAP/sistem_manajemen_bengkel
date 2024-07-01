import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../core/common/widgets/month_selector.dart';
import '../../../core/common/widgets/profile_content_title.dart';
import '../../invoice/presentation/cubit/invoice_cubit.dart';

class IncomeMonthSelector extends StatefulWidget {
  const IncomeMonthSelector({super.key});

  @override
  State<IncomeMonthSelector> createState() => _IncomeMonthSelectorState();
}

class _IncomeMonthSelectorState extends State<IncomeMonthSelector> {
  int month = DateTime.now().month;

  @override
  Widget build(BuildContext context) {
    final invoiceCubit = context.read<InvoiceCubit>();
    return Column(
      children: [
        const ProfileContentTitle(
          title: 'Pemasukan',
        ),
        const Gap(16),
        MonthSelector(
          month: month,
          decrement: () => month > 1 ? setState(() => --month) : null,
          increment: () => month < 12 ? setState(() => ++month) : null,
        ),
        const Gap(32),
        BlocBuilder<InvoiceCubit, InvoiceState>(
          bloc: invoiceCubit..getIncomeAtMonth('${month - 1}'),
          buildWhen: (previous, current) => current is GetTransaction,
          builder: (context, state) {
            if (state is GetTransactionLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is GetTransactionLoaded) {
              return Text(
                'Rp. ${NumberFormat.decimalPattern('id').format(state.amount)}',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 28,
                  fontWeight: FontWeight.w500,
                ),
              );
            }

            if (state is GetTransactionEmpty) {
              return Text(
                'Belum Ada Pemasukan',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              );
            }
            return const SizedBox();
          },
        )
      ],
    );
  }
}
