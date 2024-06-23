part of 'service_cubit.dart';

@immutable
sealed class ServiceState {}

final class ServiceInitial extends ServiceState {}

class ServicePicked extends ServiceState {}
