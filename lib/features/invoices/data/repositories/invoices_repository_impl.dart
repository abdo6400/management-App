import 'package:baraneq/config/database/error/exceptions.dart';
import 'package:baraneq/config/database/error/failures.dart';

import 'package:dartz/dartz.dart';

import '../../../../core/models/client_model.dart';
import '../../domain/repositories/invoices_repository.dart';
import '../datasources/invoices_local_data_source.dart';

class InvoicesRepositoryImpl extends InvoicesRepository {
  final InvoicesLocalDataSource _dataSource;

  InvoicesRepositoryImpl({required InvoicesLocalDataSource dataSource})
      : _dataSource = dataSource;
  @override
  Future<Either<Failure, List<ClientModel>>> accoutStatementWithFilters(
      {required Map<String, dynamic> filters}) async {
    try {
      return right(
          await _dataSource.accoutStatementWithFilters(filters: filters));
    } on CacheException catch (e) {
      return Left(CacheFailure(errorMessage: e.message));
    }
  }
}
