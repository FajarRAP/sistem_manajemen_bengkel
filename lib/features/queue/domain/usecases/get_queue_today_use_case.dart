import 'package:bengkel_pak_bowo/features/queue/domain/entities/queue_entity.dart';
import 'package:bengkel_pak_bowo/features/queue/domain/repositories/queue_repositories.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/failure.dart';

class GetQueueTodayUseCase {
  final QueueRepositories queueRepo;
  GetQueueTodayUseCase(this.queueRepo);

  Future<Either<Failure, List<QueueEntity>>> execute() async =>
      await queueRepo.getQueueToday();
}
