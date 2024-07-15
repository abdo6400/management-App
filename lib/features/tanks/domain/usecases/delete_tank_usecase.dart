import 'package:baraneq/features/tanks/domain/repositories/tanks_repository.dart';
import 'package:dartz/dartz.dart';
import '../../../../config/database/error/failures.dart';
import '../../../../core/bloc/usecases/usecase.dart';

class DeleteTankUsecase implements UseCase<bool, int> {
  final TanksRepository _repository;

  DeleteTankUsecase({required TanksRepository repository})
      : _repository = repository;

  @override
  Future<Either<Failure, bool>> call(int id) => _repository.deleteTank(id: id);
}
