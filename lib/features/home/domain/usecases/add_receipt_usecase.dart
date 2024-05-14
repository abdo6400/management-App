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
  final double bant;
  final double quantityValue;
  final String id;
  final String clientId;
  AddReceiptParams(
      {required this.quantityValue,
      required this.type,
      required this.bant,
      required this.id,
      required this.clientId});

  Map<String, dynamic> toJson() {
    return {
      "type": type,
      "bant": bant,
      "quantity": quantityValue,
      "clientId": clientId
    };
  }
}
