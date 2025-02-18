// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'designation.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DesignationAdapter extends TypeAdapter<Designation> {
  @override
  final int typeId = 4;

  @override
  Designation read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Designation(
      id: fields[0] as String?,
      title: fields[1] as String?,
      description: fields[2] as String?,
      createdAt: fields[3] as String?,
      updatedAt: fields[4] as String?,
      department: fields[5] as Department?,
    );
  }

  @override
  void write(BinaryWriter writer, Designation obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.createdAt)
      ..writeByte(4)
      ..write(obj.updatedAt)
      ..writeByte(5)
      ..write(obj.department);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DesignationAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
