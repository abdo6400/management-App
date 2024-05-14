import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../../core/entities/client.dart';
import '../../../domain/usecases/get_clients_with_filters_usecase.dart';

part 'importers_event.dart';
part 'importers_state.dart';

class ImportersBloc extends Bloc<ImportersEvent, ImportersState> {
  final GetClientsWithFiltersUsecase _getClientsWithFiltersUsecase;
  ImportersBloc(this._getClientsWithFiltersUsecase)
      : super(ImportersInitial()) {
    on<GetImportersClientsEvent>(onGetImportersClients);
  }

  void onGetImportersClients(GetImportersClientsEvent event, emit) async {
    emit(ImportersClientsLoadingState());
    emit(await _getClientsWithFiltersUsecase(
            ClientsFilters(isExporter: true, isToDay: true))
        .then((value) => value.fold(
            (l) => ImportersClientsErrorState(message: l.errorMessage),
            (r) => ImportersClientsLoadedState(clients: r))));
  }
}
