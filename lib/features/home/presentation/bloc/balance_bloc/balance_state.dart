part of 'balance_bloc.dart';

sealed class BalanceState extends Equatable {
  const BalanceState();

  @override
  List<Object> get props => [];
}

final class BalanceInitial extends BalanceState {}

class BalanceLoadingState extends BalanceState {}

class BalanceLoadedState extends BalanceState {
  final double balance;

  BalanceLoadedState({required this.balance});
}

class BalanceErrorState extends BalanceState {
  final String message;

  BalanceErrorState({required this.message});
}
