import 'package:bengkel_pak_bowo/core/constants_finals.dart';
import 'package:http/http.dart';

class InvoiceServices {
  Future<Response> getInvoices(Map<String, String> headers) async {
    return await get(
      Uri.parse('$url${endpoint['invoice']}'),
      headers: headers,
    );
  }

  Future<Response> createInvoices(
      Map<String, String> headers, final String body) async {
    return await post(
      Uri.parse('$url${endpoint['invoice']}'),
      headers: headers,
      body: body,
    );
  }
}
