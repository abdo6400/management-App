import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/bloc/usecases/usecase.dart';
import '../../../domain/usecases/get_balance_usecase.dart';

part 'balance_event.dart';
part 'balance_state.dart';

class BalanceBloc extends Bloc<BalanceEvent, BalanceState> {
  final GetBalanceUsecase _getBalanceUsecase;
  BalanceBloc(this._getBalanceUsecase) : super(BalanceInitial()) {
    on<GetBalance>(onGetBalanceEvent);
  }

  void onGetBalanceEvent(GetBalance event, emit) async {
    emit(BalanceLoadingState());

    emit(await _getBalanceUsecase(NoParams()).then((value) => value.fold(
        (l) => BalanceErrorState(message: l.errorMessage),
        (r) => BalanceLoadedState(balance: r))));
  }
}
