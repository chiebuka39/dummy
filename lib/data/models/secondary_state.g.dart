// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'secondary_state.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SecondaryStateAdapter extends TypeAdapter<SecondaryState> {
  @override
  SecondaryState read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SecondaryState(
      fields[0] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, SecondaryState obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.isLoggedIn);
  }

  @override
  int get typeId => 0;
}
