import 'package:baraneq/features/home/domain/repositories/home_repository.dart';
import 'package:dartz/dartz.dart';
import '../../../../config/database/error/failures.dart';
import '../../../../core/bloc/usecases/usecase.dart';

class GetTanksInformationUsecase
    implements UseCase<List<Map<String, dynamic>>, Map<String,dynamic>> {
  final HomeRepository _repository;

  GetTanksInformationUsecase({required HomeRepository repository})
      : _repository = repository;

  @override
  Future<Either<Failure, List<Map<String, dynamic>>>> call(Map<String,dynamic> options) =>
      _repository.getTanksInformation(options: options);
}
