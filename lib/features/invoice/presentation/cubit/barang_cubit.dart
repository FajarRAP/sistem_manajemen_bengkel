import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../data/models/barang.dart';

part 'barang_state.dart';

class BarangCubit extends Cubit<BarangState> {
  BarangCubit() : super(BarangInitial());

  ServiceModel? service;

  // Getter
  String getHarga() => service != null ? service!.formattedHarga : '0';
  void servicePicked(final ServiceModel service) {
    this.service = service;
    emit(BarangLoaded());
  }
}
