import 'package:dartz/dartz.dart';

import '../../../../config/database/error/failures.dart';
import '../entities/tank.dart';

abstract class TanksRepository {
  Future<Either<Failure, List<Tank>>> getTanks({required Map<String, dynamic> options});

  Future<Either<Failure, bool>> addTank({required Map<String, dynamic> tank});

  Future<Either<Failure, bool>> deleteTank({required int id});

  Future<Either<Failure, bool>> updateTank({required Map<String, dynamic> tank});
}
