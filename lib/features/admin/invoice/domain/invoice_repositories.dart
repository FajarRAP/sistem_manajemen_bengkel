import 'package:bengkel_pak_bowo/core/failure.dart';
import 'package:dartz/dartz.dart';

abstract class InvoiceRepositories<T> {
  Future<Either<Failure, T>> getInvoices();
  Future<Either<Failure, T>> createInvoices(final String body);
}