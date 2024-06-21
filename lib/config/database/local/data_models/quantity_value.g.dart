// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quantity_value.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class QuantityValueAdapter extends TypeAdapter<QuantityValue> {
  @override
  final int typeId = 1;

  @override
  QuantityValue read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };

    return QuantityValue(
      quantityValues: (fields[2] as Map).cast<String, String>(),
      date: fields[3] as DateTime,
      type: fields[5] as String,
      bont: fields[4] as String,
      id: fields[1] as String,
      clientId: fields[0] as String,
    );
  }

  @override
  void write(BinaryWriter writer, QuantityValue obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.clientId)
      ..writeByte(1)
      ..write(obj.id)
      ..writeByte(2)
      ..write(obj.quantityValues)
      ..writeByte(3)
      ..write(obj.date)
      ..writeByte(4)
      ..write(obj.bont)
      ..writeByte(5)
      ..write(obj.type);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is QuantityValueAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
