part of 'client_search_bloc.dart';

sealed class ClientSearchEvent extends Equatable {
  const ClientSearchEvent();

  @override
  List<Object> get props => [];
}

class SearchClientEvent extends ClientSearchEvent {
  final Map<String,dynamic> filters;

  SearchClientEvent({required this.filters});
}


class SearchCleanClientEvent extends ClientSearchEvent {}