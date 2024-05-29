import 'package:dartz/dartz.dart';

import '../../../../core/failure.dart';
import '../entities/user.dart';

abstract class AuthRepositories {
  Future<Either<Failure, String>> authRegister(final User data);
  Future<Either<Failure, String>> authLogin(final User data);
}
