import 'package:baraneq/config/database/error/exceptions.dart';
import 'package:baraneq/config/database/error/failures.dart';
import 'package:baraneq/features/profile/data/datasources/profile_local_data_source.dart';

import 'package:dartz/dartz.dart';

import '../../domain/repositories/profile_repositort.dart';

class ProfileRepositoryImpl extends ProfileRepositort {
  final ProfileLocalDataSource _dataSource;

  ProfileRepositoryImpl({required ProfileLocalDataSource dataSource})
      : _dataSource = dataSource;
  @override
  Future<Either<Failure, Map<String, double>>> getTanks() async {
    try {
      return Right(await _dataSource.getTanks());
    } on CacheException catch (e) {
      return Left(CacheFailure(errorMessage: e.message));
    }
  }
}
