import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:supercharged/supercharged.dart';

import '../../../../../core/entities/client.dart';
import '../../../domain/usecases/get_clients_with_filters_usecase.dart';

part 'client_search_event.dart';
part 'client_search_state.dart';

class ClientSearchBloc extends Bloc<ClientSearchEvent, ClientSearchState> {
  final GetClientsWithFiltersUsecase _getClientsWithFiltersUsecase;
  ClientSearchBloc(this._getClientsWithFiltersUsecase)
      : super(ClientSearchInitial()) {
    on<SearchClientEvent>(onSearchEvent);
    on<SearchCleanClientEvent>(searchClean);
  }

  void searchClean(SearchCleanClientEvent event, emit) {
    emit(ClientSearchLoadedState(clients: []));
  }

  void onSearchEvent(SearchClientEvent event, emit) async {
    emit(ClientSearchLoadingState());

    emit(
      await _getClientsWithFiltersUsecase(
              ClientsFilters(isExporter: event.isExporter, isToDay: false))
          .then(
        (value) => value.fold(
          (l) => ClientSearchErrorState(message: l.errorMessage),
          (r) => ClientSearchLoadedState(
              clients: r
                  .filter((f) =>
                      f.id.compareTo(event.value) == 0 ||
                      f.name.contains(event.value) ||
                      f.phoneNumber.contains(event.value))
                  .toList()),
        ),
      ),
    );
  }
}
