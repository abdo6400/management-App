part of 'client_bloc.dart';

abstract class ClientEvent extends Equatable {
  const ClientEvent();

  @override
  List<Object> get props => [];
}

class AddClientEvent extends ClientEvent {
  final Client client;

  AddClientEvent({required this.client});
}
