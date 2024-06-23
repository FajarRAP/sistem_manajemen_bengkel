import '../../../../core/usecase/usecase_no_params.dart';
import '../entities/queue_entity.dart';
import '../repositories/queue_repositories.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/failure.dart';

class GetQueueTodayUseCase implements UseCaseNoParams<List<QueueEntity>> {
  final QueueRepositories queueRepo;

  GetQueueTodayUseCase(this.queueRepo);

  @override
  Future<Either<Failure, List<QueueEntity>>> call() async =>
      await queueRepo.getQueueToday();

  // Future<Either<Failure, List<QueueEntity>>> execute() async =>
  //     await queueRepo.getQueueToday();
}
