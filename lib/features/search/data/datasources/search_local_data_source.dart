import '../../../../config/database/local/sql_local_database.dart';
import '../../../../core/models/search_client_model.dart';
import '../models/weekly_client_model.dart';

abstract class SearchLocalDataSource {
  Future<List<WeeklyClientModel>> searchWithFilters(
      {required Map<String, dynamic> filters});
  Future<List<SearchClientModel>> searchWithNameAboutClient(
      {required Map<String, dynamic> filters});
}

class SearchLocalDataSourceImpl extends SearchLocalDataSource {
  final SqlLocalDatabase _localConsumer;

  SearchLocalDataSourceImpl({
    required SqlLocalDatabase localConsumer,
  }) : _localConsumer = localConsumer;

  @override
  Future<List<WeeklyClientModel>> searchWithFilters(
      {required Map<String, dynamic> filters}) async {
    return List<WeeklyClientModel>.from(
        (await _localConsumer.searchWithFilters(filters: filters))
            .map((e) => WeeklyClientModel.fromJson(e)));
  }

  @override
  Future<List<SearchClientModel>> searchWithNameAboutClient(
      {required Map<String, dynamic> filters}) async {
    return List<SearchClientModel>.from(
        ((await _localConsumer.searchWithNameAboutClient(filters: filters))
            .map((e) => SearchClientModel.fromJson(e))));
  }
}
