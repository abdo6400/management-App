import '../../domain/entities/client_information.dart';

class ClientInformationModel extends ClientInformation {
  ClientInformationModel(
      {required super.id,
      required super.name,
      required super.phoneNumber,
      required super.receiptCount,
      required super.importerReceiptsTotalQuantity,
      required super.exporterReceiptsTotalQuantity,
      required super.totalClientsCount});

  factory ClientInformationModel.fromJson(Map<String, dynamic> json) =>
      ClientInformationModel(
          id: json["id"],
          name: json["name"],
          phoneNumber: json["phone"],
          totalClientsCount: json["totalClientsCount"],
          receiptCount: json["receiptsCount"],
          importerReceiptsTotalQuantity:
              double.parse(json["importerReceiptsTotalQuantity"].toString()),
          exporterReceiptsTotalQuantity:
              double.parse(json["exporterReceiptsTotalQuantity"].toString()));
}
