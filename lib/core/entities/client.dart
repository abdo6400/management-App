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
  final String type;
  final String bont;
  final Map<String,String> tanks;
  final String id;
  MilkReceipt(
      {required this.dateTime,
      required this.tanks,
      required this.type,
      required this.bont,
      required this.id});
}
