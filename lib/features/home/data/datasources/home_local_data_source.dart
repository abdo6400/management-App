import '../../../../config/database/local/hive_local_database.dart';
import '../../../../core/models/client_model.dart';

abstract class HomeLocalDataSource {
  Future<List<ClientModel>> getClientsWithFilters(
      {required bool isExporter, required bool isToDay});

  Future<double> getBalance();

  Future<bool> addReceipt({required Map<String, dynamic> receipt});
  Future<bool> editReceipt({required Map<String, dynamic> receipt});
  Future<bool> deleteReceipt({required String id});
}

class HomeLocalDataSourceImpl extends HomeLocalDataSource {
  final HiveLocalDatabase _localConsumer;

  HomeLocalDataSourceImpl({
    required HiveLocalDatabase localConsumer,
  }) : _localConsumer = localConsumer;

  @override
  Future<List<ClientModel>> getClientsWithFilters(
      {required bool isExporter, required bool isToDay}) async {
    return List<ClientModel>.from(
        (await _localConsumer.getDailyClientsWithFilters(
                isExporter: isExporter, isToDay: isToDay))
            .map((e) => ClientModel.fromJson(e)));
  }

  @override
  Future<double> getBalance() {
    return _localConsumer.getBalance();
  }

  @override
  Future<bool> addReceipt({required Map<String, dynamic> receipt}) {
    return _localConsumer.addReceipt(receipt: receipt);
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
