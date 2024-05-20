part of 'invoices_bloc.dart';

abstract class InvoicesState extends Equatable {
  const InvoicesState();

  @override
  List<Object> get props => [];
}

class InvoicesInitial extends InvoicesState {}

class AccountStatementLoadingState extends InvoicesState {}

class AccountStatementLoadedState extends InvoicesState {
  final List<Client> clients;

  AccountStatementLoadedState({required this.clients});
}

class AccountStatementErrorState extends InvoicesState {
  final String message;

  AccountStatementErrorState({required this.message});
}
