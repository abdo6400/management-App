part of 'client_crud_bloc.dart';

sealed class ClientCrudState extends Equatable {
  const ClientCrudState();

  @override
  List<Object> get props => [];
}

final class AddClientInitial extends ClientCrudState {}

class AddClientLoadingState extends ClientCrudState {}

class AddClientLoadedState extends ClientCrudState {
  final bool result;

  AddClientLoadedState({required this.result});
}

class AddClientErrorState extends ClientCrudState {
  final String message;

  AddClientErrorState({required this.message});
}
