import 'dart:convert';

import '../../domain/entities/invoice_entity.dart';

import '../../../../core/constants_finals.dart';
import 'package:http/http.dart';

abstract interface class InvoiceRemoteDataSource {
  Future<Response> createInvoice(final Invoice invoice);
  Future<Response> getInvoices();
  Future<Response> getInvoiceByUsername(final String username);
}

class InvoiceRemoteDataSourceImpl implements InvoiceRemoteDataSource {
  @override
  Future<Response> createInvoice(Invoice invoice) async =>
      await post(Uri.parse('$url${endpoint['invoice']}'),
          headers: headers, body: jsonEncode(invoice));

  @override
  Future<Response> getInvoiceByUsername(final String username) async =>
      await get(Uri.parse('$url${endpoint['invoice']}/$username'),
          headers: headers);

  @override
  Future<Response> getInvoices() async =>
      await get(Uri.parse('$url${endpoint['invoice']}'), headers: headers);
}
