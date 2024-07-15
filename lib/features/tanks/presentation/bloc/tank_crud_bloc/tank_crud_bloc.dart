import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/usecases/add_tank_usecase.dart';
import '../../../domain/usecases/delete_tank_usecase.dart';
import '../../../domain/usecases/edit_tank_usecase.dart';

part 'tank_crud_event.dart';
part 'tank_crud_state.dart';

class TankCrudBloc extends Bloc<TankCrudEvent, TankCrudState> {
  final AddTankUsecase _addTankUsecase;
  final DeleteTankUsecase _deleteTankUsecase;
  final EditTankUsecase _editTankUsecase;
  TankCrudBloc(
      this._addTankUsecase, this._deleteTankUsecase, this._editTankUsecase)
      : super(TankCrudInitial()) {
    on<AddNewTankEvent>(onAddNewTankEvent);
  }

  void onAddNewTankEvent(AddNewTankEvent event, emit) async {
    emit(AddTankLoadingState());
    emit(await _addTankUsecase.call(event.tank).then((value) => value.fold(
        (l) => AddTankErrorState(message: l.errorMessage),
        (r) => AddTankLoadedState(result: r))));
  }
}
