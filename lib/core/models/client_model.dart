import '../entities/client.dart';

class ClientModel extends Client {
  ClientModel(
      {required super.id,
      required super.name,
      required super.phoneNumber,
      required super.clientType,
      required super.receipts});

  factory ClientModel.fromJson(Map<String, dynamic> json) => ClientModel(
      id: json["id"],
      name: json["name"],
      phoneNumber: json["phoneNumber"],
      clientType: json["clientType"],
      receipts: List<MilkReceiptModel>.from(
          json["receipts"].map((e) => MilkReceiptModel.fromJson(e))));
}

class MilkReceiptModel extends MilkReceipt {
  MilkReceiptModel(
      {required super.dateTime,
      required super.quantity,
      required super.type,
      required super.bant,
      required super.id});

  factory MilkReceiptModel.fromJson(Map<String, dynamic> json) =>
      MilkReceiptModel(
          dateTime: json["dateTime"],
          quantity: json["quantity"],
          type: json["type"],
          bant: json["bont"],
          id: json["id"]);
}
