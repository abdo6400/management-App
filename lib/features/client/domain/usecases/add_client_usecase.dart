import 'package:dartz/dartz.dart';
import '../../../../config/database/error/failures.dart';
import '../../../../core/bloc/usecases/usecase.dart';
import '../repositories/client_repository.dart';

class AddClientUsecase implements UseCase<bool, AddClientParams> {
  final ClientRepository _repository;

  AddClientUsecase({required ClientRepository repository})
      : _repository = repository;

  @override
  Future<Either<Failure, bool>> call(AddClientParams params) =>
      _repository.addClient(client: params.toJson());
}

class AddClientParams {
  final String phone;
  final String name;
 

  AddClientParams(
      {
      required this.phone,
      required this.name,
     });

  Map<String, dynamic> toJson() {
    return {"phone": phone, "name": name};
  }
}
