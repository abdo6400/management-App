import 'package:baraneq/core/entities/search_client.dart';
import 'package:baraneq/features/search/domain/entities/weekly_client.dart';
import 'package:baraneq/features/search/domain/usecases/search_with_filters_usecase.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final SearchWithFiltersUsecase _searchAboutClient;
  SearchBloc(this._searchAboutClient) : super(SearchInitial()) {
    on<SearchAboutClientEvent>(onSearchEvent);
    on<SearchCleanEvent>(searchClean);
  }

  void searchClean(SearchCleanEvent event, emit) {
    emit(SearchLoadingState());
    emit(SearchLoadedState(clients: []));
  }

  void onSearchEvent(SearchAboutClientEvent event, emit) async {
    emit(SearchLoadingState());
    emit(
      await _searchAboutClient(SearchFilters(filters: event.value)).then(
        (value) => value.fold(
          (l) => SearchErrorState(message: l.errorMessage),
          (r) => SearchLoadedState(clients: r.toList()),
        ),
      ),
    );
  }
}
