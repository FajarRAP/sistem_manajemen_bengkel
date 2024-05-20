import 'package:bengkel_pak_bowo/core/constants_finals.dart';
import 'package:bengkel_pak_bowo/features/admin/transaction/presentation/cubit/invoice_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

class DetailInvoicePage extends StatelessWidget {
  const DetailInvoicePage({super.key});

  @override
  Widget build(BuildContext context) {
    final InvoiceCubit invoiceCubit = context.read<InvoiceCubit>();
    final color = Theme.of(context).colorScheme;

    return Scaffold(
      body: Container(
        color: Colors.transparent,
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.vertical(
                  bottom: Radius.circular(40),
                ),
                color: color.primary,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              width: double.infinity,
              height: 230,
              child: Align(
                alignment: const Alignment(0, -.6),
                child: Text(
                  'Detail Invoice',
                  style: GoogleFonts.plusJakartaSans(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ),
            Positioned(
              top: 125,
              left: 0,
              right: 0,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 3,
                        spreadRadius: 0,
                        offset: const Offset(0, 1),
                        color: Colors.black.withOpacity(.1)),
                    BoxShadow(
                        blurRadius: 5,
                        spreadRadius: 0,
                        offset: const Offset(0, 5),
                        color: Colors.black.withOpacity(.09)),
                  ],
                ),
                margin: const EdgeInsets.symmetric(horizontal: 40),
                padding: const EdgeInsets.fromLTRB(20, 40, 20, 10),
                width: double.infinity,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Cetak Invoice',
                      style: GoogleFonts.plusJakartaSans(
                          color: color.primary,
                          fontSize: 20,
                          fontWeight: FontWeight.w800),
                    ),
                    const Gap(40),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          invoiceCubit.getInvoice.namaPelanggan,
                          style: GoogleFonts.plusJakartaSans(
                              fontWeight: FontWeight.w500),
                        ),
                        Text(
                          invoiceCubit.getInvoice.getDate,
                          style: GoogleFonts.plusJakartaSans(
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                    const Gap(12),
                    const Divider(),
                    const Gap(36),
                    Container(
                      color: const Color(0xFF88AAF1).withOpacity(.4),
                      padding: const EdgeInsets.all(8),
                      width: double.infinity,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Antrian',
                            style: GoogleFonts.plusJakartaSans(
                                fontWeight: FontWeight.w600),
                          ),
                          Text(
                            '8',
                            style: GoogleFonts.plusJakartaSans(
                                fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                    const Gap(12),
                    ListView.separated(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      itemBuilder: (context, index) => Container(
                        color: const Color(0xFF88AAF1).withOpacity(.4),
                        padding: const EdgeInsets.all(8),
                        width: double.infinity,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Layanan',
                              style: GoogleFonts.plusJakartaSans(
                                  fontWeight: FontWeight.w600),
                            ),
                            Text(
                              invoiceCubit.getServices[index].nama,
                              style: GoogleFonts.plusJakartaSans(
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                      separatorBuilder: (context, index) => const Gap(12),
                      itemCount: invoiceCubit.getServices.length,
                    ),
                    const Gap(12),
                    Container(
                      color: const Color(0xFF88AAF1).withOpacity(.4),
                      padding: const EdgeInsets.all(8),
                      width: double.infinity,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Total Harga',
                            style: GoogleFonts.plusJakartaSans(
                                fontWeight: FontWeight.w600),
                          ),
                          Text(
                            'Rp. ${invoiceCubit.formattedTotalHarga}',
                            style: GoogleFonts.plusJakartaSans(
                                fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                    const Gap(72),
                    Align(
                      alignment: Alignment.centerRight,
                      child: ElevatedButton(
                        onPressed: () =>
                            Navigator.of(context).pushNamed(previewInvoicePage),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: color.primary,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4))),
                        child: const Text(
                          'Cetak',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w800),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
