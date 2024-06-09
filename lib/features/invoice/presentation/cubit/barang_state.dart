part of 'barang_cubit.dart';

@immutable
sealed class BarangState {}

final class BarangInitial extends BarangState {}

class BarangLoaded extends BarangState {}

class BarangEmpty extends BarangState {}
