import '../../../../config/database/local/sql_local_database.dart';
import '../models/client_information_model.dart';

abstract class ClientLocalDataSource {
  Future<bool> addClient({required Map<String, dynamic> client});

  Future<bool> deleteClient({required int id});

  Future<bool> updateClient({required Map<String, dynamic> client});

  Future<List<ClientInformationModel>> getClients({required Map<String, dynamic> options});

}

class ClientLocalDataSourceImpl extends ClientLocalDataSource {
  final SqlLocalDatabase _localConsumer;

  ClientLocalDataSourceImpl({
    required SqlLocalDatabase localConsumer,
  }) : _localConsumer = localConsumer;

  @override
  Future<bool> addClient({required Map<String, dynamic> client}) async {
    return _localConsumer.insertClient(client) != -1;
  }

  @override
  Future<bool> deleteClient({required int id}) async {
    return _localConsumer.deleteClient(id) != -1;
  }

  @override
  Future<List<ClientInformationModel>> getClients({required Map<String, dynamic> options}) async {
    return List<ClientInformationModel>.from(
        ((await _localConsumer.getClientsWithReceiptsCount(options: options))
            .map((e) => ClientInformationModel.fromJson(e))));
  }

  @override
  Future<bool> updateClient({required Map<String, dynamic> client}) async {
    return _localConsumer.updateClient(client) != -1;
  }
}
