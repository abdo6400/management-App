import 'package:baraneq/config/database/local/local_consumer.dart';

import '../../../../core/models/client.dart';

abstract class ClientLocalDataSource {
  Future<bool> addClient({required Client clientModel});
}

class ClientLocalDataSourceImpl extends ClientLocalDataSource {
  final LocalConsumer _localConsumer;

  ClientLocalDataSourceImpl({required LocalConsumer localConsumer})
      : _localConsumer = localConsumer;
  @override
  Future<bool> addClient({required Client clientModel}) async {
    await Future.delayed(Duration(seconds: 2));
    return Future.value(true);
  }
}
