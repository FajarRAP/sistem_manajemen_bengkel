import 'package:dartz/dartz.dart';

import '../../../../core/failure.dart';
import '../../../../core/usecase/usecase_params.dart';
import '../entities/invoice_entity.dart';
import '../repositories/invoice_repositories.dart';

class CreateInvoiceUseCase implements UseCaseParams<String, Invoice> {
  final InvoiceRepositories invoiceRepositories;

  CreateInvoiceUseCase(this.invoiceRepositories);

  @override
  Future<Either<Failure, String>> call(Invoice invoice) async =>
      await invoiceRepositories.createInvoice(invoice);
}
