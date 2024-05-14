import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../../core/entities/client.dart';
import '../../../domain/usecases/get_clients_with_filters_usecase.dart';

part 'exporter_event.dart';
part 'exporter_state.dart';

class ExporterBloc extends Bloc<ExporterEvent, ExporterState> {
  final GetClientsWithFiltersUsecase _getClientsWithFiltersUsecase;
  ExporterBloc(this._getClientsWithFiltersUsecase) : super(ExporterInitial()) {
    on<GetExportersClientsEvent>(onGetExportersClients);
  }

  void onGetExportersClients(GetExportersClientsEvent event, emit) async {
    emit(ExportersClientsLoadingState());
    emit(await _getClientsWithFiltersUsecase(ClientsFilters(isExporter: true, isToDay: true)).then((value) => value.fold(
        (l) => ExportersClientsErrorState(message: l.errorMessage),
        (r) => ExportersClientsLoadedState(clients: r))));
  }
}
