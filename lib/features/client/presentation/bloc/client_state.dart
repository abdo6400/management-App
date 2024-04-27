part of 'client_bloc.dart';

abstract class ClientState extends Equatable {
  const ClientState();

  @override
  List<Object> get props => [];
}

class ClientInitial extends ClientState {}

class ClientLoadingState extends ClientState {}

class ClientLoadedState extends ClientState {
  final bool result;

  ClientLoadedState({required this.result});
}

class ClientErrorState extends ClientState {final String message;

  ClientErrorState({required this.message});}
