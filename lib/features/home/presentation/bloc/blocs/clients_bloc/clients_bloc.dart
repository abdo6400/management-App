import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../../../core/entities/client.dart';
import '../../../../domain/usecases/get_daily_clients.dart';

part 'clients_event.dart';
part 'clients_state.dart';

class ClientsBloc extends Bloc<ClientsEvent, ClientsState> {
  final getDailyClientsUsecase _dailyClientsUsecase;
  ClientsBloc(this._dailyClientsUsecase) : super(ClientsInitial()) {
    on<GetClientsEvent>(onGetClients);
  }

  void onGetClients(GetClientsEvent event, emit) async {
    emit(ClientsLoadingState());
    emit(await _dailyClientsUsecase(event.options).then((value) => value.fold(
        (l) => ClientsErrorState(message: l.errorMessage),
        (r) => ClientsLoadedState(clients: r))));
  }
}
