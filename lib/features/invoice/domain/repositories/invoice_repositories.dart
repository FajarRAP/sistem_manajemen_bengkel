import 'package:dartz/dartz.dart';

import '../../../../core/failure.dart';
import '../entities/invoice_entity.dart';

abstract interface class InvoiceRepositories {
  Future<Either<Failure, String>> createInvoice(Invoice invoice);
  Future<Either<Failure, List<Invoice>>> getInvoices();
  Future<Either<Failure, List<Invoice>>> getInvoicesByUsername(final String username);
  Future<Either<Failure, int>> getExpenseAtMonth(String username, String month);
  Future<Either<Failure, int>> getIncome(String month);
}
