import 'package:baraneq/core/entities/search_client.dart';
import 'package:dartz/dartz.dart';
import '../../../../config/database/error/failures.dart';
import '../entities/weekly_client.dart';

abstract class SearchRepository {
  Future<Either<Failure, List<WeeklyClient>>> searchWithFilters(
      {required Map<String, dynamic> filters});

  Future<Either<Failure, List<SearchClient>>> searchWithNameAboutClient(
      {required Map<String, dynamic> filters});
}
