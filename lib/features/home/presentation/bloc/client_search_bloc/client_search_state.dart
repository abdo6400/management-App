part of 'client_search_bloc.dart';

sealed class ClientSearchState extends Equatable {
  const ClientSearchState();

  @override
  List<Object> get props => [];
}

final class ClientSearchInitial extends ClientSearchState {}

final class ClientSearchLoadingState extends ClientSearchState {}

final class ClientSearchLoadedState extends ClientSearchState {
  final List<Client> clients;
 
  ClientSearchLoadedState({required this.clients});
}

final class ClientSearchErrorState extends ClientSearchState {
  final String message;

  ClientSearchErrorState({required this.message});
}
