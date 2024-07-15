import '../../domain/entities/tank.dart';

class TankModel extends Tank {
  TankModel(
      {required super.id,
      required super.capacity,
      required super.currentQuantity,required super.name});

  factory TankModel.fromJson(Map<String, dynamic> json) {
    return TankModel(
      id: json['tankId'],
      capacity: double.parse(json['tankCapacity'].toString()),
      currentQuantity: double.parse(json['totalQuantity'].toString()),
      name: json["tankName"]
    );
  }
}
