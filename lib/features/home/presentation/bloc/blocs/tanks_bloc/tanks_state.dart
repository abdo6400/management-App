part of 'tanks_bloc.dart';

abstract class TanksInformationState extends Equatable {
  const TanksInformationState();  

  @override
  List<Object> get props => [];
}
class TanksInitial extends TanksInformationState {}



class TanksLoadingState extends TanksInformationState {}

class TanksLoadedState extends TanksInformationState {
  final  List<Map<String, dynamic>> tanks;

  TanksLoadedState({required this.tanks});
}

class TanksErrorState extends TanksInformationState {
  final String message;

  TanksErrorState({required this.message});
}
