import 'package:dartz/dartz.dart';
import '../../../../config/database/error/failures.dart';
import '../../../../core/entities/client.dart';

abstract class InvoicesRepository {
  Future<Either<Failure, List<Client>>> accoutStatementWithFilters(
      {required Map<String, dynamic> filters});

}
