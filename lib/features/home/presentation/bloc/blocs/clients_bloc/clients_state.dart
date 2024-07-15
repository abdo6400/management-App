part of 'clients_bloc.dart';

sealed class ClientsState extends Equatable {
  const ClientsState();
  
  @override
  List<Object> get props => [];
}

final class ClientsInitial extends ClientsState {}


class ClientsLoadingState extends ClientsState {}

class ClientsLoadedState extends ClientsState {
  final List<Client> clients;

  ClientsLoadedState({required this.clients});
}

class ClientsErrorState extends ClientsState {
  final String message;

  ClientsErrorState({required this.message});
}