// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserAdapter extends TypeAdapter<UserItem> {
  @override
  UserItem read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserItem(
      avtar: fields[2] as String,
      id: fields[0] as int,
      login: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, UserItem obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.login)
      ..writeByte(2)
      ..write(obj.avtar);
  }

  @override
  int get typeId => 0;
}