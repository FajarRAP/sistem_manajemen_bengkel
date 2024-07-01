import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../core/common/widgets/month_selector.dart';
import '../../../core/common/widgets/profile_content_title.dart';
import '../../auth/presentation/cubit/auth_cubit.dart';
import '../../invoice/presentation/cubit/invoice_cubit.dart';

class ExpenseMonthSelector extends StatefulWidget {
  const ExpenseMonthSelector({
    super.key,
  });

  @override
  State<ExpenseMonthSelector> createState() => _ExpenseMonthSelectorState();
}

class _ExpenseMonthSelectorState extends State<ExpenseMonthSelector> {
  int month = DateTime.now().month;

  @override
  Widget build(BuildContext context) {
    final authCubit = context.read<AuthCubit>();
    final invoiceCubit = context.read<InvoiceCubit>();

    return Column(
      children: [
        const ProfileContentTitle(
          title: 'Pengeluaran',
        ),
        const Gap(16),
        MonthSelector(
          month: month,
          decrement: () => month > 1 ? setState(() => --month) : null,
          increment: () => month < 12 ? setState(() => ++month) : null,
        ),
        const Gap(32),
        BlocBuilder<InvoiceCubit, InvoiceState>(
          bloc: invoiceCubit
            ..getExpenseAtMonth(authCubit.getUsername, '${month - 1}'),
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
                'Belum Ada Pengeluaran',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              );
            }

            return const SizedBox();
          },
        ),
      ],
    );
  }
}
