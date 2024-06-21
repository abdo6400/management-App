import 'package:dartz/dartz.dart';
import '../../../../config/database/error/failures.dart';
import '../../../../core/bloc/usecases/usecase.dart';

import '../repositories/profile_repositort.dart';

class GetTanksUsecase implements UseCase<Map<String, double>, NoParams> {
  final ProfileRepositort _repository;

  GetTanksUsecase({required ProfileRepositort repository})
      : _repository = repository;

  @override
  Future<Either<Failure, Map<String, double>>> call(NoParams) =>
      _repository.getTanks();
}
