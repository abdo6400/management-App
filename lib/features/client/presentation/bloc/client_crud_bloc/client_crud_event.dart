part of 'client_crud_bloc.dart';

sealed class ClientCrudEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class AddNewClientEvent extends ClientCrudEvent {
  final AddClientParams client;

  AddNewClientEvent({required this.client});
}
