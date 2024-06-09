import 'package:bengkel_pak_bowo/core/failure.dart';
import 'package:dartz/dartz.dart';

abstract interface class UseCaseParams<Success, Params> {
  Future<Either<Failure, Success>> call(final Params params);
}
