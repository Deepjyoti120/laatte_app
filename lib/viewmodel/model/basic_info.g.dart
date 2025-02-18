// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'basic_info.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BasicInfoAdapter extends TypeAdapter<BasicInfo> {
  @override
  final int typeId = 0;

  @override
  BasicInfo read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BasicInfo(
      defaultRoles: (fields[0] as List?)?.cast<String>(),
      permissions: fields[1] as Permissions?,
    )
      ..department = (fields[2] as List?)?.cast<Department>()
      ..countries = (fields[3] as List?)?.cast<Country>()
      ..defaultGenders = (fields[4] as List?)?.cast<String>();
  }

  @override
  void write(BinaryWriter writer, BasicInfo obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.defaultRoles)
      ..writeByte(1)
      ..write(obj.permissions)
      ..writeByte(2)
      ..write(obj.department)
      ..writeByte(3)
      ..write(obj.countries)
      ..writeByte(4)
      ..write(obj.defaultGenders);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BasicInfoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class PermissionsAdapter extends TypeAdapter<Permissions> {
  @override
  final int typeId = 1;

  @override
  Permissions read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Permissions(
      modules: (fields[0] as List?)?.cast<String>(),
      features: (fields[1] as List?)?.cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, Permissions obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.modules)
      ..writeByte(1)
      ..write(obj.features);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PermissionsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
