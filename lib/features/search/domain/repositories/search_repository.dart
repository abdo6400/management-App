import 'package:dartz/dartz.dart';
import '../../../../config/database/error/failures.dart';
import '../../../../core/entities/client.dart';

abstract class SearchRepository {
  Future<Either<Failure, List<Client>>> searchWithFilters(
      {required Map<String, dynamic> filters});

  Future<Either<Failure, double>> getBalance();
  Future<Either<Failure, bool>> editReceipt(
      {required Map<String, dynamic> receipt});
  Future<Either<Failure, bool>> deleteReceipt({required String id});
}
