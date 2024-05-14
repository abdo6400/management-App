import 'package:dartz/dartz.dart';
import '../../../../config/database/error/failures.dart';
import '../../../../core/entities/client.dart';

abstract class HomeRepository {
  Future<Either<Failure, List<Client>>> getClientsWithFilters(
      {required bool isExporter, required bool isToDay});

  Future<Either<Failure, double>> getBalance();

  Future<Either<Failure, bool>> addReceipt(
      {required Map<String, dynamic> receipt});
  Future<Either<Failure, bool>> editReceipt(
      {required Map<String, dynamic> receipt});
  Future<Either<Failure, bool>> deleteReceipt({required String id});
}
