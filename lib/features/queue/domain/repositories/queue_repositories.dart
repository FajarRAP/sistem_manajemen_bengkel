import 'package:dartz/dartz.dart';

import '../../../../core/failure.dart';
import '../entities/queue_entity.dart';

abstract class QueueRepositories {
  Future<Either<Failure, int>> getQueueNumToday();
  Future<Either<Failure, Map<String, dynamic>>> pickQueue(
      final String username, final String name);
  Future<Either<Failure, List<QueueEntity>>> getQueueToday();
  Future<Either<Failure, QueueEntity>> getMyQueueToday(final String username);
}
