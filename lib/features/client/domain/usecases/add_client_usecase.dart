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
  final String id;
  final String phone;
  final String name;
  final String clientType;

  AddClientParams(
      {required this.id,
      required this.phone,
      required this.name,
      required this.clientType});

  Map<String, dynamic> toJson() {
    return {"id": id, "phone": phone, "name": name, "clientType": clientType};
  }
}
