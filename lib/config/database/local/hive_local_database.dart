import 'dart:convert';

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
  static const balanceValue = "balanceValue";
  static late Box<ClientData> clientsBox;
  static late Box<QuantityValue> quantityValuesBox;
  static late Box<double> balanceBox;
  static Future<void> initializeHiveLocalDatabase() async {
    await hivef.Hive.initFlutter();
    Hive.registerAdapter(QuantityValueAdapter());
    Hive.registerAdapter(ClientDataAdapter());
    clientsBox = await Hive.openBox<ClientData>(clients);
    quantityValuesBox = await Hive.openBox<QuantityValue>(quantityValues);
    balanceBox = await Hive.openBox<double>(balanceValue);
  }

  Future<Map<String, double>> getTanks() async {
    double tank1Sum = 0;
    double tank2Sum = 0;
    double tank3Sum = 0;
    quantityValuesBox.values.forEach((e) {
      if (clientsBox.values
              .firstWhere((f) => f.id.compareTo(e.clientId) == 0)
              .clientType ==
          AppStrings.importer.toUpperCase()) {
        e.quantityValues.entries.forEach((e) {
          if (e.key == "1") {
            tank1Sum = tank1Sum + double.parse(e.value);
          } else if (e.key == "2") {
            tank2Sum = tank2Sum + double.parse(e.value);
          } else if (e.key == "3") {
            tank3Sum = tank3Sum + double.parse(e.value);
          }
        });
      } else {
        e.quantityValues.entries.forEach((e) {
          if (e.key == "1") {
            tank1Sum = tank1Sum - double.parse(e.value);
          } else if (e.key == "2") {
            tank2Sum = tank2Sum - double.parse(e.value);
          } else if (e.key == "3") {
            tank3Sum = tank3Sum - double.parse(e.value);
          }
        });
      }
    });

    final Map<String, double> summedQuantitiesByTankNumber = {
      "1": tank1Sum,
      "2": tank2Sum,
      "3": tank3Sum
    };

    return summedQuantitiesByTankNumber;
  }

  void balance(double value, String clientId, {bool isDelete = false}) {
    if (clientsBox.values
            .firstWhere((f) => f.id.compareTo(clientId) == 0)
            .clientType
            .compareTo(AppStrings.importer.toUpperCase()) ==
        0) {
      if (isDelete) {
        balanceBox.put(balanceBox.keys.first, balanceBox.values.first - value);
      } else {
        if (balanceBox.isEmpty) {
          balanceBox.add(value);
        } else {
          balanceBox.put(
              balanceBox.keys.first, balanceBox.values.first + value);
        }
      }
    } else {
      if (isDelete) {
        balanceBox.put(balanceBox.keys.first, balanceBox.values.first + value);
      } else {
        if (balanceBox.isEmpty) {
          balanceBox.add(-value);
        } else {
          balanceBox.put(
              balanceBox.keys.first, balanceBox.values.first - value);
        }
      }
    }
  }

  Future<dynamic> search({required Map<String, dynamic> filters}) async {
    DateTime? fromDate = filters["fromDate"];
    DateTime? toDate = filters["toDate"];
    String? valueFilter = filters["value"];

    List<String> clients = [];
    if (fromDate != null && toDate != null) {
      clients = await getClientIdsWithinDateDuration(fromDate, toDate);
    }
    return Future.value(clientsBox.values
        .filter((f) => valueFilter == null || f.name.startsWith(valueFilter))
        .filter((f) =>
            (fromDate == null && toDate == null) || (clients).contains(f.id))
        .map((e) => {
              "id": e.id,
              "name": e.name,
              "phoneNumber": e.phone,
              "clientType": e.clientType,
              "receipts": quantityValuesBox.values
                  .filter((f) =>
                      f.clientId.compareTo(e.id) == 0 &&
                      (fromDate == null ||
                          toDate == null ||
                          f.date.isBetween(
                              fromDate, toDate.add(Duration(days: 1)))))
                  .map((e) => {
                        "dateTime": e.date,
                        "tanks": e.quantityValues,
                        "type": e.type,
                        "bont": e.bont,
                        "id": e.id
                      })
                  .toList(),
            })
        .toList());
  }

  Future<dynamic> getDailyClientsWithFilters(
      {required bool isExporter, required bool isToDay}) async {
    if (isToDay) {
      final List<String> ids = await getDailyClientIds();
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
                    .filter((f) =>
                        (DateTime(f.date.year, f.date.month, f.date.day)
                                .compareTo(DateTime(
                                    DateTime.now().year,
                                    DateTime.now().month,
                                    DateTime.now().day)) ==
                            0))
                    .map((e) => {
                          "dateTime": e.date,
                          "tanks": e.quantityValues,
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
                        "tanks": e.quantityValues,
                        "type": e.type,
                        "bont": e.bont,
                        "id": e.id
                      }),
            })
        .toList());
  }

  Future<List<String>> getClientIdsWithinDateDuration(
      DateTime fromDate, DateTime toDate) async {
    DateTime fromDateNormalized =
        DateTime(fromDate.year, fromDate.month, fromDate.day);
    DateTime toDateNormalized =
        DateTime(toDate.year, toDate.month, toDate.day).add(Duration(days: 1));

    return Future.value(quantityValuesBox.values
        .filter((f) {
          return f.date.isBetween(fromDateNormalized, toDateNormalized);
        })
        .map((e) => e.clientId)
        .toList());
  }

  Future<List<String>> getDailyClientIds() async {
    return quantityValuesBox.values
        .filter((f) => (DateTime(f.date.year, f.date.month, f.date.day)
                .compareTo(DateTime(DateTime.now().year, DateTime.now().month,
                    DateTime.now().day)) ==
            0))
        .map((e) => e.clientId)
        .toList();
  }

  Future<List<QuantityValue>> getDailyQuantityValue(String clientId) async {
    return quantityValuesBox.values
        .filter((f) => (DateTime(f.date.year, f.date.month, f.date.day)
                .compareTo(DateTime(DateTime.now().year, DateTime.now().month,
                    DateTime.now().day)) ==
            0))
        .filter((f) => f.clientId.compareTo(clientId) == 0)
        .toList();
  }

  Future<double> getBalance() {
    try {
      return Future.value(balanceBox.values.first);
    } catch (e) {
      return Future.value(0);
    }
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
        date: DateTime.now(),
        type: receipt["type"],
        bont: receipt["bont"].toString(),
        quantityValues: receipt["tanks"],
        clientId: receipt["clientId"],
        id: Uuid().v1(),
      ));

      List<String> values = receipt["tanks"].values.toList();

      balance(values.sumByDouble((s) => double.parse(s)), receipt["clientId"]);

      return Future.value(true);
    } catch (e) {
      print(e);
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
                quantityValues: receipt["tanks"],
                date: DateTime.now(),
                type: receipt["type"],
                bont: receipt["bont"],
                clientId: quantityValuesBox.get(key)!.clientId,
                id: receipt["id"]));

        List<String> values = receipt["tanks"].values.toList();

        balance(values.sumByDouble((s) => double.parse(s)),
            quantityValuesBox.get(key)!.clientId);

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
      print("***************");
      final List<QuantityValue> ids = await getDailyQuantityValue(id);

      ids.forEach((e) async {
        int? key;
        quantityValuesBox.toMap().forEach((k, e) {
          if (e.id.compareTo(e.id) == 0) {
            key = k;
          }
        });

        balance(
            quantityValuesBox
                .get(key)!
                .quantityValues
                .values
                .sumByDouble((s) => double.parse(s)),
            quantityValuesBox.get(key)!.clientId,
            isDelete: true);
        await quantityValuesBox.delete(key);
      });

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
