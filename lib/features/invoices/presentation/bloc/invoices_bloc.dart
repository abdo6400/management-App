import 'package:baraneq/features/invoices/domain/usecases/account_statement_with_filters_usecase.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/entities/client.dart';

part 'invoices_event.dart';
part 'invoices_state.dart';

class InvoicesBloc extends Bloc<InvoicesEvent, InvoicesState> {
  final AccountStatementWithFiltersUsecase _filtersUsecase;
  InvoicesBloc(this._filtersUsecase) : super(InvoicesInitial()) {
    on<AccountStatementEvent>(onAccountStatementEvent);
  }

  void onAccountStatementEvent(AccountStatementEvent event, emit) async {
    emit(AccountStatementLoadingState());
    emit(
      await _filtersUsecase(InvoicesFilters(filters: event.value)).then(
        (value) => value.fold(
          (l) => AccountStatementErrorState(message: l.errorMessage),
          (r) => AccountStatementLoadedState(clients: r.toList()),
        ),
      ),
    );
  }
}
