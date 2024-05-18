import 'package:baraneq/features/home/domain/repositories/home_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../config/database/error/failures.dart';
import '../../../../core/bloc/usecases/usecase.dart';

class DeleteReceiptUsecase implements UseCase<bool, String> {
  final HomeRepository _repository;

  DeleteReceiptUsecase({required HomeRepository repository})
      : _repository = repository;

  @override
  Future<Either<Failure, bool>> call(String params) =>
      _repository.deleteReceipt(id: params);
}
