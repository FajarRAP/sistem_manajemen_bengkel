import 'package:bengkel_pak_bowo/features/queue/domain/repositories/queue_repositories.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/failure.dart';

class PickQueueUseCase {
  final QueueRepositories queueRepo;
  PickQueueUseCase(this.queueRepo);

  Future<Either<Failure, Map<String, dynamic>>> execute(
          final Map<String, String> headers, final String username) async =>
      await queueRepo.pickQueue(headers, username);
}
