import '../../../../config/database/local/hive_local_database.dart';

abstract class ProfileLocalDataSource {
  Future<Map<String, double>> getTanks();
}

class ProfileLocalDataSourceImpl extends ProfileLocalDataSource {
  final HiveLocalDatabase _localConsumer;

  ProfileLocalDataSourceImpl({
    required HiveLocalDatabase localConsumer,
  }) : _localConsumer = localConsumer;

  @override
  Future<Map<String, double>> getTanks() {
    return _localConsumer.getTanks();
  }
}
