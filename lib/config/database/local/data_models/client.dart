import 'package:hive/hive.dart';

part 'client.g.dart';
@HiveType(typeId: 0)
class ClientData {
  @HiveField(0)
  String id;
  @HiveField(1)
  String name;

  @HiveField(2)
  String phone;

  @HiveField(3)
  String clientType;

  ClientData({required this.id, required this.phone, required this.name, required this.clientType});
}

