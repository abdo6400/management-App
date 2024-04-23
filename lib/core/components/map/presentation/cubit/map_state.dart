part of 'map_cubit.dart';

abstract class MapState extends Equatable {
  const MapState();

  @override
  List<Object> get props => [];
}

class MapInitial extends MapState {}

class MapChange extends MapState {}

class MapChanged extends MapState {}

class MapGetMyLocationLoadingState extends MapState {}

class MapGetMyLocationLoadedState extends MapState {}

class MapGetMyLocationErrorState extends MapState {}
