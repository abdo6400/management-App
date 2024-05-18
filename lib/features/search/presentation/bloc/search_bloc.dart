import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/entities/client.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final SearchAboutClient _aboutClient;
  SearchBloc(this._aboutClient) : super(SearchInitial()) {
    on<SearchEvent>((event, emit) {
      
    });
  }
}
