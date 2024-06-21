import 'package:hive/hive.dart';
part 'quantity_value.g.dart';

@HiveType(typeId: 1)
class QuantityValue {
  @HiveField(0)
  String clientId;

  @HiveField(1)
  String id;

  @HiveField(2)
  Map<String, String> quantityValues;

  @HiveField(3)
  DateTime date;

  @HiveField(4)
  String bont;

  @HiveField(5)
  String type;

  QuantityValue({
    required this.quantityValues,
    required this.date,
    required this.type,
    required this.bont,
    required this.id,
    required this.clientId,
  });
}
