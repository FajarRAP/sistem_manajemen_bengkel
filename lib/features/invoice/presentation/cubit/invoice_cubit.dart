import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../domain/entities/invoice_entity.dart';
import '../../domain/usecases/create_invoice_use_case.dart';
import '../../domain/usecases/get_expense_at_month_use_case.dart';
import '../../domain/usecases/get_income_at_month_use_case.dart';
import '../../domain/usecases/get_invoices_by_username_use_case.dart';
import '../../domain/usecases/get_invoices_use_case.dart';

part 'invoice_state.dart';

class InvoiceCubit extends Cubit<InvoiceState> {
  InvoiceCubit({
    required this.createInvoiceUseCase,
    required this.getInvoicesUseCase,
    required this.getInvoicesByUsernameUseCase,
    required this.getExpenseAtMonthUseCase,
    required this.getIncomeUseCase,
  }) : super(InvoiceInitial());

  final CreateInvoiceUseCase createInvoiceUseCase;
  final GetInvoicesUseCase getInvoicesUseCase;
  final GetInvoicesByUsernameUseCase getInvoicesByUsernameUseCase;
  final GetExpenseAtMonthUseCase getExpenseAtMonthUseCase;
  final GetIncomeAtMonthUseCase getIncomeUseCase;

  Invoice? invoice;

  Future<void> createInvoice(Invoice invoice) async {
    emit(InvoiceCreating());

    final result = await createInvoiceUseCase(invoice);

    result.fold(
      (failure) => emit(InvoiceErrorCreated(failure.message)),
      (success) => emit(InvoiceCreated(success)),
    );
  }

  Future<void> getInvoices() async {
    emit(GetInvoiceLoading());

    final result = await getInvoicesUseCase();

    result.fold(
      (failure) => emit(GetInvoiceError(failure.message)),
      (success) => success.isEmpty
          ? emit(GetInvoiceEmpty())
          : emit(GetInvoiceLoaded(success)),
    );
  }

  Future<void> getInvoicesByUsername(String username) async {
    emit(GetInvoiceLoading());

    final result = await getInvoicesByUsernameUseCase(username);

    result.fold(
      (failure) => emit(GetInvoiceError(failure.message)),
      (success) => success.isEmpty
          ? emit(GetInvoiceEmpty())
          : emit(GetInvoiceLoaded(success)),
    );
  }

  Future<void> getExpenseAtMonth(String username, String month) async {
    emit(GetTransactionLoading());

    final result = await getExpenseAtMonthUseCase(
        GetExpenseParams(username: username, month: month));

    result.fold(
      (failure) => emit(GetTransactionError(failure.message)),
      (success) => success == 0
          ? emit(GetTransactionEmpty())
          : emit(GetTransactionLoaded(success)),
    );
  }

  Future<void> getIncomeAtMonth(String month) async {
    emit(GetTransactionLoading());

    final result = await getIncomeUseCase(month);

    result.fold(
      (failure) => emit(GetTransactionError(failure.message)),
      (success) => success == 0
          ? emit(GetTransactionEmpty())
          : emit(GetTransactionLoaded(success)),
    );
  }
}
