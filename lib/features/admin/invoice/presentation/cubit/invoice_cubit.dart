import 'dart:convert';

import 'package:bengkel_pak_bowo/features/admin/invoice/data/models/barang.dart';
import 'package:bengkel_pak_bowo/features/admin/invoice/data/models/invoice.dart';
import 'package:bengkel_pak_bowo/features/admin/invoice/data/repositories/invoice_repositories_impl.dart';
import 'package:bengkel_pak_bowo/injection_container.dart';
import 'package:bloc/bloc.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'invoice_state.dart';

class InvoiceCubit extends Cubit<InvoiceState> {
  InvoiceCubit() : super(InvoiceInitial());

  InvoiceModel? invoice;
  List<InvoiceModel> invoices = [];

  // Getter
  InvoiceModel get getInvoice => invoice!;
  List<ServiceModel> get getServices => invoice!.services;
  String get formattedTotalHarga => invoice!.formattedTotalHarga;

  Future<void> getInvoices() async {
    emit(ReadInvoiceLoading());

    final Map<String, String> headers = {
      'Authorization': locator<SharedPreferences>().getString('token') ?? ''
    };

    final results =
        await locator<InvoiceRepositoriesImpl>().getInvoices(headers);

    final prefs = locator<SharedPreferences>();
    print(JwtDecoder.decode(prefs.getString('token') ?? ''));

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

  Future<void> createInvoice(final InvoiceModel invoice) async {
    emit(InvoiceCreating());

    final Map<String, String> headers = {
      'Authorization': locator<SharedPreferences>().getString('token') ?? ''
    };
    final results = await locator<InvoiceRepositoriesImpl>()
        .createInvoices(headers, invoiceToJson(invoice));

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
