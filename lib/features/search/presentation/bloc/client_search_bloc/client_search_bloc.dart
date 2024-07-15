
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../../core/entities/search_client.dart';
import '../../../domain/usecases/search_about_client_usecase.dart';

part 'client_search_event.dart';
part 'client_search_state.dart';

class ClientSearchBloc extends Bloc<ClientSearchEvent, ClientSearchState> {
  final SearchAboutClientUsecase _aboutClientUsecase;
  ClientSearchBloc(this._aboutClientUsecase) : super(ClientSearchInitial()) {
    on<SearchClientEvent>(onSearchEvent);
    on<SearchCleanClientEvent>(searchClean);
  }

  void searchClean(SearchCleanClientEvent event, emit) {
    emit(ClientSearchLoadingState());
    emit(ClientSearchLoadedState(clients: []));
  }

  void onSearchEvent(SearchClientEvent event, emit) async {
    emit(ClientSearchLoadingState());

    emit(
      await _aboutClientUsecase(SearchFilters(filters: event.filters)).then(
        (value) => value.fold(
          (l) => ClientSearchErrorState(message: l.errorMessage),
          (r) => ClientSearchLoadedState(clients: r.toList()),
        ),
      ),
    );
  }
}
