part of 'queue_cubit.dart';

@immutable
sealed class QueueState {}

final class QueueInitial extends QueueState {}

class MyQueueToday extends QueueState {}

class QueueNumToday extends QueueState {}

class QueueNumTodayLoaded extends QueueNumToday {
  final int queueNum;

  QueueNumTodayLoaded(this.queueNum);
}

class QueueNumTodayError extends QueueNumToday {
  final String message;
  QueueNumTodayError(this.message);
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
