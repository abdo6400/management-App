import 'dart:convert';

import '../../domain/entities/weekly_client.dart';

class WeeklyClientModel extends WeeklyClient {
  WeeklyClientModel({
    required super.clientId,
    required super.clientName,
    required super.clientPhone,
    required super.receipts,
  });

  factory WeeklyClientModel.fromJson(Map<String, dynamic> json) =>
      WeeklyClientModel(
        clientId: json["clientId"],
        clientName: json["clientName"],
        clientPhone: json["clientPhone"],
        receipts: List<Receipt>.from(
            jsonDecode(json["receipts"]).map((x) => ReceiptModel.fromJson(x))),
      );
}

class ReceiptModel extends Receipt {
  ReceiptModel({
    required super.receiptDate,
    required super.totalQuantityForAm,
    required super.biggestBontForAm,
    required super.totalQuantityForPm,
    required super.biggestBontForPm,
    required super.totalQuantityForDay,
    required super.totalExportedQuantity,
    required super.totalImportedQuantity,
  });

  factory ReceiptModel.fromJson(Map<String, dynamic> json) => ReceiptModel(
        receiptDate: DateTime.parse(json["receiptDate"]),
        totalQuantityForAm: double.parse(json["totalQuantityForAM"].toString()),
        biggestBontForAm: double.parse(json["biggestBontForAM"].toString()),
        totalQuantityForPm: double.parse(json["totalQuantityForPM"].toString()),
        biggestBontForPm: double.parse(json["biggestBontForPM"].toString()),
        totalQuantityForDay:
            double.parse(json["totalQuantityForDay"].toString()),
        totalExportedQuantity:
            double.parse(json["totalExportedQuantity"].toString()),
        totalImportedQuantity:
            double.parse(json["totalImportedQuantity"].toString()),
      );

  Map<String, dynamic> toJson() => {
        "receiptDate":
            "${receiptDate.year.toString().padLeft(4, '0')}-${receiptDate.month.toString().padLeft(2, '0')}-${receiptDate.day.toString().padLeft(2, '0')}",
        "totalQuantityForAM": totalQuantityForAm,
        "biggestBontForAM": biggestBontForAm,
        "totalQuantityForPM": totalQuantityForPm,
        "biggestBontForPM": biggestBontForPm,
        "totalQuantityForDay": totalQuantityForDay,
      };
}
