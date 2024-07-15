import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../domain/usecases/get_tanks_information_usecase.dart';
part 'tanks_event.dart';
part 'tanks_state.dart';

class TanksInformationBloc
    extends Bloc<TanksInformationEvent, TanksInformationState> {
  final GetTanksInformationUsecase _getTanksInformationUsecase;
  TanksInformationBloc(this._getTanksInformationUsecase)
      : super(TanksInitial()) {
    on<GetTanksInformationEvent>((event, emit) async {
      emit(TanksLoadingState());
      emit(await _getTanksInformationUsecase(event.options).then((value) => value.fold(
          (l) => TanksErrorState(message: l.errorMessage),
          (r) => TanksLoadedState(tanks: r))));
    });
  }
}
