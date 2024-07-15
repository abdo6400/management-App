part of 'tank_crud_bloc.dart';

sealed class TankCrudEvent extends Equatable {
  const TankCrudEvent();

  @override
  List<Object> get props => [];
}

class AddNewTankEvent extends TankCrudEvent {
  final AddTankParams tank;

  AddNewTankEvent({required this.tank});
}
