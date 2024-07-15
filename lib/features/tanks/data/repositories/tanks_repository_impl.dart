import 'package:dartz/dartz.dart';

import '../../../../config/database/error/exceptions.dart';
import '../../../../config/database/error/failures.dart';
import '../../domain/repositories/tanks_repository.dart';
import '../datasources/tanks_local_data_source.dart';
import '../models/tank_model.dart';

class TanksRepositoryImpl extends TanksRepository {
  final TanksLocalDataSource _dataSource;

  TanksRepositoryImpl({required TanksLocalDataSource dataSource})
      : _dataSource = dataSource;
  Future<Either<Failure, List<TankModel>>> getTanks({required Map<String, dynamic> options}) async {
    try {
      return Right(await _dataSource.getTanks(options: options));
    } on CacheException catch (e) {
      return Left(CacheFailure(errorMessage: e.message));
    }
  }

  @override
  Future<Either<Failure, bool>> addTank(
      {required Map<String, dynamic> tank}) async {
    try {
      return Right(await _dataSource.addTanks(tank: tank));
    } on CacheException catch (e) {
      return Left(CacheFailure(errorMessage: e.message));
    }
  }

  @override
  Future<Either<Failure, bool>> deleteTank({required int id}) async {
    try {
      return Right(await _dataSource.deleteTank(id: id));
    } on CacheException catch (e) {
      return Left(CacheFailure(errorMessage: e.message));
    }
  }

  @override
  Future<Either<Failure, bool>> updateTank(
      {required Map<String, dynamic> tank}) async {
    try {
      return Right(await _dataSource.updateTank(tank: tank));
    } on CacheException catch (e) {
      return Left(CacheFailure(errorMessage: e.message));
    }
  }
}
