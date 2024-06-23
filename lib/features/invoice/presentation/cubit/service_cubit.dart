import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../domain/entities/service_entity.dart';

part 'service_state.dart';

class ServiceCubit extends Cubit<ServiceState> {
  ServiceCubit() : super(ServiceInitial());

  Service? service;

  void pickService(Service service) {
    this.service = service;
    emit(ServicePicked());
  }
}
