import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart';

import '../../../../core/failure.dart';
import '../../domain/entities/queue_entity.dart';
import '../../domain/repositories/queue_repositories.dart';
import '../datasources/remote_datasource.dart';
import '../models/queue_model.dart';

class QueueRepositoriesImpl implements QueueRepositories {
  final QueueRemoteDataSource queueRemoteDataSource;
  QueueRepositoriesImpl(this.queueRemoteDataSource);

  @override
  Future<Either<Failure, int>> getQueueNumToday() async {
    try {
      final Response response = await queueRemoteDataSource.getQueueNumToday();
      

      if (response.statusCode == 200) {
        return Right(jsonDecode(response.body)['message']);
      } else {
        return Left(Failure());
      }
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<QueueEntity>>> getQueueToday() async {
    try {
      final Response response = await queueRemoteDataSource.getQueueToday();
      

      if (response.statusCode == 200) {
        return Right(queuesFromJson(response.body));
      } else {
        return Left(Failure());
      }
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> pickQueue(
      final String username, final String name) async {
    try {
      final Response response = await queueRemoteDataSource
          .pickQueue(jsonEncode({"username": username, "name": name}));
      
      if (response.statusCode > 0) {
        return Right(jsonDecode(response.body));
      } else {
        return Left(Failure());
      }
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, QueueEntity>> getMyQueueToday(
      final String username) async {
    try {
      final Response response =
          await queueRemoteDataSource.getMyQueueToday(username);
      

      if (response.statusCode == 200) {
        return Right(queueFromJson(response.body));
      } else {
        return Left(Failure());
      }
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }
}
