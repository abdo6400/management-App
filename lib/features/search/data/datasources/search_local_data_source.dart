import '../../../../config/database/local/hive_local_database.dart';
import '../../../../core/models/client_model.dart';

abstract class SearchLocalDataSource {
  Future<List<ClientModel>> searchWithFilters(
      {required Map<String, dynamic> filters});
}

class SearchLocalDataSourceImpl extends SearchLocalDataSource {
  final HiveLocalDatabase _localConsumer;

  SearchLocalDataSourceImpl({
    required HiveLocalDatabase localConsumer,
  }) : _localConsumer = localConsumer;

  @override
  Future<List<ClientModel>> searchWithFilters(
      {required Map<String, dynamic> filters}) async {
    return List<ClientModel>.from(
        (await _localConsumer.search(filters: filters))
            .map((e) => ClientModel.fromJson(e)));
  }
}
