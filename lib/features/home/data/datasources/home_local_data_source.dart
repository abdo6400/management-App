import '../../../../config/database/local/sql_local_database.dart';
import '../../../../core/models/client_model.dart';
import '../../../../core/models/search_client_model.dart';

abstract class HomeLocalDataSource {
  Future<List<ClientModel>> getDailyClients(
      {required Map<String, dynamic> options});
  Future<List<SearchClientModel>> searchAboutClient(
      {required Map<String, dynamic> filters});
  Future<Map<String, dynamic>> getBalance();
  Future<bool> addReceipt({required Map<String, dynamic> receipt});
  Future<bool> editReceipt({required Map<String, dynamic> receipt});
  Future<bool> deleteReceipt({required int id});
  Future<List<Map<String, dynamic>>> getTanksInformation(
      {required Map<String, dynamic> options});
}

class HomeLocalDataSourceImpl extends HomeLocalDataSource {
  final SqlLocalDatabase _localConsumer;

  HomeLocalDataSourceImpl({
    required SqlLocalDatabase localConsumer,
  }) : _localConsumer = localConsumer;

  @override
  Future<List<ClientModel>> getDailyClients(
      {required Map<String, dynamic> options}) async {
    return List<ClientModel>.from(
        (await _localConsumer.getDailyClients(options: options))
            .map((e) => ClientModel.fromJson(e)));
  }

  @override
  Future<Map<String, dynamic>> getBalance() {
    return _localConsumer.getBalance();
  }

  @override
  Future<bool> addReceipt({required Map<String, dynamic> receipt}) async {
    try {
      int id = await _localConsumer.insertReceipt({
        'clientId': receipt["clientId"],
        'bont': receipt["bont"],
        'type': receipt["type"],
        'time': receipt["time"]
      });
      Map<int, double> quantities = receipt['quantities'];
      quantities.forEach((k, q) async {
        await _localConsumer
            .insertQuantity({'quantityValue': q, 'receiptId': id, 'tankId': k});
      });
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> deleteReceipt({required int id}) async {
    return _localConsumer.deleteReceipt(id) != -1;
  }

  @override
  Future<bool> editReceipt({required Map<String, dynamic> receipt}) async {
    return _localConsumer.updateReceipt(receipt) != -1;
  }

  @override
  Future<List<SearchClientModel>> searchAboutClient(
      {required Map<String, dynamic> filters}) async {
    return List<SearchClientModel>.from(
        ((await _localConsumer.searchWithNameAboutClient(filters: filters))
            .map((e) => SearchClientModel.fromJson(e))));
  }

  @override
  Future<List<Map<String, dynamic>>> getTanksInformation(
      {required Map<String, dynamic> options}) {
    return _localConsumer.getTanksWithQuantities(options: options);
  }
}
