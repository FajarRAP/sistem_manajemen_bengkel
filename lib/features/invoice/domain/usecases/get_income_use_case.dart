import 'package:dartz/dartz.dart';

import '../../../../core/failure.dart';
import '../../../../core/usecase/usecase_no_params.dart';
import '../repositories/invoice_repositories.dart';

class GetIncomeUseCase implements UseCaseNoParams<int> {
  final InvoiceRepositories invoiceRepositories;

  GetIncomeUseCase(this.invoiceRepositories);

  @override
  Future<Either<Failure, int>> call() async =>
      await invoiceRepositories.getIncome();
}
