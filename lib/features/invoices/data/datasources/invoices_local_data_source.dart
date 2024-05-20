import '../../../../config/database/local/hive_local_database.dart';
import '../../../../core/models/client_model.dart';

abstract class InvoicesLocalDataSource {
  Future<List<ClientModel>> accoutStatementWithFilters(
      {required Map<String, dynamic> filters});
}

class InvoicesLocalDataSourceImpl extends InvoicesLocalDataSource {
  final HiveLocalDatabase _localConsumer;

  InvoicesLocalDataSourceImpl({
    required HiveLocalDatabase localConsumer,
  }) : _localConsumer = localConsumer;

  @override
  Future<List<ClientModel>> accoutStatementWithFilters(
      {required Map<String, dynamic> filters}) async {
    return List<ClientModel>.from(
        (await _localConsumer.search(filters: filters))
            .map((e) => ClientModel.fromJson(e)));
  }
}
