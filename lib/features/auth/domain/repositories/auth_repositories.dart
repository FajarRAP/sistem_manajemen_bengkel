import 'package:bengkel_pak_bowo/core/failure.dart';
import 'package:dartz/dartz.dart';

abstract class AuthRepositories<T> {
  Future<Either<Failure, T>> authLogin(final String body);
}