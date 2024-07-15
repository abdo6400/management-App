import 'package:baraneq/features/tanks/domain/repositories/tanks_repository.dart';
import 'package:dartz/dartz.dart';
import '../../../../config/database/error/failures.dart';
import '../../../../core/bloc/usecases/usecase.dart';

class EditTankUsecase implements UseCase< bool, EditTankParams> {
  final TanksRepository _repository;

  EditTankUsecase({required TanksRepository repository})
      : _repository = repository;

  @override
  Future<Either<Failure,  bool>> call(EditTankParams param) =>
      _repository.updateTank(tank: param.toJson());
}

class EditTankParams {
  final int id;
  final double capacity;
final String name;
  EditTankParams({required this.id, required this.capacity,required this.name});

  toJson() => {"id": id, "capacity": capacity,"name": name};
}