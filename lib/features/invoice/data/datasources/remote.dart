import 'dart:convert';

import 'package:http/http.dart';

import '../../../../core/constants_finals.dart';
import '../../domain/entities/invoice_entity.dart';

abstract interface class InvoiceRemoteDataSource {
  Future<Response> createInvoice(final Invoice invoice);
  Future<Response> getInvoices();
  Future<Response> getInvoiceByUsername(final String username);
  Future<Response> getIncome();
  Future<Response> getExpense(String username, String month);
}

class InvoiceRemoteDataSourceImpl implements InvoiceRemoteDataSource {
  @override
  Future<Response> createInvoice(Invoice invoice) async {
    return await post(Uri.parse('$url${endpoint['invoice']}'),
        headers: headers, body: jsonEncode(invoice));
  }

  @override
  Future<Response> getInvoiceByUsername(final String username) async =>
      await get(Uri.parse('$url${endpoint['invoice']}/$username'),
          headers: headers);

  @override
  Future<Response> getInvoices() async =>
      await get(Uri.parse('$url${endpoint['invoice']}'), headers: headers);

  @override
  Future<Response> getExpense(String username, String month) async =>
      await get(Uri.parse('$url${endpoint['expense']}/$username/month/$month'),
          headers: headers);

  @override
  Future<Response> getIncome() async =>
      await get(Uri.parse('$url${endpoint['income']}'), headers: headers);
}
