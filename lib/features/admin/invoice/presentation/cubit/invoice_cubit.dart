import 'package:bengkel_pak_bowo/features/admin/invoice/data/models/barang.dart';
import 'package:bengkel_pak_bowo/features/admin/invoice/data/models/invoice.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'invoice_state.dart';

class InvoiceCubit extends Cubit<InvoiceState> {
  InvoiceCubit() : super(InvoiceInitial());
  Invoice? invoice;

  // Getter
  Invoice get getInvoice => invoice!;
  List<Barang> get getBarangs => invoice!.barangs;
  int get getTotalHarga => invoice!.getTotalHarga();
}
