import 'package:bengkel_pak_bowo/features/admin/invoice/data/models/barang.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'barang_state.dart';

class BarangCubit extends Cubit<BarangState> {
  BarangCubit() : super(BarangInitial());

  List<ServiceModel> services = [];

  // Getter
  List<ServiceModel> get getServices => services;

  // Setter
  set addBarang(final ServiceModel barang) => services.add(barang);

  void onCancelled() => services.removeLast();

  void getBarang() {
    if (services.isEmpty) {
      emit(BarangEmpty());
    } else {
      emit(BarangLoaded(services));
    }
  }

  void deleteAllItems() {
    if (services.isNotEmpty) {
      services.clear();
      emit(BarangEmpty());
    }
  }
}
