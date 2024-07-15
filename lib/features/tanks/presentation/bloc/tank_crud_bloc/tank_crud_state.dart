part of 'tank_crud_bloc.dart';

sealed class TankCrudState extends Equatable {
  const TankCrudState();

  @override
  List<Object> get props => [];
}

final class TankCrudInitial extends TankCrudState {}

class AddTankLoadingState extends TankCrudState {}

class AddTankLoadedState extends TankCrudState {
  final bool result;

  AddTankLoadedState({required this.result});
}

class AddTankErrorState extends TankCrudState {
  final String message;

  AddTankErrorState({required this.message});
}
