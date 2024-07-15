import 'package:baraneq/features/home/domain/repositories/home_repository.dart';
import 'package:dartz/dartz.dart';
import '../../../../config/database/error/failures.dart';
import '../../../../core/bloc/usecases/usecase.dart';
import '../../../../core/entities/client.dart';

class getDailyClientsUsecase
    implements UseCase<List<Client>, Map<String, dynamic>> {
  final HomeRepository _repository;

  getDailyClientsUsecase({required HomeRepository repository})
      : _repository = repository;

  @override
  Future<Either<Failure, List<Client>>> call(Map<String, dynamic> options) =>
      _repository.getDailyClients(options: options);
}
