import '../../../../config/database/local/hive_local_database.dart';
import '../../../../core/models/client_model.dart';

abstract class HomeLocalDataSource {
  Future<List<ClientModel>> getClientsWithFilters({required bool isExporter});

  Future<double> getBalance();
}

class HomeLocalDataSourceImpl extends HomeLocalDataSource {
  final HiveLocalDatabase _localConsumer;

  HomeLocalDataSourceImpl({
    required HiveLocalDatabase localConsumer,
  }) : _localConsumer = localConsumer;

  @override
  Future<List<ClientModel>> getClientsWithFilters(
      {required bool isExporter}) async {
    return List<ClientModel>.from((await _localConsumer
            .getDailyClientsWithFilters(isExporter: isExporter))
        .map((e) => ClientModel.fromJson(e)));
  }

  @override
  Future<double> getBalance() {
    return _localConsumer.getBalance();
  }
}
