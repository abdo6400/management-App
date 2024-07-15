part of 'clients_bloc.dart';

sealed class ClientsEvent extends Equatable {
  const ClientsEvent();

  @override
  List<Object> get props => [];
}

class GetClientsEvent  extends ClientsEvent {
  final Map<String,dynamic> options;
  const GetClientsEvent({required this.options});
}
