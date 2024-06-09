import 'package:bengkel_pak_bowo/core/usecase/usecase_no_params.dart';
import 'package:bengkel_pak_bowo/features/queue/domain/repositories/queue_repositories.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/failure.dart';

class GetQueueNumTodayUseCase implements UseCaseNoParams<int> {
  final QueueRepositories queueRepo;
  GetQueueNumTodayUseCase(this.queueRepo);

  // Future<Either<Failure, int>> execute() async =>
  //     await queueRepo.getQueueNumToday();

  @override
  Future<Either<Failure, int>> call() async =>
      await queueRepo.getQueueNumToday();
}
