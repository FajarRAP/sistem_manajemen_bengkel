part of 'invoice_cubit.dart';

@immutable
sealed class InvoiceState {}

final class InvoiceInitial extends InvoiceState {}

class ReadInvoice extends InvoiceState {}

class ReadInvoiceLoading extends ReadInvoice {}

class ReadInvoiceLoaded extends ReadInvoice {
  final List<InvoiceModel> data;

  ReadInvoiceLoaded(this.data);
}

class ReadInvoiceEmpty extends ReadInvoice {}

class ReadInvoiceError extends ReadInvoice {
  final String message;

  ReadInvoiceError(this.message);
}

class CreateInvoice extends InvoiceState {}

class InvoiceCreating extends CreateInvoice {}

class InvoiceCreated extends CreateInvoice {
  final String message;

  InvoiceCreated(this.message);
}

class InvoiceErrorCreated extends CreateInvoice {
  final String message;

  InvoiceErrorCreated(this.message);
}
