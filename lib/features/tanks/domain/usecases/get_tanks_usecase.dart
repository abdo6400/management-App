import 'package:baraneq/features/tanks/domain/repositories/tanks_repository.dart';
import 'package:dartz/dartz.dart';
import '../../../../config/database/error/failures.dart';
import '../../../../core/bloc/usecases/usecase.dart';
import '../entities/tank.dart';

class GetTanksUsecase implements UseCase< List<Tank>, Map<String,dynamic>> {
  final TanksRepository _repository;

  GetTanksUsecase({required TanksRepository repository})
      : _repository = repository;

  @override
  Future<Either<Failure,  List<Tank>>> call(Map<String,dynamic> options) =>
      _repository.getTanks(options: options);
}
