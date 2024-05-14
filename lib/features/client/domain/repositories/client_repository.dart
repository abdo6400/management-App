import 'package:dartz/dartz.dart';
import '../../../../config/database/error/failures.dart';

abstract class ClientRepository {
  Future<Either<Failure, bool>> addClient(
      {required Map<String, dynamic> client});
}
