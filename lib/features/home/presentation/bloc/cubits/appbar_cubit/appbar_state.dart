part of 'appbar_cubit.dart';

sealed class AppbarState extends Equatable {
  const AppbarState();

  @override
  List<Object> get props => [];
}

final class AppbarInitial extends AppbarState {}

class ChangeIndex extends AppbarState {}
