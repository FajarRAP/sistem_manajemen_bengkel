import 'package:bengkel_pak_bowo/core/failure.dart';
import 'package:dartz/dartz.dart';

abstract interface class UseCaseNoParams<Success> {
  Future<Either<Failure, Success>> call();
}
