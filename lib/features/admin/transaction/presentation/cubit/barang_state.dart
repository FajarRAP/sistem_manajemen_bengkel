part of 'barang_cubit.dart';

@immutable
sealed class BarangState {}

final class BarangInitial extends BarangState {}

class BarangLoaded extends BarangState {
  final List<ServiceModel> data;

  BarangLoaded(this.data);
}

class BarangEmpty extends BarangState {}
