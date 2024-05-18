part of 'search_bloc.dart';

abstract class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object> get props => [];
}

class SearchInitial extends SearchState {}

class SearchLoadingState extends SearchState {}

class SearchLoadedState extends SearchState {
  final List<Client> clients;

  SearchLoadedState({required this.clients});
}

class SearchErrorState extends SearchState {
  final String message;

  SearchErrorState({required this.message});
}
