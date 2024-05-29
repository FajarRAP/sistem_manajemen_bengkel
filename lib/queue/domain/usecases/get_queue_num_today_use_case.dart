import 'package:bengkel_pak_bowo/queue/domain/repositories/queue_repositories.dart';
import 'package:dartz/dartz.dart';

import '../../../core/failure.dart';

class GetQueueNumTodayUseCase {
  final QueueRepositories queueRepo;
  GetQueueNumTodayUseCase(this.queueRepo);

  Future<Either<Failure, int>> execute() async =>
      await queueRepo.getQueueNumToday();
}
