import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/bloc/usecases/usecase.dart';
import '../../../domain/entities/tank.dart';
import '../../../domain/usecases/get_tanks_usecase.dart';

part 'tanks_event.dart';
part 'tanks_state.dart';

class TanksBloc extends Bloc<TanksEvent, TanksState> {
 final GetTanksUsecase _getTanksUsecase;
  TanksBloc(this._getTanksUsecase) : super(TanksInitial()) {
    on<GetTanksEvent>((event, emit) async {
      emit(TanksLoadingState());
      emit(await _getTanksUsecase(event.options).then((value) => value.fold(
          (l) => TanksErrorState(message: l.errorMessage),
          (r) => TanksLoadedState(tanks: r))));
    });
  }
}
