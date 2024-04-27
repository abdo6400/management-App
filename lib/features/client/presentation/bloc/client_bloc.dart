import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/models/client.dart';
import '../../domain/usecases/add_client_usecase.dart';

part 'client_event.dart';
part 'client_state.dart';

class ClientBloc extends Bloc<ClientEvent, ClientState> {
  final AddClientUsecase _clientUsecase;
  ClientBloc(this._clientUsecase) : super(ClientInitial()) {
    on<AddClientEvent>(onAddClientEvent);
  }

  void onAddClientEvent(AddClientEvent event, emit) async {
    emit(ClientLoadingState());
    emit(await _clientUsecase.call(event.client).then((value) => value.fold(
        (l) => ClientErrorState(message: l.errorMessage),
        (r) => ClientLoadedState(result: r))));
  }
}
