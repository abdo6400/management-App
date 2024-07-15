part of 'client_information_bloc.dart';

abstract class ClientInformationState extends Equatable {
  const ClientInformationState();

  @override
  List<Object> get props => [];
}

class ClientInitial extends ClientInformationState {}

class ClientLoadingState extends ClientInformationState {}

class ClientLoadedState extends ClientInformationState {
  final List<ClientInformation> clients;
  final Map<String, dynamic> options;
  ClientLoadedState({required this.clients, required this.options});
}

class ClientErrorState extends ClientInformationState {
  final String message;

  ClientErrorState({required this.message});
}

class CLientUpdateState extends ClientInformationState {}
