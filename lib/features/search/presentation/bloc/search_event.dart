part of 'search_bloc.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object> get props => [];
}

class SearchAboutClient extends SearchEvent {
  final Map<String, dynamic> value;

  SearchAboutClient({required this.value});
}
