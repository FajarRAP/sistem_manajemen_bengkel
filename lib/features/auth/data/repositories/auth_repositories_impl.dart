import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart';

import '../../../../core/failure.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repositories.dart';
import '../data_sources/remote.dart';

class AuthRepositoriesImpl implements AuthRepositories {
  final AuthService authService;

  AuthRepositoriesImpl(this.authService);
  @override
  Future<Either<Failure, String>> authLogin(final User data) async {
    try {
      final Response response = await authService.authLogin(jsonEncode(data));
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
  Future<Either<Failure, String>> authRegister(final User data) async {
    try {
      final Response response =
          await authService.authRegister(jsonEncode(data));
      return Right(response.body);
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }
}
