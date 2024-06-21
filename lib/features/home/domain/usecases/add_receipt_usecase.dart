import 'package:baraneq/features/home/domain/repositories/home_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../config/database/error/failures.dart';
import '../../../../core/bloc/usecases/usecase.dart';

class AddReceiptUsecase implements UseCase<bool, AddReceiptParams> {
  final HomeRepository _repository;

  AddReceiptUsecase({required HomeRepository repository})
      : _repository = repository;

  @override
  Future<Either<Failure, bool>> call(AddReceiptParams params) =>
      _repository.addReceipt(receipt: params.toJson());
}

class AddReceiptParams {
  final String type;
  final double bont;
  final Map<String, String> tanks;
  final String clientId;
  AddReceiptParams(
      {required this.tanks,
      required this.type,
      required this.bont,
      required this.clientId});

  Map<String, dynamic> toJson() {
    return {"type": type, "bont": bont, "tanks": tanks, "clientId": clientId};
  }
}
