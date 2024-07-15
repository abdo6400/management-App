import 'package:dartz/dartz.dart';
import '../../../../config/database/error/failures.dart';
import '../../../../core/bloc/usecases/usecase.dart';
import '../repositories/client_repository.dart';

class DeleteClientUsecase implements UseCase<bool, int> {
  final ClientRepository _repository;

  DeleteClientUsecase({required ClientRepository repository})
      : _repository = repository;

  @override
  Future<Either<Failure, bool>> call(int id) =>
      _repository.deleteClient(id: id);
}
