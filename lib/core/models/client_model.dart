import 'dart:convert';

import '../entities/client.dart';

class ClientModel extends Client {
  ClientModel(
      {required super.id,
      required super.name,
      required super.phoneNumber,
      required super.receipts});
  factory ClientModel.fromJson(Map<String, dynamic> json) => ClientModel(
        id: json["clientId"],
        name: json["clientName"],
        phoneNumber: json["clientPhone"],
        receipts: List<MilkReceiptModel>.from(jsonDecode(json["receipts"])
            .map((x) => MilkReceiptModel.fromJson(x))),
      );
}

class MilkReceiptModel extends MilkReceipt {
  MilkReceiptModel(
      {required super.dateTime,
      required super.totalQuantity,
      required super.type,
      required super.bont,
      required super.time,
      required super.id});
  factory MilkReceiptModel.fromJson(Map<String, dynamic> json) =>
      MilkReceiptModel(
        id: json["receiptId"],
        dateTime: DateTime.parse(json["receiptDate"]),
        type: json["receiptType"],
        time: json["receiptTime"],
        bont: double.parse(json["bont"].toString()),
        totalQuantity: double.parse(json["totalQuantity"].toString()),
      );
}
