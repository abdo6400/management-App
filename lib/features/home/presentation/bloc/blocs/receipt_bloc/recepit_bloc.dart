import 'package:baraneq/features/home/domain/usecases/add_receipt_usecase.dart';
import 'package:baraneq/features/home/domain/usecases/delete_receipt_usecase.dart';
import 'package:baraneq/features/home/domain/usecases/edit_receipt_usecase.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'recepit_event.dart';
part 'recepit_state.dart';

class RecepitBloc extends Bloc<RecepitEvent, RecepitState> {
  final AddReceiptUsecase _addReceiptUsecase;
  final EditReceiptUsecase _editReceiptUsecase;
  final DeleteReceiptUsecase _deleteReceiptUsecase;
  RecepitBloc(this._addReceiptUsecase, this._editReceiptUsecase,
      this._deleteReceiptUsecase)
      : super(RecepitInitial()) {
    on<AddReceiptEvent>(_onAddReceiptEvent);
    on<EditReceiptEvent>(_onEditReceiptEvent);
    on<DeleteReceiptEvent>(_onDeleteReceiptEvent);
  }

  void _onAddReceiptEvent(AddReceiptEvent event, emit) async {
    emit(RecepitLoadingState());
    emit(await _addReceiptUsecase(event.addReceiptParams).then((value) =>
        value.fold((l) => RecepitLoadErrorState(message: l.errorMessage),
            (r) => RecepitAddLoadedState())));
  }

  void _onEditReceiptEvent(EditReceiptEvent event, emit) async {
    emit(RecepitLoadingState());
    emit(await _editReceiptUsecase(event.editReceiptParams).then((value) =>
        value.fold((l) => RecepitLoadErrorState(message: l.errorMessage),
            (r) => RecepitEditLoadedState())));
  }

  void _onDeleteReceiptEvent(DeleteReceiptEvent event, emit) async {
    emit(RecepitLoadingState());
    try {
      event.ids.forEach((id) async {
        await _deleteReceiptUsecase(id);
      });
      emit(RecepitDeleteLoadedState());
    } catch (e) {
      emit(RecepitLoadErrorState(message: e.toString()));
    }
  }
}
