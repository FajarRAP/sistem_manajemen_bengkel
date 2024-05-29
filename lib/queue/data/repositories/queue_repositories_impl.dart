import 'dart:convert';

import 'package:bengkel_pak_bowo/core/failure.dart';
import 'package:bengkel_pak_bowo/queue/data/data_sources/remote.dart';
import 'package:bengkel_pak_bowo/queue/data/models/queue_model.dart';
import 'package:bengkel_pak_bowo/queue/domain/entities/queue_entity.dart';
import 'package:bengkel_pak_bowo/queue/domain/repositories/queue_repositories.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart';

class QueueRepositoriesImpl implements QueueRepositories {
  final QueueService queueService;
  QueueRepositoriesImpl(this.queueService);

  @override
  Future<Either<Failure, int>> getQueueNumToday() async {
    try {
      final Response response = await queueService.getQueueNumToday();

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
      final Response response = await queueService.getQueueToday();

      if (response.statusCode == 200) {
        return Right(queueFromJson(response.body));
      } else {
        return Left(Failure());
      }
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> pickQueue(
      final Map<String, String> headers, final String username) async {
    try {
      final Response response = await queueService.pickQueue(
          headers, jsonEncode({"username": username}));
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
      final Map<String, String> headers, final String username) async {
    try {
      final Response response =
          await queueService.getMyQueueToday(headers, username);

      if (response.statusCode == 200) {
        print(jsonDecode(response.body));
        return Right(QueueModel.fromJson(jsonDecode(response.body)));
      } else {
        return Left(Failure());
      }
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }
}
