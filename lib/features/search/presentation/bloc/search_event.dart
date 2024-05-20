part of 'search_bloc.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object> get props => [];
}

class SearchAboutClientEvent extends SearchEvent {
  final Map<String, dynamic> value;

  SearchAboutClientEvent({required this.value});
}

class SearchCleanEvent extends SearchEvent {}
