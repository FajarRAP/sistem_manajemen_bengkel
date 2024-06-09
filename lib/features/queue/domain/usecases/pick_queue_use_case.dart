import 'package:bengkel_pak_bowo/core/usecase/usecase_params.dart';
import 'package:bengkel_pak_bowo/features/queue/domain/repositories/queue_repositories.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/failure.dart';

class PickQueueUseCase
    implements UseCaseParams<Map<String, dynamic>, PickQueueParams> {
  final QueueRepositories queueRepo;

  PickQueueUseCase(this.queueRepo);

  @override
  Future<Either<Failure, Map<String, dynamic>>> call(
          final PickQueueParams params) async =>
      await queueRepo.pickQueue(params.username, params.name);
}

class PickQueueParams {
  final String username;
  final String name;

  PickQueueParams(this.username, this.name);
}
