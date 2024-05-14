part of 'exporter_bloc.dart';

sealed class ExporterEvent extends Equatable {
  const ExporterEvent();

  @override
  List<Object> get props => [];
}

class GetExportersClients extends ExporterEvent {}
