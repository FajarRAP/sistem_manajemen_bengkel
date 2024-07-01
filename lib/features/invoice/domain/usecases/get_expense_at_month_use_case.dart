import 'package:dartz/dartz.dart';

import '../../../../core/failure.dart';
import '../../../../core/usecase/usecase_params.dart';
import '../repositories/invoice_repositories.dart';

class GetExpenseAtMonthUseCase implements UseCaseParams<int, GetExpenseParams> {
  final InvoiceRepositories invoiceRepositories;

  GetExpenseAtMonthUseCase(this.invoiceRepositories);

  @override
  Future<Either<Failure, int>> call(GetExpenseParams params) async =>
      await invoiceRepositories.getExpenseAtMonth(params.username, params.month);
}

class GetExpenseParams {
  final String username;
  final String month;

  GetExpenseParams({
    required this.username,
    required this.month,
  });
}
