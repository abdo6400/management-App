import 'package:baraneq/config/database/error/exceptions.dart';
import 'package:baraneq/config/database/error/failures.dart';

import 'package:dartz/dartz.dart';

import '../../../../core/entities/search_client.dart';
import '../../domain/entities/weekly_client.dart';
import '../../domain/repositories/search_repository.dart';
import '../datasources/search_local_data_source.dart';

class SearchRepositoryImpl extends SearchRepository {
  final SearchLocalDataSource _dataSource;

  SearchRepositoryImpl({required SearchLocalDataSource dataSource})
      : _dataSource = dataSource;
  @override
  Future<Either<Failure, List<WeeklyClient>>> searchWithFilters(
      {required Map<String, dynamic> filters}) async {
    try {
      return right(await _dataSource.searchWithFilters(filters: filters));
    } on CacheException catch (e) {
      return Left(CacheFailure(errorMessage: e.message));
    }
  }

  @override
  Future<Either<Failure, List<SearchClient>>> searchWithNameAboutClient(
      {required Map<String, dynamic> filters}) async {
    try {
      return right(
          await _dataSource.searchWithNameAboutClient(filters: filters));
    } on CacheException catch (e) {
      return Left(CacheFailure(errorMessage: e.message));
    }
  }
}
