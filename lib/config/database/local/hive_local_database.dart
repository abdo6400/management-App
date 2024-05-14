import 'package:baraneq/core/utils/app_strings.dart';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart' as hivef;
import 'package:supercharged/supercharged.dart';
import 'data_models/client.dart';
import 'data_models/quantity_value.dart';

class HiveLocalDatabase {
  static const clients = "clients";
  static const quantityValues = "quantityValues";
  static late Box<ClientData> clientsBox;
  static late Box<QuantityValue> quantityValuesBox;
  static Future<void> initializeHiveLocalDatabase() async {
    await hivef.Hive.initFlutter();
    Hive.registerAdapter(QuantityValueAdapter());
    Hive.registerAdapter(ClientAdapter());
    clientsBox = await Hive.openBox<ClientData>(clients);
    quantityValuesBox = await Hive.openBox<QuantityValue>(quantityValues);
  }

  void getClient() {
    print(clientsBox.values);
  }

  ValueListenable<Box<ClientData>> getClients() {
    return clientsBox.listenable();
  }

  Future<dynamic> getDailyClientsWithFilters(
      {required bool isExporter}) async {
    return [{}];
    //clientsBox.listenable().value.values.toList().asMap<String,dynamic>();
  }

  Future<double> getBalance() {
    return Future.value(quantityValuesBox
        .listenable()
        .value
        .values
        .filter((f) => f.type.compareTo(AppStrings.importer.toUpperCase()) == 0)
        .toList()
        .sumByDouble((d) => d.quantityValue));
  }

  Future<bool> addClient({required Map<String, dynamic> client}) async {
    try {
      await clientsBox.add(ClientData(
          id: client["id"],
          phone: client["phone"],
          name: client["name"],
          clientType: client["clientType"]));
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
