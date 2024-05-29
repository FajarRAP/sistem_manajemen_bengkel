import '../repositories/auth_repositories.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/failure.dart';
import '../entities/user.dart';

class AuthRegisterUseCase {
  final AuthRepositories authRepo;
  AuthRegisterUseCase(this.authRepo);

  Future<Either<Failure, String>> execute(final User data) async =>
      await authRepo.authRegister(data);
}
