import 'package:baraneq/config/database/error/exceptions.dart';
import 'package:baraneq/config/database/error/failures.dart';
import 'package:baraneq/features/client/domain/entities/client_information.dart';
import 'package:dartz/dartz.dart';
import '../../domain/repositories/client_repository.dart';
import '../datasources/client_local_data_source.dart';

class CLientRepositoryImpl extends ClientRepository {
  final ClientLocalDataSource _dataSource;

  CLientRepositoryImpl({required ClientLocalDataSource dataSource})
      : _dataSource = dataSource;
  @override
  Future<Either<Failure, bool>> addClient(
      {required Map<String, dynamic> client}) async {
    try {
      return Right(await _dataSource.addClient(client: client));
    } on CacheException catch (e) {
      return Left(CacheFailure(errorMessage: e.message));
    }
  }

  @override
  Future<Either<Failure, bool>> deleteClient({required int id}) async {
    try {
      return Right(await _dataSource.deleteClient(id: id));
    } on CacheException catch (e) {
      return Left(CacheFailure(errorMessage: e.message));
    }
  }

  @override
  Future<Either<Failure, List<ClientInformation>>> getClients({required Map<String, dynamic> options}) async {
    try {
      return Right(await _dataSource.getClients(options: options));
    } on CacheException catch (e) {
      return Left(CacheFailure(errorMessage: e.message));
    }
  }

  @override
  Future<Either<Failure, bool>> updateClient(
      {required Map<String, dynamic> client}) async {
    try {
      return Right(await _dataSource.updateClient(client: client));
    } on CacheException catch (e) {
      return Left(CacheFailure(errorMessage: e.message));
    }
  }
}
