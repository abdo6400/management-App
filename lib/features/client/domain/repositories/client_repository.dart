import 'package:dartz/dartz.dart';

import '../../../../config/database/error/failures.dart';
import '../../../../core/models/client.dart';

abstract class ClientRepository {
  Future<Either<Failure, bool>> addClient({required Client client});
}
