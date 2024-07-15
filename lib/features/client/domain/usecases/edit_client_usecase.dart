import 'package:dartz/dartz.dart';
import '../../../../config/database/error/failures.dart';
import '../../../../core/bloc/usecases/usecase.dart';
import '../repositories/client_repository.dart';

class EditClientUsecase implements UseCase<bool, EditClientParams> {
  final ClientRepository _repository;

  EditClientUsecase({required ClientRepository repository})
      : _repository = repository;

  @override
  Future<Either<Failure, bool>> call(EditClientParams params) =>
      _repository.updateClient(client: params.toJson());
}

class EditClientParams {
  final int id;
  final String phone;
  final String name;

  EditClientParams({required this.phone, required this.name, required this.id});

  Map<String, dynamic> toJson() {
    return {"id": id, "phone": phone, "name": name};
  }
}
