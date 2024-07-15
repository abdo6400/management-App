abstract class WeeklyClient {
    final int clientId;
    final String clientName;
    final String clientPhone;
    final List<Receipt> receipts;

    WeeklyClient({
        required this.clientId,
        required this.clientName,
        required this.clientPhone,
        required this.receipts,
    });

}

abstract class Receipt {
    final DateTime receiptDate;
    final double totalQuantityForAm;
    final double biggestBontForAm;
    final double totalQuantityForPm;
    final double biggestBontForPm;
    final double totalQuantityForDay;
  final double totalExportedQuantity;
    final double totalImportedQuantity;
    Receipt({
        required this.receiptDate,
        required this.totalQuantityForAm,
        required this.biggestBontForAm,
        required this.totalQuantityForPm,
        required this.biggestBontForPm,
        required this.totalQuantityForDay,
        required this.totalExportedQuantity,
        required this.totalImportedQuantity
    });

}