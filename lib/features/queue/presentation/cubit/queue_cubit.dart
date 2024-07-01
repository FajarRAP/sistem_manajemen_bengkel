import '../../domain/usecases/get_my_queue_today_use_case.dart';
import '../../domain/usecases/pick_queue_use_case.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../domain/entities/queue_entity.dart';
import '../../domain/usecases/get_queue_num_today_use_case.dart';
import '../../domain/usecases/get_queue_today_use_case.dart';

part 'queue_state.dart';

class QueueCubit extends Cubit<QueueState> {
  QueueCubit({
    required this.getQueueNumTodayUseCase,
    required this.pickQueueUseCase,
    required this.getMyQueueTodayUseCase,
    required this.getQueueTodayUseCase,
  }) : super(QueueInitial());

  final GetQueueNumTodayUseCase getQueueNumTodayUseCase;
  final PickQueueUseCase pickQueueUseCase;
  final GetMyQueueTodayUseCase getMyQueueTodayUseCase;
  final GetQueueTodayUseCase getQueueTodayUseCase;

  QueueEntity? queue;

  // User
  Future<void> getQueueNumToday() async {
    final result = await getQueueNumTodayUseCase();

    result.fold(
      (failure) => emit(QueueNumTodayError(failure.message)),
      (success) => emit(QueueNumTodayLoaded(success)),
    );
  }

  Future<void> pickQueue(final PickQueueParams pickQueueParams) async {
    emit(PickQueueLoading());

    final result = await pickQueueUseCase(pickQueueParams);

    result.fold(
      (failure) => emit(PickQueueError(failure.message)),
      (success) {
        final Map<String, dynamic> responseDecoded = success;
        switch (responseDecoded['statusCode']) {
          case 201:
            emit(PickQueueSuccess(responseDecoded['message']));
            break;
          case 400:
            emit(QueueNotAccepted());
            break;
          case >= 403 && <= 500:
            emit(PickQueueError(responseDecoded['message']));
          default:
        }
      },
    );
  }

  Future<void> getMyQueueToday(final String username) async {
    final result = await getMyQueueTodayUseCase(username);

    result.fold(
      (failure) => emit(MyQueueTodayError(failure.message)),
      (success) => emit(MyQueueTodayLoaded(success)),
    );
  }

  // Admin
  Future<void> getQueueToday() async {
    emit(QueueTodayLoading());

    final result = await getQueueTodayUseCase();

    result.fold(
      (failure) => emit(QueueTodayError(failure.message)),
      (success) {
        if (success.isNotEmpty) {
          emit(QueueTodayLoaded(success));
        } else {
          emit(QueueTodayEmpty());
        }
      },
    );
  }
}
