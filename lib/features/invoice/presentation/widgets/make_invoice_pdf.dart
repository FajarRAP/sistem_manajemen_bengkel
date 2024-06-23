import 'dart:typed_data';

import 'package:intl/intl.dart';
import 'package:pdf/widgets.dart';

import '../../domain/entities/invoice_entity.dart';

Future<Uint8List> makePDF(Invoice invoice) async {
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
                  'Nama Jasa',
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  invoice.service.name,
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
                Text(
                  'Rp. ${invoice.service.formattedTotalHarga}',
                  style: const TextStyle(
                    fontSize: 14,
                  ),
                ),
              ],
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
                  'Rp. ${invoice.service.formattedTotalHarga}',
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
