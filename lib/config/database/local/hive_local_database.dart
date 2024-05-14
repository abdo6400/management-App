import 'package:baraneq/core/utils/app_strings.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart' as hivef;
import 'package:supercharged/supercharged.dart';
import 'package:uuid/uuid.dart';
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
    Hive.registerAdapter(ClientDataAdapter());
    clientsBox = await Hive.openBox<ClientData>(clients);
    quantityValuesBox = await Hive.openBox<QuantityValue>(quantityValues);
  }

  Future<dynamic> getDailyClientsWithFilters(
      {required bool isExporter, required bool isToDay}) async {
    if (isToDay) {
      final List<String> ids = await GetDailyClientIds();
      return Future.value(clientsBox.values
          .filter((f) => isExporter
              ? f.clientType.compareTo(AppStrings.exporter.toUpperCase()) == 0
              : f.clientType.compareTo(AppStrings.importer.toUpperCase()) == 0)
          .filter((f) => ids.contains(f.id))
          .map((e) => {
                "id": e.id,
                "name": e.name,
                "phoneNumber": e.phone,
                "clientType": e.clientType,
                "receipts": quantityValuesBox.values
                    .filter((f) => f.clientId.compareTo(e.id) == 0)
                    .map((e) => {
                          "dateTime": e.date,
                          "quantity": e.quantityValue,
                          "type": e.type,
                          "bont": e.bont,
                          "id": e.id
                        }),
              })
          .toList());
    }
    return Future.value(await clientsBox.values
        .filter((f) => isExporter
            ? f.clientType.compareTo(AppStrings.exporter.toUpperCase()) == 0
            : f.clientType.compareTo(AppStrings.importer.toUpperCase()) == 0)
        .map((e) => {
              "id": e.id,
              "name": e.name,
              "phoneNumber": e.phone,
              "clientType": e.clientType,
              "receipts": quantityValuesBox.values
                  .filter((f) => f.clientId.compareTo(e.id) == 0)
                  .map((e) => {
                        "dateTime": e.date,
                        "quantity": e.quantityValue,
                        "type": e.type,
                        "bont": e.bont,
                        "id": e.id
                      }),
            })
        .toList());
  }

  Future<List<String>> GetDailyClientIds() async {
    return quantityValuesBox.values
        .filter((f) => (DateTime(f.date.year, f.date.month, f.date.day)
                .compareTo(DateTime(DateTime.now().year, DateTime.now().month,
                    DateTime.now().day)) ==
            0))
        .map((e) => e.clientId)
        .toList();
  }

  Future<double> getBalance() {
    return Future.value(quantityValuesBox
        .toMap()
        .values
        .filter((f) => f.type.compareTo(AppStrings.importer.toUpperCase()) == 0)
        .toList()
        .sumByDouble((d) => d.quantityValue));
  }

  Future<bool> addClient({required Map<String, dynamic> client}) async {
    try {
      await clientsBox.add(ClientData(
          id: Uuid().v1(),
          phone: client["phone"],
          name: client["name"],
          clientType: client["clientType"]));
      return Future.value(true);
    } catch (e) {
      return Future.value(false);
    }
  }

  Future<bool> addReceipt({required Map<String, dynamic> receipt}) async {
    try {
      await quantityValuesBox.add(QuantityValue(
        quantityValue: receipt["quantity"],
        date: DateTime.now(),
        type: receipt["type"],
        bont: receipt["bant"],
        clientId: receipt["clientId"],
        id: Uuid().v1(),
      ));
      return Future.value(true);
    } catch (e) {
      return Future.value(false);
    }
  }

  Future<bool> editReceipt({required Map<String, dynamic> receipt}) async {
    try {
      String? key;
      quantityValuesBox.toMap().forEach((k, e) {
        if (e.id.compareTo(receipt["id"]) == 0) {
          key = k;
        }
      });

      if (key != null) {
        await quantityValuesBox.put(
            key,
            QuantityValue(
                quantityValue: receipt["quantity"],
                date: DateTime.now(),
                type: receipt["type"],
                bont: receipt["bant"],
                clientId: quantityValuesBox.get(key)!.clientId,
                id: receipt["id"]));
        return Future.value(true);
      } else {
        return Future.value(false);
      }
    } catch (e) {
      return Future.value(false);
    }
  }

  Future<bool> deleteReceipt({required String id}) async {
    try {
      String? key;

      quantityValuesBox.toMap().forEach((k, e) {
        if (e.id.compareTo(id) == 0) {
          key = k;
        }
      });
      if (key != null) {
        await quantityValuesBox.delete(key);
      } else {
        return Future.value(false);
      }
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
