import 'package:dartz/dartz.dart';

import '../../../../core/failure.dart';
import '../../../../core/usecase/usecase_params.dart';
import '../entities/queue_entity.dart';
import '../repositories/queue_repositories.dart';

class GetMyQueueTodayUseCase implements UseCaseParams<QueueEntity, String> {
  final QueueRepositories queueRepo;

  GetMyQueueTodayUseCase(this.queueRepo);

  // Future<Either<Failure, QueueEntity>> execute(
  //         final Map<String, String> headers, final String username) async =>
  //     await queueRepo.getMyQueueToday(headers, username);

  @override
  Future<Either<Failure, QueueEntity>> call(final String username) async =>
      await queueRepo.getMyQueueToday(username);
}
