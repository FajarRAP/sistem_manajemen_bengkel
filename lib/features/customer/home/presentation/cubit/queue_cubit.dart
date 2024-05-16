import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'queue_state.dart';

class QueueCubit extends Cubit<QueueState> {
  QueueCubit() : super(QueueInitial());
}
