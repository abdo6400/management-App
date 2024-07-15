import 'package:baraneq/features/client/domain/usecases/get_clients_usecase.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../domain/entities/client_information.dart';
part 'client_information_event.dart';
part 'client_information_state.dart';

class ClientInformationBloc
    extends Bloc<ClientInformationEvent, ClientInformationState> {
  final GetClientsUsecase _clientUsecase;
  ClientInformationBloc(this._clientUsecase) : super(ClientInitial()) {
    on<GetClientsInformationEvent>(onGetClientEvent);
    on<UpdateClientInformationEvent>(onUpdateClientEvent);
  }

  void onGetClientEvent(GetClientsInformationEvent event, emit) async {
    emit(ClientLoadingState());
    emit(await _clientUsecase.call(event.options).then((value) => value.fold(
        (l) => ClientErrorState(message: l.errorMessage),
        (r) => ClientLoadedState(clients: r, options: event.options))));
  }

  void onUpdateClientEvent(UpdateClientInformationEvent event, emit) async {
    emit(ClientLoadingState());
    emit(await _clientUsecase.call(event.options).then((value) => value.fold(
        (l) => ClientErrorState(message: l.errorMessage),
        (r) => ClientLoadedState(clients: r, options: event.options))));
  }
}
