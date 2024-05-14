import 'package:hive/hive.dart';
part 'quantity_value.g.dart';

@HiveType(typeId: 1)
class QuantityValue {
  @HiveField(0)
  String clientId;

  @HiveField(1)
  double quantityValue;

  @HiveField(2)
  DateTime date;

  @HiveField(3)
  String type;

  QuantityValue(
      {required this.quantityValue,
      required this.date,
      required this.type,
      required this.clientId});
}
