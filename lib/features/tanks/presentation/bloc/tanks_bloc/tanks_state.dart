part of 'tanks_bloc.dart';

abstract class TanksState extends Equatable {
  const TanksState();  

  @override
  List<Object> get props => [];
}
class TanksInitial extends TanksState {}



class TanksLoadingState extends TanksState {}

class TanksLoadedState extends TanksState {
  final  List<Tank> tanks;

  TanksLoadedState({required this.tanks});
}

class TanksErrorState extends TanksState {
  final String message;

  TanksErrorState({required this.message});
}
