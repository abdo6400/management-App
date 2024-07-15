import '../../../../config/database/local/sql_local_database.dart';
import '../../../../core/models/client_model.dart';

abstract class InvoicesLocalDataSource {
  Future<List<ClientModel>> accoutStatementWithFilters(
      {required Map<String, dynamic> filters});
}

class InvoicesLocalDataSourceImpl extends InvoicesLocalDataSource {
  final SqlLocalDatabase _localConsumer;

  InvoicesLocalDataSourceImpl({
    required SqlLocalDatabase localConsumer,
  }) : _localConsumer = localConsumer;

  @override
  Future<List<ClientModel>> accoutStatementWithFilters(
      {required Map<String, dynamic> filters}) async {
    return List<ClientModel>.from(
        (await _localConsumer.searchWithFilters(filters: filters))
            .map((e) => ClientModel.fromJson(e)));
  }
}
