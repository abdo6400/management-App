part of 'client_bloc.dart';

abstract class ClientState extends Equatable {
  const ClientState();  

  @override
  List<Object> get props => [];
}
class ClientInitial extends ClientState {}
