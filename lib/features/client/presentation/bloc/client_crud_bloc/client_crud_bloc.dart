import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/usecases/add_client_usecase.dart';
import '../../../domain/usecases/delete_client_usecase.dart';
import '../../../domain/usecases/edit_client_usecase.dart';

part 'client_crud_event.dart';
part 'client_crud_state.dart';

class ClientCrudBloc extends Bloc<AddNewClientEvent, ClientCrudState> {
  final AddClientUsecase _clientUsecase;
  final EditClientUsecase _editClientUsecase;
  final DeleteClientUsecase _deleteClientUsecase;
  ClientCrudBloc(
      this._clientUsecase, this._editClientUsecase, this._deleteClientUsecase)
      : super(AddClientInitial()) {
    on<AddNewClientEvent>(onAddNewClientEvent);
  }

  void onAddNewClientEvent(AddNewClientEvent event, emit) async {
    emit(AddClientLoadingState());
    emit(await _clientUsecase.call(event.client).then((value) => value.fold(
        (l) => AddClientErrorState(message: l.errorMessage),
        (r) => AddClientLoadedState(result: r))));
  }
}
