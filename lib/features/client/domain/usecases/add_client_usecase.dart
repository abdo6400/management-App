import 'package:dartz/dartz.dart';

import '../../../../config/database/error/failures.dart';
import '../../../../core/bloc/usecases/usecase.dart';
import '../../../../core/models/client.dart';
import '../repositories/client_repository.dart';

class AddClientUsecase implements UseCase<bool, Client> {
  final ClientRepository _repository;

  AddClientUsecase({required ClientRepository repository})
      : _repository = repository;

  @override
  Future<Either<Failure, bool>> call(Client params) =>
      _repository.addClient(client: params);
}
