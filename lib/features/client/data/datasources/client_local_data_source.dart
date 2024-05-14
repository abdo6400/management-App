import '../../../../config/database/local/hive_local_database.dart';

abstract class ClientLocalDataSource {
  Future<bool> addClient({required Map<String, dynamic> client});
}

class ClientLocalDataSourceImpl extends ClientLocalDataSource {
  final HiveLocalDatabase _localConsumer;

  ClientLocalDataSourceImpl({
    required HiveLocalDatabase localConsumer,
  }) : _localConsumer = localConsumer;

  @override
  Future<bool> addClient({required Map<String, dynamic> client}) async {
    return await _localConsumer.addClient(client: client);
  }
}
