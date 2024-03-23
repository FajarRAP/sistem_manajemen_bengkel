import 'package:bengkel_pak_bowo/features/admin/invoice/presentation/cubit/invoice_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class DetailInvoicePage extends StatelessWidget {
  const DetailInvoicePage({super.key});

  @override
  Widget build(BuildContext context) {
    final InvoiceCubit invoiceCubit = context.read<InvoiceCubit>();

    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            const SliverAppBar(
              centerTitle: true,
              title: Text('Detail Invoice'),
            ),
          ];
        },
        body: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(.5),
                    blurRadius: 7,
                    spreadRadius: 1,
                  ),
                ],
                color: Colors.white,
              ),
              padding: const EdgeInsets.all(8),
              margin: const EdgeInsets.all(8),
              width: double.infinity,
              height: 80,
              child: Row(
                children: [
                  const Text(
                    'Customer : ',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      invoiceCubit.getInvoice.nama,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Gap(20),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(.5),
                    blurRadius: 7,
                    spreadRadius: 1,
                  ),
                ],
                color: Colors.white,
              ),
              padding: const EdgeInsets.all(8),
              margin: const EdgeInsets.all(8),
              width: double.infinity,
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(
                      left: 14,
                      right: 22,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Nama Barang',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          'Harga',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Divider(),
                  ListView.builder(
                    padding: const EdgeInsets.all(0),
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(invoiceCubit.getBarangs[index].nama),
                        subtitle: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                                '${invoiceCubit.getBarangs[index].n} x ${invoiceCubit.getBarangs[index].harga}'),
                            Text(
                                'Rp. ${invoiceCubit.getBarangs[index].getSubTotal()}'),
                          ],
                        ),
                      );
                    },
                    itemCount: invoiceCubit.getBarangs.length,
                    shrinkWrap: true,
                  ),
                  const Divider(),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 14,
                      right: 22,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Total',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          'Rp. ${invoiceCubit.getTotalHarga}',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).pushNamed('/previewInvoice'),
        child: const Icon(
          Icons.picture_as_pdf,
        ),
      ),
    );
  }
}
