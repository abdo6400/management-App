part of 'importers_bloc.dart';

sealed class ImportersState extends Equatable {
  const ImportersState();
  
  @override
  List<Object> get props => [];
}

final class ImportersInitial extends ImportersState {}


class ImportersClientsLoadingState extends ImportersState {}

class ImportersClientsLoadedState extends ImportersState {
  final List<Client> clients;

  ImportersClientsLoadedState({required this.clients});
}

class ImportersClientsErrorState extends ImportersState {
  final String message;

  ImportersClientsErrorState({required this.message});
}