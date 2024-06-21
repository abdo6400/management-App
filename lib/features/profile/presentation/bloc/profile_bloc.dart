import 'package:baraneq/core/bloc/usecases/usecase.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../domain/usecases/get_tanks_usecase.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final GetTanksUsecase _getTanksUsecase;
  ProfileBloc(this._getTanksUsecase) : super(ProfileInitial()) {
    on<GetTanksEvent>((event, emit) async {
      emit(ProfileLoadingState());
      emit(await _getTanksUsecase(NoParams()).then((value) => value.fold(
          (l) => ProfileErrorState(message: l.errorMessage),
          (r) => ProfileLoadedState(tanks: r))));
    });
  }
}
