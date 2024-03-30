import 'package:bengkel_pak_bowo/core/failure.dart';
import 'package:bengkel_pak_bowo/features/admin/invoice/data/data_sources/remote.dart';
import 'package:bengkel_pak_bowo/features/admin/invoice/data/models/invoice.dart';
import 'package:bengkel_pak_bowo/features/admin/invoice/domain/invoice_repositories.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart';

class InvoiceRepositoriesImpl implements InvoiceRepositories {
  final InvoiceServices invoiceServices;

  InvoiceRepositoriesImpl(this.invoiceServices);
  @override
  Future<Either<Failure, List<InvoiceModel>>> getInvoices() async {
    try {
      final Response response = await invoiceServices.getInvoices();
      if (response.statusCode == 200) {
        return Right(invoiceFromJson(response.body));
      } else {
        return Left(Failure());
      }
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> createInvoices(final String body) async {
    try {
      final Response response = await invoiceServices.createInvoices(body);
      switch (response.statusCode) {
        case 201:
        case 400:
          return Right(response.body);
      }
      return Left(Failure());
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }
}
