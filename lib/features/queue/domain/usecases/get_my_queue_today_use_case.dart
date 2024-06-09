import 'package:bengkel_pak_bowo/core/usecase/usecase_params.dart';
import 'package:bengkel_pak_bowo/features/queue/domain/repositories/queue_repositories.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/failure.dart';
import '../entities/queue_entity.dart';

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
