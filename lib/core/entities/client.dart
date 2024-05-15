abstract class Client {
  final String id;
  final String name;
  final String phoneNumber;
  final String clientType;
  final List<MilkReceipt> receipts;

  Client(
      {required this.id,
      required this.name,
      required this.phoneNumber,
      required this.clientType,
      required this.receipts});
}

abstract class MilkReceipt {
  final DateTime dateTime;
  final double quantity;
  final String type;
  final String bont;
  final String tankNumber;
  final String id;
  MilkReceipt(
      {required this.dateTime,
      required this.quantity,
      required this.type,
      required this.tankNumber,
      required this.bont,
      required this.id});
}
