import 'package:bengkel_pak_bowo/core/failure.dart';
import 'package:bengkel_pak_bowo/features/auth/data/data_sources/remote.dart';
import 'package:bengkel_pak_bowo/features/auth/domain/repositories/auth_repositories.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart';

class AuthRepositoriesImpl implements AuthRepositories {
  final AuthService authService;

  AuthRepositoriesImpl(this.authService);
  @override
  Future<Either<Failure, String>> authLogin(final String body) async {
    try {
      final Response response = await authService.authLogin(body);
      if (response.statusCode > 0) {
        return Right(response.body);
      } else {
        return Left(Failure());
      }
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> authRegister(final String body) async {
    try {
      final Response response = await authService.authRegister(body);
      return Right(response.body);
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }
}
