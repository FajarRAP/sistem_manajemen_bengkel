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
  final TextEditingController pcsController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final InvoiceCubit invoiceCubit = context.read<InvoiceCubit>();
    final BarangCubit barangCubit = context.read<BarangCubit>();
    final color = Theme.of(context).colorScheme;
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    return BlocListener<InvoiceCubit, InvoiceState>(
      bloc: invoiceCubit,
      listener: (context, state) {
        if (state is InvoiceErrorCreated) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.red.shade800,
              content: Text(
                state.message,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          );
        }
        if (state is InvoiceCreated) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.green.shade800,
              content: Text(
                state.message,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          );
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Nama Pelanggan',
                              style: GoogleFonts.plusJakartaSans(
                                  fontSize: 12, fontWeight: FontWeight.w500),
                            ),
                            Text(
                              'd MMMM y',
                              style: GoogleFonts.plusJakartaSans(
                                  fontSize: 12, fontWeight: FontWeight.w500),
                            ),
                          ],
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
                              barangCubit.addBarang = value;
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
                        Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: color.outline),
                              borderRadius: BorderRadius.circular(6)),
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          width: double.infinity,
                          height: 50,
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              barangCubit.getServices.first.formattedHarga,
                              style: GoogleFonts.plusJakartaSans(
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
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
        // appBar: AppBar(
        //   centerTitle: true,
        //   title: const Text('Buat Invoice'),
        // ),
        // body: BlocBuilder<BarangCubit, BarangState>(
        //   bloc: barangCubit..getBarang(),
        //   builder: (context, state) {
        //     // Barang Added
        //     if (state is BarangLoaded) {
        //       return Column(
        //         crossAxisAlignment: CrossAxisAlignment.start,
        //         children: [
        //           ListView.builder(
        //             padding: EdgeInsets.zero,
        //             itemBuilder: (context, index) => ListTile(
        //               title: Text(state.data[index].nama),
        //               trailing: Text(
        //                 'Rp. ${state.data[index].formattedHarga}',
        //                 style: const TextStyle(
        //                   fontSize: 14,
        //                   fontWeight: FontWeight.w600,
        //                 ),
        //               ),
        //             ),
        //             itemCount: state.data.length,
        //             shrinkWrap: true,
        //           ),
        //           Padding(
        //             padding: const EdgeInsets.symmetric(horizontal: 12),
        //             child: ElevatedButton(
        //               onPressed: () => barangCubit.deleteAllItems(),
        //               child: const Text('Hapus Semua Barang'),
        //             ),
        //           ),
        //         ],
        //       );
        //     }

        //     return const Center(
        //       child: Text(
        //         'Silakan Tambah Jasa',
        //         style: TextStyle(
        //           fontSize: 16,
        //           fontWeight: FontWeight.w500,
        //         ),
        //       ),
        //     );
        //   },
        // ),
        // floatingActionButton: SpeedDial(
        //   animatedIcon: AnimatedIcons.menu_close,
        //   children: [
        //     SpeedDialChild(
        //       label: 'Tambah Jasa',
        //       onTap: () async {
        //         final String? onCancelled = await showDialog(
        //           context: context,
        //           builder: (context) {
        //             return Form(
        //               key: formKey,
        //               child: AlertDialog(
        //                 title: const Text('Pilih Jasa'),
        //                 content: DropdownSearch<ServiceModel>(
        //                   itemAsString: (item) => item.barangAsString,
        //                   items: items,
        //                   dropdownDecoratorProps: const DropDownDecoratorProps(
        //                     dropdownSearchDecoration: InputDecoration(
        //                       hintText: 'Jasa',
        //                     ),
        //                   ),
        //                   popupProps: PopupProps.menu(
        //                     showSearchBox: true,
        //                     emptyBuilder: (context, searchEntry) =>
        //                         const Center(
        //                       child: Text(
        //                         'Tidak ada Data',
        //                         textAlign: TextAlign.center,
        //                       ),
        //                     ),
        //                   ),
        //                   onChanged: (value) {
        //                     if (value != null) {
        //                       barangCubit.addBarang = value;
        //                     }
        //                   },
        //                   validator: (value) {
        //                     if (value == null) {
        //                       return 'Mohon Isi Jasa';
        //                     }
        //                     return null;
        //                   },
        //                 ),
        //                 actions: [
        //                   ElevatedButton(
        //                     onPressed: () {
        //                       if (formKey.currentState!.validate()) {
        //                         pcsController.text = '';
        //                         barangCubit.getBarang();
        //                         Navigator.of(context).pop('onElevatedButton');
        //                       }
        //                     },
        //                     style: ElevatedButton.styleFrom(
        //                       shape: RoundedRectangleBorder(
        //                         borderRadius: BorderRadius.circular(8),
        //                       ),
        //                     ),
        //                     child: const Text('Pilih'),
        //                   ),
        //                 ],
        //               ),
        //             );
        //           },
        //         );
        //         if (onCancelled == null) {
        //           barangCubit.onCancelled();
        //         }
        //       },
        //       child: const Icon(CupertinoIcons.cube_box_fill),
        //     ),
        //     SpeedDialChild(
        //       label: 'Buat Invoice',
        //       onTap: () async {
        //         final InvoiceModel invoice = InvoiceModel(
        //           namaPelanggan: 'Soleh',
        //           services: barangCubit.getServices,
        //           boughtAt: DateTime.now(),
        //         );
        //         invoiceCubit.createInvoice(invoice);
        //       },
        //       child: const Icon(Icons.document_scanner_rounded),
        //     ),
        //   ],
        //   overlayColor: Colors.grey,
        // ),
      ),
    );
  }

  @override
  void dispose() {
    pcsController.dispose();
    super.dispose();
  }
}
