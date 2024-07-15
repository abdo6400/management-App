abstract class ClientInformation {
  final int id;
  final String name;
  final String phoneNumber;
  final int receiptCount;
  final double exporterReceiptsTotalQuantity;
  final double importerReceiptsTotalQuantity;
  final int totalClientsCount;
  ClientInformation(
      {required this.id,
      required this.name,
      required this.phoneNumber,
      required this.receiptCount,
      required this.exporterReceiptsTotalQuantity,
      required this.importerReceiptsTotalQuantity,required this.totalClientsCount});
}
