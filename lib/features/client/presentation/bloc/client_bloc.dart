import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'client_event.dart';
part 'client_state.dart';

class ClientBloc extends Bloc<ClientEvent, ClientState> {
  ClientBloc() : super(ClientInitial()) {
    on<ClientEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
