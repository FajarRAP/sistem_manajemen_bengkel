import 'package:dartz/dartz.dart';

import '../../../../core/failure.dart';

abstract class InvoiceRepositories<T> {
  Future<Either<Failure, T>> getInvoices(Map<String, String> headers);
  Future<Either<Failure, T>> createInvoices(
      Map<String, String> headers, final String body);
}
