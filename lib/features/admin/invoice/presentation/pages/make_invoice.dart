import 'package:bengkel_pak_bowo/core/constants_finals.dart';
import 'package:bengkel_pak_bowo/features/admin/invoice/data/models/barang.dart';
import 'package:bengkel_pak_bowo/features/admin/invoice/data/models/invoice.dart';
import 'package:bengkel_pak_bowo/features/admin/invoice/presentation/cubit/barang_cubit.dart';
import 'package:bengkel_pak_bowo/features/admin/invoice/presentation/cubit/invoice_cubit.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

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
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Buat Invoice'),
        ),
        body: BlocBuilder<BarangCubit, BarangState>(
          bloc: barangCubit..getBarang(),
          builder: (context, state) {
            if (state is BarangLoaded) {
              return ListView.builder(
                padding: EdgeInsets.zero,
                itemBuilder: (context, index) => ListTile(
                  title: Text(state.data[index].nama),
                  subtitle: Text('${state.data[index].n} Buah'),
                  trailing: Text(
                    'Rp. ${state.data[index].getSubTotal}',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                itemCount: state.data.length,
              );
            }

            return const Center(
              child: Text(
                'Silakan Tambah Barang',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            );
          },
        ),
        floatingActionButton: SpeedDial(
          animatedIcon: AnimatedIcons.menu_close,
          children: [
            SpeedDialChild(
              label: 'Tambah Item',
              onTap: () async {
                final String? onCancelled = await showDialog(
                  context: context,
                  builder: (context) {
                    return Form(
                      key: formKey,
                      child: AlertDialog(
                        title: const Text('Pilih Barang'),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            DropdownSearch<BarangModel>(
                              itemAsString: (item) => item.barangAsString(),
                              items: barangs,
                              dropdownDecoratorProps:
                                  const DropDownDecoratorProps(
                                dropdownSearchDecoration: InputDecoration(
                                  hintText: 'Barang',
                                ),
                              ),
                              popupProps: PopupProps.menu(
                                showSearchBox: true,
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
                            ),
                            const SizedBox(height: 6),
                            SizedBox(
                              width: 80,
                              child: TextFormField(
                                controller: pcsController,
                                decoration: const InputDecoration(
                                  hintText: 'Pcs',
                                  contentPadding: EdgeInsets.zero,
                                ),
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                ],
                                keyboardType: TextInputType.number,
                                textAlign: TextAlign.center,
                                validator: (value) {
                                  if (value != null) {
                                    if (value.isEmpty) {
                                      return 'Harap Isi';
                                    }
                                    if (int.parse(value) <= 0) {
                                      return 'Tidak Valid';
                                    }
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ],
                        ),
                        actions: [
                          ElevatedButton(
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                barangCubit.setPcs = pcsController.text;
                                pcsController.text = '';
                                barangCubit.getBarang();
                                Navigator.of(context).pop('onElevatedButton');
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: const Text('Pilih'),
                          ),
                        ],
                      ),
                    );
                  },
                );
                if (onCancelled == null) {
                  barangCubit.onCancelled();
                }
              },
              child: const Icon(CupertinoIcons.cube_box_fill),
            ),
            SpeedDialChild(
              label: 'Buat Invoice',
              onTap: () async {
                final InvoiceModel invoice = InvoiceModel(
                  namaPelanggan: 'Soleh',
                  barangs: barangCubit.getBarangs,
                  boughtAt: DateTime.now(),
                );
                invoiceCubit.createInvoices(invoice);
              },
              child: const Icon(Icons.document_scanner_rounded),
            ),
          ],
          overlayColor: Colors.grey,
        ),
      ),
    );
  }

  @override
  void dispose() {
    pcsController.dispose();
    super.dispose();
  }
}
