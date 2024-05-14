part of 'exporter_bloc.dart';

sealed class ExporterState extends Equatable {
  const ExporterState();

  @override
  List<Object> get props => [];
}

final class ExporterInitial extends ExporterState {}

class ExportersClientsLoadingState extends ExporterState {}

class ExportersClientsLoadedState extends ExporterState {
  final List<Client> clients;

  ExportersClientsLoadedState({required this.clients});
}

class ExportersClientsErrorState extends ExporterState {
  final String message;

  ExportersClientsErrorState({required this.message});
}
