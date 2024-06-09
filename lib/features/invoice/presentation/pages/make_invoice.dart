import 'package:bengkel_pak_bowo/core/common/widgets/snackbar_error.dart';
import 'package:bengkel_pak_bowo/core/common/widgets/snackbar_success.dart';
import 'package:bengkel_pak_bowo/features/queue/presentation/cubit/queue_cubit.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/constants_finals.dart';
import '../../data/models/barang.dart';
import '../cubit/barang_cubit.dart';
import '../cubit/invoice_cubit.dart';

class MakeInvoicePage extends StatefulWidget {
  const MakeInvoicePage({super.key});

  @override
  State<MakeInvoicePage> createState() => _MakeInvoicePageState();
}

class _MakeInvoicePageState extends State<MakeInvoicePage> {
  @override
  Widget build(BuildContext context) {
    final barangCubit = BarangCubit();
    final invoiceCubit = context.read<InvoiceCubit>();
    final queueCubit = context.read<QueueCubit>();
    final color = Theme.of(context).colorScheme;

    return BlocListener<InvoiceCubit, InvoiceState>(
      bloc: invoiceCubit,
      listener: (context, state) {
        if (state is InvoiceErrorCreated) {
          errorSnackBar(context, state.message);
        }
        if (state is InvoiceCreated) {
          successSnackBar(context, state.message);
        }
      },
      child: Scaffold(
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
                child: const Align(
                  alignment: Alignment(0, -.5),
                  child: Text(
                    'Invoice',
                    style: TextStyle(
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
                    borderRadius: BorderRadius.circular(10),
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
                  margin: const EdgeInsets.symmetric(horizontal: 28),
                  height: 525,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        const Gap(20),
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            'Buat Invoice',
                            style: GoogleFonts.plusJakartaSans(
                                color: color.primary,
                                fontSize: 20,
                                fontWeight: FontWeight.w800),
                          ),
                        ),
                        const Gap(32),
                        BlocBuilder<QueueCubit, QueueState>(
                          buildWhen: (previous, current) =>
                              current is QueueToday,
                          builder: (context, state) {
                            if (state is QueueTodayLoaded) {
                              return Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    state.datas[queueCubit.queueIndex].name,
                                    style: GoogleFonts.plusJakartaSans(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Text(
                                    state.datas[queueCubit.queueIndex].getDate,
                                    style: GoogleFonts.plusJakartaSans(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              );
                            }
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Nama Pelanggan',
                                  style: GoogleFonts.plusJakartaSans(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500),
                                ),
                                Text(
                                  'd MMMM y',
                                  style: GoogleFonts.plusJakartaSans(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            );
                          },
                        ),
                        const Gap(18),
                        const Divider(),
                        const Gap(28),
                        Container(
                          color: const Color(0xFF88AAF1).withOpacity(.4),
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          height: 40,
                          width: double.infinity,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Antrian',
                                style: GoogleFonts.plusJakartaSans(
                                    fontSize: 16, fontWeight: FontWeight.w600),
                              ),
                              Text(
                                '1',
                                style: GoogleFonts.plusJakartaSans(
                                    fontSize: 16, fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        ),
                        const Gap(14),
                        Text(
                          'Layanan',
                          style: GoogleFonts.plusJakartaSans(
                              fontWeight: FontWeight.w600),
                        ),
                        const Gap(10),
                        DropdownSearch<ServiceModel>(
                          itemAsString: (item) => item.barangAsString,
                          items: items,
                          dropdownDecoratorProps: DropDownDecoratorProps(
                            dropdownSearchDecoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(6)),
                                  borderSide: BorderSide(color: color.outline)),
                              contentPadding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              hintText: 'Jasa',
                            ),
                          ),
                          popupProps: PopupProps.menu(
                            showSearchBox: false,
                            emptyBuilder: (context, searchEntry) =>
                                const Center(
                              child: Text(
                                'Tidak ada Data',
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          onChanged: (value) {
                            if (value != null) {
                              barangCubit.servicePicked(value);
                            }
                          },
                          validator: (value) {
                            if (value == null) {
                              return 'Mohon Isi Jasa';
                            }
                            return null;
                          },
                        ),
                        const Gap(14),
                        Text(
                          'Harga',
                          style: GoogleFonts.plusJakartaSans(
                              fontWeight: FontWeight.w600),
                        ),
                        const Gap(10),
                        BlocBuilder<BarangCubit, BarangState>(
                          bloc: barangCubit,
                          builder: (context, state) {
                            return Container(
                              decoration: BoxDecoration(
                                  border: Border.all(color: color.outline),
                                  borderRadius: BorderRadius.circular(6)),
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              width: double.infinity,
                              height: 50,
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Rp. ${barangCubit.getHarga()}',
                                  style: GoogleFonts.plusJakartaSans(
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            );
                          },
                        ),
                        const Gap(50),
                        Align(
                          alignment: Alignment.centerRight,
                          child: SizedBox(
                            width: 110,
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: color.primary,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(6))),
                              child: Text(
                                'Buat',
                                style: GoogleFonts.plusJakartaSans(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w800),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
