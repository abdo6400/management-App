part of 'recepit_bloc.dart';

sealed class RecepitState extends Equatable {
  const RecepitState();

  @override
  List<Object> get props => [];
}

final class RecepitInitial extends RecepitState {}

class RecepitLoadErrorState extends RecepitState {
  final String message;

  RecepitLoadErrorState({required this.message});
}

class RecepitLoadingState extends RecepitState {}

class RecepitAddLoadedState extends RecepitState {}

class RecepitEditLoadedState extends RecepitState {}

class RecepitDeleteLoadedState extends RecepitState {}
