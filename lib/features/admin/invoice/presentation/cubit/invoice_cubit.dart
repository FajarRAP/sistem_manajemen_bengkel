import 'dart:convert';

import 'package:bengkel_pak_bowo/features/admin/invoice/data/data_sources/remote.dart';
import 'package:bengkel_pak_bowo/features/admin/invoice/data/models/barang.dart';
import 'package:bengkel_pak_bowo/features/admin/invoice/data/models/invoice.dart';
import 'package:bengkel_pak_bowo/features/admin/invoice/data/repositories/invoice_repositories_impl.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'invoice_state.dart';

class InvoiceCubit extends Cubit<InvoiceState> {
  InvoiceCubit() : super(InvoiceInitial());

  InvoiceModel? invoice;
  List<InvoiceModel> invoices = [];

  // Getter
  InvoiceModel get getInvoice => invoice!;
  List<BarangModel> get getBarangs => invoice!.barangs;
  int get getTotalHarga => invoice!.getTotalHarga;

  Future<void> getInvoices() async {
    emit(ReadInvoiceLoading());

    final results =
        await InvoiceRepositoriesImpl(InvoiceServices()).getInvoices();

    results.fold(
      (failure) {
        emit(ReadInvoiceError(failure.message));
      },
      (success) {
        invoices = success;
        // success.clear();
        if (success.isEmpty) {
          emit(ReadInvoiceEmpty());
        } else {
          emit(ReadInvoiceLoaded(invoices));
        }
      },
    );
  }

  Future<void> createInvoices(final InvoiceModel invoice) async {
    emit(InvoiceCreating());
    final results = await InvoiceRepositoriesImpl(InvoiceServices())
        .createInvoices(invoiceToJson(invoice));
    results.fold(
      (failure) {
        emit(InvoiceErrorCreated(failure.message));
      },
      (response) {
        switch (jsonDecode(response)['statusCode']) {
          case 201:
            emit(InvoiceCreated(jsonDecode(response)['message']));
            break;
          case 400:
            emit(InvoiceErrorCreated(jsonDecode(response)['message']));
            break;
        }
      },
    );
  }
}
