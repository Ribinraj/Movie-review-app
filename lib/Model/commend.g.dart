// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'commend.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CommendAdapter extends TypeAdapter<Commend> {
  @override
  final int typeId = 3;

  @override
  Commend read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Commend(
      userid: fields[0] as int,
      moviekey: fields[1] as String,
      commend: fields[2] as String,
      date: fields[3] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, Commend obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.userid)
      ..writeByte(1)
      ..write(obj.moviekey)
      ..writeByte(2)
      ..write(obj.commend)
      ..writeByte(3)
      ..write(obj.date);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CommendAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
