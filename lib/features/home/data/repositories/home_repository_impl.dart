import 'package:baraneq/config/database/error/exceptions.dart';
import 'package:baraneq/config/database/error/failures.dart';
import 'package:baraneq/features/home/data/datasources/home_local_data_source.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/models/client_model.dart';
import '../../../../core/entities/search_client.dart';
import '../../domain/repositories/home_repository.dart';

class HomeRepositoryImpl extends HomeRepository {
  final HomeLocalDataSource _dataSource;

  HomeRepositoryImpl({required HomeLocalDataSource dataSource})
      : _dataSource = dataSource;
  @override
  Future<Either<Failure, List<ClientModel>>> getDailyClients({required Map<String, dynamic> options}) async {
    try {
      return right(await _dataSource.getDailyClients(options: options));
    } on CacheException catch (e) {
      return Left(CacheFailure(errorMessage: e.message));
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> getBalance() async {
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
  Future<Either<Failure, bool>> deleteReceipt({required int id}) async {
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

  @override
  Future<Either<Failure, List<SearchClient>>> searchAboutClient(
      {required Map<String, dynamic> filters}) async {
    try {
      return right(await _dataSource.searchAboutClient(filters: filters));
    } on CacheException catch (e) {
      return Left(CacheFailure(errorMessage: e.message));
    }
  }

  Future<Either<Failure, List<Map<String, dynamic>>>>
      getTanksInformation({required Map<String, dynamic> options}) async {
    try {
      return Right(await _dataSource.getTanksInformation(options: options));
    } on CacheException catch (e) {
      return Left(CacheFailure(errorMessage: e.message));
    }
  }
}
