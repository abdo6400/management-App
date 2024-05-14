import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart' as hivef;
import '../../../core/models/client.dart';
import '../../../core/models/quantity_value.dart';

class HiveLocalDatabase {
  static const clients = "clients";
  static const quantityValues = "quantityValues";
  static late Box<Client> clientsBox;
  static late Box<QuantityValue> quantityValuesBox;
  static Future<void> initializeHiveLocalDatabase() async {
    await hivef.Hive.initFlutter();
    Hive.registerAdapter(QuantityValueAdapter());
    Hive.registerAdapter(ClientAdapter());
    clientsBox = await Hive.openBox<Client>(clients);
    quantityValuesBox = await Hive.openBox<QuantityValue>(quantityValues);
  }

  void getClient() {
    print(clientsBox.values);
  }

  ValueListenable<Box<Client>> getClients() {
    return clientsBox.listenable();
  }

  ValueListenable<Box<QuantityValue>> getBalance() {
    return quantityValuesBox.listenable();
  }

  Future<bool> addClient({required Client client}) async {
    try {
      await clientsBox.add(client);
      return Future.value(true);
    } catch (e) {
      return Future.value(false);
    }
  }

  Future<bool> deleteALl() async {
    try {
      await clientsBox.clear();
      return Future.value(true);
    } catch (e) {
      return Future.value(false);
    }
  }
}
