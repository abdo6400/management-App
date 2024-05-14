import 'package:baraneq/config/database/error/exceptions.dart';
import 'package:baraneq/config/database/error/failures.dart';

import 'package:baraneq/features/home/data/datasources/home_local_data_source.dart';

import 'package:dartz/dartz.dart';

import '../../../../core/models/client_model.dart';
import '../../domain/repositories/home_repository.dart';

class HomeRepositoryImpl extends HomeRepository {
  final HomeLocalDataSource _dataSource;

  HomeRepositoryImpl({required HomeLocalDataSource dataSource})
      : _dataSource = dataSource;
  @override
  Future<Either<Failure, List<ClientModel>>> getClientsWithFilters(
      {required bool isExporter, required bool isToDay}) async {
    try {
      return right(await _dataSource.getClientsWithFilters(
          isExporter: isExporter, isToDay: isToDay));
    } on CacheException catch (e) {
      return Left(CacheFailure(errorMessage: e.message));
    }
  }

  @override
  Future<Either<Failure, double>> getBalance() async {
    try {
      return right(await _dataSource.getBalance());
    } on CacheException catch (e) {
      return Left(CacheFailure(errorMessage: e.message));
    }
  }

  @override
  Future<Either<Failure, bool>> addReceipt(
      {required Map<String, dynamic> receipt}) async {
    try {
      return right(await _dataSource.addReceipt(receipt: receipt));
    } on CacheException catch (e) {
      return Left(CacheFailure(errorMessage: e.message));
    }
  }

  @override
  Future<Either<Failure, bool>> deleteReceipt({required String id}) async {
    try {
      return right(await _dataSource.deleteReceipt(id: id));
    } on CacheException catch (e) {
      return Left(CacheFailure(errorMessage: e.message));
    }
  }

  @override
  Future<Either<Failure, bool>> editReceipt(
      {required Map<String, dynamic> receipt}) async {
    try {
      return right(await _dataSource.editReceipt(receipt: receipt));
    } on CacheException catch (e) {
      return Left(CacheFailure(errorMessage: e.message));
    }
  }
}
