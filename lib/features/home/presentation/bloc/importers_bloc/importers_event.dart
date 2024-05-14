part of 'importers_bloc.dart';

sealed class ImportersEvent extends Equatable {
  const ImportersEvent();

  @override
  List<Object> get props => [];
}

class GetImportersClientsEvent  extends ImportersEvent {}
