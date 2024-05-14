part of 'client_search_bloc.dart';

sealed class ClientSearchEvent extends Equatable {
  const ClientSearchEvent();

  @override
  List<Object> get props => [];
}

class SearchClientEvent extends ClientSearchEvent {
  final String value;
  final bool isExporter;
  SearchClientEvent({required this.value,required this.isExporter});
}
