// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wishlist.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class WishlistAdapter extends TypeAdapter<Wishlist> {
  @override
  final int typeId = 2;

  @override
  Wishlist read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Wishlist(
      userid: fields[0] as int,
      movieid: fields[1] as int,
    );
  }

  @override
  void write(BinaryWriter writer, Wishlist obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.userid)
      ..writeByte(1)
      ..write(obj.movieid);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WishlistAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
