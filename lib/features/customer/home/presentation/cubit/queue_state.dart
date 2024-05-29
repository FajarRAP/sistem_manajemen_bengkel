part of 'queue_cubit.dart';

@immutable
sealed class QueueState {}

final class QueueInitial extends QueueState {}

class MyQueueToday extends QueueState {}

class QueueNumLoaded extends QueueState {
  final int queueNum;

  QueueNumLoaded(this.queueNum);
}

class QueueNumError extends QueueState {
  final String message;
  QueueNumError(this.message);
}

class QueueTodayLoading extends QueueState {}

class QueueTodayLoaded extends QueueState {
  final List<QueueEntity> datas;
  QueueTodayLoaded(this.datas);
}

class QueueTodayError extends QueueState {
  final String message;
  QueueTodayError(this.message);
}

class PickQueueLoading extends QueueState {}

class PickQueueSuccess extends QueueState {
  final String message;

  PickQueueSuccess(this.message);
}

class PickQueueError extends QueueState {
  final String message;
  PickQueueError(this.message);
}

class QueueNotAccepted extends QueueState {}

class MyQueueTodayLoaded extends MyQueueToday {
  final QueueEntity data;

  MyQueueTodayLoaded(this.data);
}
