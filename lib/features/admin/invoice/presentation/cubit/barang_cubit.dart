import 'package:bengkel_pak_bowo/features/admin/invoice/data/models/barang.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'barang_state.dart';

class BarangCubit extends Cubit<BarangState> {
  BarangCubit() : super(BarangInitial());

  List<BarangModel> barangs = [];

  // Getter
  List<BarangModel> get getBarangs => barangs;

  // Setter
  set addBarang(final BarangModel barang) => barangs.add(barang);

  void onCancelled() => barangs.removeLast();

  void getBarang() {
    if (barangs.isEmpty) {
      emit(BarangEmpty());
    } else {
      emit(BarangLoaded(barangs));
    }
  }

  void deleteAllItems() {
    if (barangs.isNotEmpty) {
      barangs.clear();
      emit(BarangEmpty());
    }
  }
}
