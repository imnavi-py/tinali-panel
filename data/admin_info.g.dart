// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin_info.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AdminInfoAdapter extends TypeAdapter<AdminInfo> {
  @override
  final int typeId = 0;

  @override
  AdminInfo read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AdminInfo(
      id: fields[1] as int,
      name: fields[2] as String,
      lastName: fields[3] as String,
      unit: fields[4] as String,
      isadmin: fields[5] as bool,
      username: fields[6] as String,
      password: fields[7] as String,
      number: fields[8] as String,
    );
  }

  @override
  void write(BinaryWriter writer, AdminInfo obj) {
    writer
      ..writeByte(8)
      ..writeByte(1)
      ..write(obj.id)
      ..writeByte(2)
      ..write(obj.name)
      ..writeByte(3)
      ..write(obj.lastName)
      ..writeByte(4)
      ..write(obj.unit)
      ..writeByte(5)
      ..write(obj.isadmin)
      ..writeByte(6)
      ..write(obj.username)
      ..writeByte(7)
      ..write(obj.password)
      ..writeByte(8)
      ..write(obj.number);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AdminInfoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
