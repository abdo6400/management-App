

import 'package:baraneq/features/home/domain/repositories/home_repository.dart';
import 'package:dartz/dartz.dart';
import '../../../../config/database/error/failures.dart';
import '../../../../core/bloc/usecases/usecase.dart';
import '../../../../core/entities/client.dart';


class GetClientsWithFiltersUsecase implements UseCase<List<Client>, bool> {
  final HomeRepository _repository;

  GetClientsWithFiltersUsecase({required HomeRepository repository})
      : _repository = repository;

  @override
  Future<Either<Failure, List<Client>>> call(bool params) =>
      _repository.getClientsWithFilters(isExporter: params);
}
