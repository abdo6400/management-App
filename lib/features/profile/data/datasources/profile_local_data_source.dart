import '../../../../config/database/local/sql_local_database.dart';

abstract class ProfileLocalDataSource {
  
}

class ProfileLocalDataSourceImpl extends ProfileLocalDataSource {
  final SqlLocalDatabase _localConsumer;

  ProfileLocalDataSourceImpl({
    required SqlLocalDatabase localConsumer,
  }) : _localConsumer = localConsumer;

  
}
