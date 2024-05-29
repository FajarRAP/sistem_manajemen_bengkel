import '../../../../../core/failure.dart';
import '../data_sources/remote.dart';
import '../models/invoice.dart';
import '../../domain/repositories/invoice_repositories.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart';

class InvoiceRepositoriesImpl implements InvoiceRepositories {
  final InvoiceServices invoiceServices;

  InvoiceRepositoriesImpl(this.invoiceServices);
  @override
  Future<Either<Failure, List<InvoiceModel>>> getInvoices(
      Map<String, String> headers) async {
    try {
      final Response response = await invoiceServices.getInvoices(headers);
      print(response.body);
      if (response.statusCode == 200) {
        return Right(invoiceFromJson(response.body));
      } else {
        return Left(Failure(message: response.body));
      }
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> createInvoices(
      Map<String, String> headers, final String body) async {
    try {
      final Response response =
          await invoiceServices.createInvoices(headers, body);
      switch (response.statusCode) {
        case 201:
        case 400:
        case 403:
          return Right(response.body);
      }
      return Left(Failure());
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }
}
