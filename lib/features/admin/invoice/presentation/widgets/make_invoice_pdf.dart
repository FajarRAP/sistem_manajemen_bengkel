import 'dart:typed_data';

import 'package:bengkel_pak_bowo/features/admin/invoice/data/models/invoice.dart';
import 'package:intl/intl.dart';
import 'package:pdf/widgets.dart';

Future<Uint8List> makePDF(InvoiceModel invoice) async {
  final Document pdf = Document();
  pdf.addPage(
    Page(
      build: (context) {
        return Column(
          children: [
            Text(
              'Bengkel Pak Bowo',
              style: const TextStyle(fontSize: 18),
            ),
            Text(
              'Alamat Bengkel Pak Bowo',
              style: const TextStyle(fontSize: 18),
            ),
            Text(
              'Nomor Telepon',
              style: const TextStyle(fontSize: 18),
            ),
            Text(
              'Nomor Invoice - ${DateFormat('d/M/y').format(invoice.boughtAt)}',
              style: const TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Nama Barang',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Harga',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Divider(),
            ListView.separated(
              itemBuilder: (context, index) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      invoice.barangs[index].nama,
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${invoice.barangs[index].n} x ${invoice.barangs[index].harga}',
                          style: const TextStyle(fontSize: 14),
                        ),
                        Text(
                          'Rp. ${invoice.barangs[index].getSubTotal}',
                          style: const TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                  ],
                );
              },
              separatorBuilder: (context, index) => SizedBox(height: 12),
              itemCount: invoice.barangs.length,
            ),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total Harga',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Rp. ${invoice.getTotalHarga}',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        );
      },
    ),
  );
  return pdf.save();
}
