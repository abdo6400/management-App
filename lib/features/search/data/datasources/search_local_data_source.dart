import '../../../../config/database/local/hive_local_database.dart';
import '../../../../core/models/client_model.dart';

abstract class SearchLocalDataSource {
  Future<List<ClientModel>> searchWithFilters(
      {required Map<String, dynamic> filters});

  Future<double> getBalance();
  Future<bool> editReceipt({required Map<String, dynamic> receipt});
  Future<bool> deleteReceipt({required String id});
}

class SearchLocalDataSourceImpl extends SearchLocalDataSource {
  final HiveLocalDatabase _localConsumer;

  SearchLocalDataSourceImpl({
    required HiveLocalDatabase localConsumer,
  }) : _localConsumer = localConsumer;

  @override
  Future<List<ClientModel>> searchWithFilters(
      {required Map<String, dynamic> filters}) async {
    return [];

    /*  List<ClientModel>.from(
        (await _localConsumer.getDailyClientsWithFilters(
                isExporter: isExporter, isToDay: isToDay))
            .map((e) => ClientModel.fromJson(e)));*/
  }

  @override
  Future<double> getBalance() {
    return _localConsumer.getBalance();
  }

  @override
  Future<bool> deleteReceipt({required String id}) {
    return _localConsumer.deleteReceipt(id: id);
  }

  @override
  Future<bool> editReceipt({required Map<String, dynamic> receipt}) {
    return _localConsumer.editReceipt(receipt: receipt);
  }
}
