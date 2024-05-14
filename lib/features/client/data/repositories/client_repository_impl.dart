import 'package:baraneq/config/database/error/exceptions.dart';
import 'package:baraneq/config/database/error/failures.dart';

import 'package:baraneq/core/models/client.dart';

import 'package:dartz/dartz.dart';

import '../../domain/repositories/client_repository.dart';
import '../datasources/client_local_data_source.dart';

class CLientRepositoryImpl extends ClientRepository {
  final ClientLocalDataSource _dataSource;

  CLientRepositoryImpl({required ClientLocalDataSource dataSource})
      : _dataSource = dataSource;
  @override
  Future<Either<Failure, bool>> addClient({required Client client}) async {
    try {
      return Right(await _dataSource.addClient(client: client));
    } on CacheException catch (e) {
      return Left(CacheFailure(errorMessage: e.message));
    }
  }
}
