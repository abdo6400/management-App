part of 'invoices_bloc.dart';

abstract class InvoicesEvent extends Equatable {
  const InvoicesEvent();

  @override
  List<Object> get props => [];
}

class AccountStatementEvent extends InvoicesEvent {
  final Map<String, dynamic> value;

  AccountStatementEvent({required this.value});
}
