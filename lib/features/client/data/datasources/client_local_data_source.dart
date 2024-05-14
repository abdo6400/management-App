import '../../../../config/database/api/api_consumer.dart';
import '../../../../config/database/local/hive_local_database.dart';
import '../../../../core/models/client.dart';

abstract class ClientLocalDataSource {
  Future<bool> addClient({required Client client});
}

class ClientLocalDataSourceImpl extends ClientLocalDataSource {
  final HiveLocalDatabase _localConsumer;
  final ApiConsumer _apiConsumer;
  ClientLocalDataSourceImpl(
      {required HiveLocalDatabase localConsumer,
      required ApiConsumer apiConsumer})
      : _localConsumer = localConsumer,
        _apiConsumer = apiConsumer;

  @override
  Future<bool> addClient({required Client client}) async {
    return await _localConsumer.addClient(client: client);
  }
}
