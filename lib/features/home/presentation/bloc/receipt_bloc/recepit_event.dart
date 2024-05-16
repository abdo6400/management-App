part of 'recepit_bloc.dart';

sealed class RecepitEvent extends Equatable {
  const RecepitEvent();

  @override
  List<Object> get props => [];
}

class AddReceiptEvent extends RecepitEvent {
  final AddReceiptParams addReceiptParams;

  AddReceiptEvent({required this.addReceiptParams});
}

class EditReceiptEvent extends RecepitEvent {
  final EditReceiptParams editReceiptParams;

  EditReceiptEvent({required this.editReceiptParams});
}

class DeleteReceiptEvent extends RecepitEvent {
  final String id;

  DeleteReceiptEvent({required this.id});
}
