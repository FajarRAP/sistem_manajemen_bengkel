import 'package:dartz/dartz.dart';

import '../../../../core/failure.dart';
import '../../../../core/usecase/usecase_params.dart';
import '../entities/user.dart';
import '../repositories/auth_repositories.dart';

class AuthRegisterUseCase implements UseCaseParams<String, User> {
  final AuthRepositories authRepo;
  AuthRegisterUseCase(this.authRepo);

  @override
  Future<Either<Failure, String>> call(final User data) async =>
      authRepo.authRegister(data);
}
