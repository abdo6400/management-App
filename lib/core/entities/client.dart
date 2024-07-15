abstract class Client {
  final int id;
  final String name;
  final String phoneNumber;
  final List<MilkReceipt> receipts;

  Client(
      {required this.id,
      required this.name,
      required this.phoneNumber,
      required this.receipts});
}

abstract class MilkReceipt {
  final DateTime dateTime;
  final String type;
  final String time;
  final double bont;
  final double totalQuantity;
  final int id;
  MilkReceipt(
      {required this.dateTime,
      required this.totalQuantity,
      required this.type,
      required this.bont,
      required this.id,
      required this.time});
}
