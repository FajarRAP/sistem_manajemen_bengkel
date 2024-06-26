import 'package:dartz/dartz.dart';

import '../../../../core/failure.dart';
import '../../../../core/usecase/usecase_params.dart';
import '../repositories/invoice_repositories.dart';

class GetIncomeAtMonthUseCase implements UseCaseParams<int, String> {
  final InvoiceRepositories invoiceRepositories;

  GetIncomeAtMonthUseCase(this.invoiceRepositories);

  @override
  Future<Either<Failure, int>> call(String month) async =>
      await invoiceRepositories.getIncomeAtMonth(month);
}
