import 'dart:convert';

import 'package:dartz/dartz.dart';

import '../../../../core/failure.dart';
import '../../domain/entities/invoice_entity.dart';
import '../../domain/repositories/invoice_repositories.dart';
import '../datasources/remote.dart';
import '../models/invoice_model.dart';

class InvoiceRepositoriesImpl implements InvoiceRepositories {
  final InvoiceRemoteDataSource invoiceRemoteDataSource;

  InvoiceRepositoriesImpl(this.invoiceRemoteDataSource);

  @override
  Future<Either<Failure, String>> createInvoice(Invoice invoice) async {
    try {
      final response = await invoiceRemoteDataSource.createInvoice(invoice);
      final Map<String, dynamic> decoded = jsonDecode(response.body);

      switch (decoded['statusCode']) {
        case 400:
          return Left(Failure(message: decoded['message']));
        case 500:
          return Left(Failure(message: decoded['message']));
      }
      return Right(decoded['message']);
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Invoice>>> getInvoices() async {
    try {
      final response = await invoiceRemoteDataSource.getInvoices();
      final Map<String, dynamic> decoded = jsonDecode(response.body);
      
      if (response.statusCode == 200) {
        return Right((decoded['datas'] as List<dynamic>)
            .map((e) => InvoiceModel.fromJson(e))
            .toList());
      }
      return Left(Failure(message: decoded['message']));
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Invoice>>> getInvoiceByUsername(
      final String username) async {
    try {
      final response =
          await invoiceRemoteDataSource.getInvoiceByUsername(username);
      final Map<String, dynamic> decoded = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return Right((decoded['datas'] as List<dynamic>)
            .map((e) => InvoiceModel.fromJson(e))
            .toList());
      }
      return Left(Failure(message: decoded['statusCode']));
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }
}
