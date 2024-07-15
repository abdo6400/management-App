import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'appbar_state.dart';

class AppbarCubit extends Cubit<AppbarState> {
  AppbarCubit() : super(AppbarInitial());
  int selected = 0;
  void changeSelected(int index) {
    emit(AppbarInitial());
    selected = index;
    emit(ChangeIndex());
  }
}
