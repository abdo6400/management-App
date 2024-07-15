import 'package:baraneq/features/home/domain/repositories/home_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../config/database/error/failures.dart';
import '../../../../core/bloc/usecases/usecase.dart';

class GetBalanceUsecase implements UseCase<Map<String,dynamic>, NoParams> {
  final HomeRepository _repository;

  GetBalanceUsecase({required HomeRepository repository})
      : _repository = repository;

  @override
  Future<Either<Failure, Map<String,dynamic>>> call(NoParams params) =>
      _repository.getBalance();
}
