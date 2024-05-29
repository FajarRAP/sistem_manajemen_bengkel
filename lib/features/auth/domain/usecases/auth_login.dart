import 'package:dartz/dartz.dart';

import '../../../../core/failure.dart';
import '../entities/user.dart';
import '../repositories/auth_repositories.dart';

class AuthLoginUseCase {
  final AuthRepositories authRepo;

  AuthLoginUseCase(this.authRepo);

  Future<Either<Failure, String>> execute(final User data) async =>
      await authRepo.authLogin(data);
}
