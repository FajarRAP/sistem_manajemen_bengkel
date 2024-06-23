import 'package:bloc/bloc.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';

import '../../domain/entities/invoice_entity.dart';
import '../../domain/usecases/create_invoice_use_case.dart';
import '../../domain/usecases/get_invoice_by_username_use_case.dart';
import '../../domain/usecases/get_invoices_use_case.dart';

part 'invoice_state.dart';

class InvoiceCubit extends Cubit<InvoiceState> {
  InvoiceCubit({
    required this.createInvoiceUseCase,
    required this.getInvoicesUseCase,
    required this.getInvoiceByUsernameUseCase,
  }) : super(InvoiceInitial());

  final CreateInvoiceUseCase createInvoiceUseCase;
  final GetInvoicesUseCase getInvoicesUseCase;
  final GetInvoiceByUsernameUseCase getInvoiceByUsernameUseCase;

  Invoice? invoice;

  String get formattedBoughtAt =>
      DateFormat('d MMMM y').format(invoice!.boughtAt);

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

  Future<void> getInvoiceByUsername(String username) async {
    emit(GetInvoiceLoading());

    final result = await getInvoiceByUsernameUseCase(username);

    result.fold(
      (failure) => emit(GetInvoiceError(failure.message)),
      (success) => success.isEmpty
          ? emit(GetInvoiceEmpty())
          : emit(GetInvoiceLoaded(success)),
    );
  }
}
