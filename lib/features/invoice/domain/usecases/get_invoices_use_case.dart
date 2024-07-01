import 'package:dartz/dartz.dart';

import '../../../../core/failure.dart';
import '../../../../core/usecase/usecase_no_params.dart';
import '../entities/invoice_entity.dart';
import '../repositories/invoice_repositories.dart';

class GetInvoicesUseCase implements UseCaseNoParams<List<Invoice>> {
  final InvoiceRepositories invoiceRepositories;

  GetInvoicesUseCase(this.invoiceRepositories);

  @override
  Future<Either<Failure, List<Invoice>>> call() async =>
      await invoiceRepositories.getInvoices();
}
