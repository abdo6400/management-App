part of 'client_information_bloc.dart';

abstract class ClientInformationEvent extends Equatable {
  const ClientInformationEvent();

  @override
  List<Object> get props => [];
}

class GetClientsInformationEvent extends ClientInformationEvent {
  final Map<String, dynamic> options;
  GetClientsInformationEvent( {required this.options});
}

class UpdateClientInformationEvent extends ClientInformationEvent {
  final Map<String, dynamic> options;
  UpdateClientInformationEvent( {required this.options});
}