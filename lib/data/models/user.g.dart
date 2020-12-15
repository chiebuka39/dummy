// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserAdapter extends TypeAdapter<User> {
  @override
  User read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return User(
      fullname: fields[0] as String,
      expires: fields[4] as DateTime,
      isRegistrationVerified: fields[2] as String,
      profileCode: fields[3] as String,
      token: fields[1] as String,
      isPinSetUp: fields[5] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, User obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.fullname)
      ..writeByte(1)
      ..write(obj.token)
      ..writeByte(2)
      ..write(obj.isRegistrationVerified)
      ..writeByte(3)
      ..write(obj.profileCode)
      ..writeByte(4)
      ..write(obj.expires)
      ..writeByte(5)
      ..write(obj.isPinSetUp);
  }

  @override
  int get typeId => 1;
}
