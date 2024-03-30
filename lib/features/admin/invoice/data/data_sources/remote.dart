import 'package:bengkel_pak_bowo/core/constants_finals.dart';
import 'package:http/http.dart';

class InvoiceServices {
  Future<Response> getInvoices() async {
    return await get(Uri.parse('$url${endpoint['invoice']}'));
  }

  Future<Response> createInvoices(final String body) async {
    return await post(
      Uri.parse('$url${endpoint['invoice']}'),
      headers: headers,
      body: body,
    );
  }
}
