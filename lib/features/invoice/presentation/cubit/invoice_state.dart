part of 'invoice_cubit.dart';

@immutable
sealed class InvoiceState {}

final class InvoiceInitial extends InvoiceState {}

class GetInvoice extends InvoiceState {}

class CreateInvoice extends InvoiceState {}

class GetInvoiceLoading extends GetInvoice {}

class GetInvoiceLoaded extends GetInvoice {
  final List<Invoice> data;

  GetInvoiceLoaded(this.data);
}

class GetInvoiceEmpty extends GetInvoice {}

class GetInvoiceError extends GetInvoice {
  final String message;

  GetInvoiceError(this.message);
}

class InvoiceCreating extends CreateInvoice {}

class InvoiceCreated extends CreateInvoice {
  final String message;

  InvoiceCreated(this.message);
}

class InvoiceErrorCreated extends CreateInvoice {
  final String message;

  InvoiceErrorCreated(this.message);
}
