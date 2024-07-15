import 'package:baraneq/features/tanks/domain/repositories/tanks_repository.dart';
import 'package:dartz/dartz.dart';
import '../../../../config/database/error/failures.dart';
import '../../../../core/bloc/usecases/usecase.dart';

class AddTankUsecase implements UseCase<bool, AddTankParams> {
  final TanksRepository _repository;

  AddTankUsecase({required TanksRepository repository})
      : _repository = repository;

  @override
  Future<Either<Failure, bool>> call(AddTankParams params) =>
      _repository.addTank(tank: params.toJson());
}

class AddTankParams {
  final double capacity;
  final String name;

  AddTankParams({required this.capacity, required this.name});
  toJson() => {"capacity": capacity,"name": name};
}
