import 'package:baraneq/features/home/domain/repositories/home_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../config/database/error/failures.dart';
import '../../../../core/bloc/usecases/usecase.dart';

class EditReceiptUsecase implements UseCase<bool, EditReceiptParams> {
  final HomeRepository _repository;

  EditReceiptUsecase({required HomeRepository repository})
      : _repository = repository;

  @override
  Future<Either<Failure, bool>> call(EditReceiptParams params) =>
      _repository.editReceipt(receipt: params.toJson());
}

class EditReceiptParams {
  String? type;
  double? bont;
  double? quantityValue;
  final String id;
  String? tankNumber;
  EditReceiptParams(
      {this.quantityValue,
      this.type,
      this.bont,
      this.tankNumber,
      required this.id});

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "type": type,
      "bont": bont,
      "tankNumber": tankNumber,
      "quantity": quantityValue
    };
  }
}
