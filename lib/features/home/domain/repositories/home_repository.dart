import 'package:dartz/dartz.dart';
import '../../../../config/database/error/failures.dart';
import '../../../../core/entities/client.dart';

abstract class HomeRepository {
  Future<Either<Failure, List<Client>>> getClientsWithFilters(
      {required bool isExporter});

  Future<Either<Failure, double>> getBalance();
}
