import 'package:dartz/dartz.dart';
import '../../../../config/database/error/failures.dart';
import '../../../../core/entities/client.dart';

abstract class SearchRepository {
  Future<Either<Failure, List<Client>>> searchWithFilters(
      {required Map<String, dynamic> filters});

}
