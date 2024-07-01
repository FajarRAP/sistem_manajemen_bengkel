import '../../invoice/presentation/cubit/invoice_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../core/constants_finals.dart';
import '../../invoice/domain/entities/invoice_entity.dart';

class ItemTransaksi extends StatelessWidget {
  const ItemTransaksi({
    super.key,
    required this.invoice,
  });

  final Invoice invoice;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: () {
        context.read<InvoiceCubit>().invoice = invoice;
        Navigator.pushNamed(context, detailInvoicePage);
      },
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFE0E0E0).withOpacity(.4),
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        width: double.infinity,
        height: 75,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  invoice.customer.name,
                  style: GoogleFonts.plusJakartaSans(
                      fontSize: 16, fontWeight: FontWeight.w500),
                ),
                Row(
                  children: [
                    Text(
                      DateFormat('d MMMM y').format(invoice.boughtAt),
                      style: GoogleFonts.plusJakartaSans(
                          color: const Color(0xFF555555),
                          fontSize: 13,
                          fontWeight: FontWeight.w500),
                    ),
                    const Gap(6),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(7),
                          color: const Color(0xFFD9D9D9)),
                      height: 7,
                      width: 7,
                    ),
                    const Gap(6),
                    Text(
                      DateFormat('H:m').format(invoice.boughtAt),
                      style: GoogleFonts.plusJakartaSans(
                          color: const Color(0xFF555555),
                          fontSize: 13,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ],
            ),
            const Icon(Icons.arrow_forward_ios),
          ],
        ),
      ),
    );
  }
}
