import '../../../../config/database/local/sql_local_database.dart';
import '../models/tank_model.dart';

abstract class TanksLocalDataSource {
  Future<List<TankModel>> getTanks({required Map<String, dynamic> options});
  Future<bool> addTanks({required Map<String, dynamic> tank});
  Future<bool> deleteTank({required int id});
  Future<bool> updateTank({required Map<String, dynamic> tank});
}

class TanksLocalDataSourceImpl implements TanksLocalDataSource {
  final SqlLocalDatabase _localConsumer;

  TanksLocalDataSourceImpl({required SqlLocalDatabase localConsumer})
      : _localConsumer = localConsumer;

  @override
  Future<List<TankModel>> getTanks(
      {required Map<String, dynamic> options}) async {
    return List<TankModel>.from(
        (await _localConsumer.getTanksWithQuantities(options: options))
            .map((e) => TankModel.fromJson(e))
            .toList());
  }

  @override
  Future<bool> addTanks({required Map<String, dynamic> tank}) async {
    return _localConsumer.insertTank(tank) != -1;
  }

  @override
  Future<bool> deleteTank({required int id}) async {
    return _localConsumer.deleteTank(id) != -1;
  }

  @override
  Future<bool> updateTank({required Map<String, dynamic> tank}) async {
    return _localConsumer.updateTank(tank) != -1;
  }
}
