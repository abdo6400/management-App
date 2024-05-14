import 'package:baraneq/features/home/domain/repositories/home_repository.dart';
import 'package:dartz/dartz.dart';
import '../../../../config/database/error/failures.dart';
import '../../../../core/bloc/usecases/usecase.dart';
import '../../../../core/entities/client.dart';

class GetClientsWithFiltersUsecase
    implements UseCase<List<Client>, ClientsFilters> {
  final HomeRepository _repository;

  GetClientsWithFiltersUsecase({required HomeRepository repository})
      : _repository = repository;

  @override
  Future<Either<Failure, List<Client>>> call(ClientsFilters params) =>
      _repository.getClientsWithFilters(
          isExporter: params.isExporter, isToDay: params.isToDay);
}

class ClientsFilters {
  final bool isExporter;
  final bool isToDay;

  ClientsFilters({required this.isExporter, required this.isToDay});
}
