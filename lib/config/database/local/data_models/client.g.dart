// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'client.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ClientDataAdapter extends TypeAdapter<ClientData> {
  @override
  final int typeId = 0;

  @override
  ClientData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ClientData(
      id: fields[0] as String,
      phone: fields[2] as String,
      name: fields[1] as String,
      clientType: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, ClientData obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.phone)
      ..writeByte(3)
      ..write(obj.clientType);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ClientDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
