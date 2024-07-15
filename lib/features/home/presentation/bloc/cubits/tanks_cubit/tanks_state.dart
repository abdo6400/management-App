part of 'tanks_cubit.dart';

sealed class TanksState extends Equatable {
  const TanksState();

  @override
  List<Object> get props => [];
}

final class TanksInitial extends TanksState {}

final class TanksChanged extends TanksState {}
