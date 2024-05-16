import 'package:bengkel_pak_bowo/core/failure.dart';
import 'package:dartz/dartz.dart';

abstract class InvoiceRepositories<T> {
  Future<Either<Failure, T>> getInvoices(Map<String, String> headers);
  Future<Either<Failure, T>> createInvoices(
      Map<String, String> headers, final String body);
}
