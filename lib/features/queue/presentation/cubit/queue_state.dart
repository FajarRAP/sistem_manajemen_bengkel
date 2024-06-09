part of 'queue_cubit.dart';

@immutable
sealed class QueueState {}

final class QueueInitial extends QueueState {}

class PickQueue extends QueueState {}

class MyQueueToday extends QueueState {}

class QueueNumToday extends QueueState {}

class QueueToday extends QueueState {}

class QueueNumTodayLoaded extends QueueNumToday {
  final int queueNum;

  QueueNumTodayLoaded(this.queueNum);
}

class QueueNumTodayError extends QueueNumToday {
  final String message;
  QueueNumTodayError(this.message);
}

class QueueTodayLoading extends QueueToday {}

class QueueTodayLoaded extends QueueToday {
  final List<QueueEntity> datas;
  QueueTodayLoaded(this.datas);
}

class QueueTodayError extends QueueToday {
  final String message;
  QueueTodayError(this.message);
}

class PickQueueLoading extends PickQueue {}

class PickQueueSuccess extends PickQueue {
  final String message;

  PickQueueSuccess(this.message);
}

class PickQueueError extends PickQueue {
  final String message;

  PickQueueError(this.message);
}

class QueueNotAccepted extends PickQueue {}

class MyQueueTodayLoaded extends MyQueueToday {
  final QueueEntity data;

  MyQueueTodayLoaded(this.data);
}

class MyQueueTodayError extends MyQueueToday {
  final String message;

  MyQueueTodayError(this.message);
}
