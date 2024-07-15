import 'package:baraneq/features/client/domain/entities/client_information.dart';
import 'package:dartz/dartz.dart';
import '../../../../config/database/error/failures.dart';
import '../../../../core/bloc/usecases/usecase.dart';
import '../repositories/client_repository.dart';

class GetClientsUsecase implements UseCase<List<ClientInformation>, Map<String,dynamic>> {
  final ClientRepository _repository;

  GetClientsUsecase({required ClientRepository repository})
      : _repository = repository;

  @override
  Future<Either<Failure, List<ClientInformation>>> call(Map<String,dynamic> options) =>
      _repository.getClients(options: options);
}
