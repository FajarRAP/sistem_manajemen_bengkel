import 'package:dartz/dartz.dart';

import '../../../../core/failure.dart';
import '../../../../core/usecase/usecase_params.dart';
import '../entities/invoice_entity.dart';
import '../repositories/invoice_repositories.dart';

class GetInvoicesByUsernameUseCase implements UseCaseParams<List<Invoice>, String> {
  final InvoiceRepositories invoiceRepositories;

  GetInvoicesByUsernameUseCase(this.invoiceRepositories);

  @override
  Future<Either<Failure, List<Invoice>>> call(final String username) async =>
      await invoiceRepositories.getInvoicesByUsername(username);
}
