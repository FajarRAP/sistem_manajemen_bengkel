import 'package:bengkel_pak_bowo/queue/domain/usecases/get_my_queue_today_use_case.dart';
import 'package:bengkel_pak_bowo/queue/domain/usecases/pick_queue_use_case.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../core/constants_finals.dart';
import '../../../../../injection_container.dart';
import '../../../../../queue/domain/entities/queue_entity.dart';
import '../../../../../queue/domain/usecases/get_queue_num_today_use_case.dart';
import '../../../../../queue/domain/usecases/get_queue_today_use_case.dart';

part 'queue_state.dart';

class QueueCubit extends Cubit<QueueState> {
  QueueCubit() : super(QueueInitial());

  QueueEntity? queue;

  Future<void> getQueueNumToday() async {
    final result = await locator<GetQueueNumTodayUseCase>().execute();
    result.fold(
      (l) => emit(QueueNumError(l.message)),
      (r) => emit(QueueNumLoaded(r)),
    );
  }

  Future<void> getQueueToday() async {
    emit(QueueTodayLoading());

    final result = await locator<GetQueueTodayUseCase>().execute();

    result.fold(
      (l) => emit(QueueTodayError(l.message)),
      (r) => emit(QueueTodayLoaded(r)),
    );
  }

  Future<void> pickQueue(final String username) async {
    emit(PickQueueLoading());

    final token = locator<SharedPreferences>().getString('token');
    final Map<String, String> newHeaders = headers;
    newHeaders['Authorization'] = token ?? '';
    final result =
        await locator<PickQueueUseCase>().execute(newHeaders, username);

    result.fold(
      (l) => emit(PickQueueError(l.message)),
      (r) {
        final Map<String, dynamic> responseDecoded = r;
        switch (responseDecoded['statusCode']) {
          case 201:
            emit(PickQueueSuccess(responseDecoded['message']));
            break;
          case 400:
            emit(QueueNotAccepted());
            break;
          default:
        }
        print(r);
      },
    );
  }

  Future<void> getMyQueueToday(final String username) async {
    final token = locator<SharedPreferences>().getString('token');
    final Map<String, String> newHeaders = headers;
    newHeaders['Authorization'] = token ?? '';
    final result =
        await locator<GetMyQueueTodayUseCase>().execute(newHeaders, username);

    result.fold((l) => print(l.message), (r) => emit(MyQueueTodayLoaded(r)));
  }
}
