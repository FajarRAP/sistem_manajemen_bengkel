import 'package:dartz/dartz.dart';

import '../../../core/failure.dart';
import '../entities/queue_entity.dart';

abstract class QueueRepositories {
  Future<Either<Failure, int>> getQueueNumToday();
  Future<Either<Failure, Map<String, dynamic>>> pickQueue(
      final Map<String, String> headers, final String username);
  Future<Either<Failure, List<QueueEntity>>> getQueueToday();
  Future<Either<Failure, QueueEntity>> getMyQueueToday(
      final Map<String, String> headers, final String username);
}
