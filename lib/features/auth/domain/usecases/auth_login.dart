import 'package:dartz/dartz.dart';

import '../../../../core/failure.dart';
import '../../../../core/usecase/usecase_params.dart';
import '../entities/user.dart';
import '../repositories/auth_repositories.dart';

class AuthLoginUseCase implements UseCaseParams<String, User> {
  final AuthRepositories authRepo;

  AuthLoginUseCase(this.authRepo);

  @override
  Future<Either<Failure, String>> call(final User data) async =>
      await authRepo.authLogin(data);
}
