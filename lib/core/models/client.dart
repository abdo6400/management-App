import 'package:hive/hive.dart';

@HiveType(typeId: 0)
class Client {
  @HiveField(0)
  String name;

  @HiveField(1)
  String phone;

  @HiveField(2)
  String ClientType;

  Client({required this.phone, required this.name, required this.ClientType});
}

@HiveType(typeId: 1)
class Quantity {
  @HiveField(0)
  String clientId;

  @HiveField(1)
  double quantity;

  @HiveField(2)
  DateTime date;

  @HiveField(3)
  String type;

  Quantity(
      {required this.quantity,
      required this.date,
      required this.type,
      required this.clientId});
}
