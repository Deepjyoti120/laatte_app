// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_reports.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserReportAdapter extends TypeAdapter<UserReport> {
  @override
  final int typeId = 2;

  @override
  UserReport read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserReport(
      id: fields[0] as String?,
      isActive: fields[1] as bool?,
      role: fields[2] as String?,
      email: fields[3] as String?,
      username: fields[4] as String?,
      profilePicture: fields[5] as String?,
      coverPicture: fields[6] as String?,
      bio: fields[7] as String?,
      isVerified: fields[8] as bool?,
      name: fields[9] as String?,
      firstName: fields[10] as String?,
      middleName: fields[11] as String?,
      lastName: fields[12] as String?,
      countryCode: fields[13] as String?,
      phone: fields[14] as String?,
      dob: fields[15] as String?,
      gender: fields[16] as String?,
      doj: fields[17] as String?,
      address: fields[18] as String?,
      pincode: fields[19] as String?,
      city: fields[20] as String?,
      state: fields[21] as String?,
      country: fields[22] as String?,
      emergencyContact: fields[23] as String?,
      fcmToken: fields[24] as String?,
      createdAt: fields[25] as String?,
      updatedAt: fields[26] as String?,
      designation: fields[27] as Designation?,
    );
  }

  @override
  void write(BinaryWriter writer, UserReport obj) {
    writer
      ..writeByte(28)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.isActive)
      ..writeByte(2)
      ..write(obj.role)
      ..writeByte(3)
      ..write(obj.email)
      ..writeByte(4)
      ..write(obj.username)
      ..writeByte(5)
      ..write(obj.profilePicture)
      ..writeByte(6)
      ..write(obj.coverPicture)
      ..writeByte(7)
      ..write(obj.bio)
      ..writeByte(8)
      ..write(obj.isVerified)
      ..writeByte(9)
      ..write(obj.name)
      ..writeByte(10)
      ..write(obj.firstName)
      ..writeByte(11)
      ..write(obj.middleName)
      ..writeByte(12)
      ..write(obj.lastName)
      ..writeByte(13)
      ..write(obj.countryCode)
      ..writeByte(14)
      ..write(obj.phone)
      ..writeByte(15)
      ..write(obj.dob)
      ..writeByte(16)
      ..write(obj.gender)
      ..writeByte(17)
      ..write(obj.doj)
      ..writeByte(18)
      ..write(obj.address)
      ..writeByte(19)
      ..write(obj.pincode)
      ..writeByte(20)
      ..write(obj.city)
      ..writeByte(21)
      ..write(obj.state)
      ..writeByte(22)
      ..write(obj.country)
      ..writeByte(23)
      ..write(obj.emergencyContact)
      ..writeByte(24)
      ..write(obj.fcmToken)
      ..writeByte(25)
      ..write(obj.createdAt)
      ..writeByte(26)
      ..write(obj.updatedAt)
      ..writeByte(27)
      ..write(obj.designation);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserReportAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
