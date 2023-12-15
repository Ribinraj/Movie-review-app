// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'addMovie.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AddmovieAdapter extends TypeAdapter<Addmovie> {
  @override
  final int typeId = 0;

  @override
  Addmovie read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Addmovie(
      imageUrl: fields[0] as String,
      title: fields[1] as String,
      director: fields[2] as String,
      language: fields[3] as String,
      year: fields[4] as DateTime,
      genre: fields[5] as String,
      rating: fields[6] as double,
      runtime: fields[7] as double,
      description: fields[8] as String,
      cast: fields[9] as String,
      music: fields[10] as String,
      videoId: fields[11] as String,
      key: fields[12] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Addmovie obj) {
    writer
      ..writeByte(13)
      ..writeByte(0)
      ..write(obj.imageUrl)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.director)
      ..writeByte(3)
      ..write(obj.language)
      ..writeByte(4)
      ..write(obj.year)
      ..writeByte(5)
      ..write(obj.genre)
      ..writeByte(6)
      ..write(obj.rating)
      ..writeByte(7)
      ..write(obj.runtime)
      ..writeByte(8)
      ..write(obj.description)
      ..writeByte(9)
      ..write(obj.cast)
      ..writeByte(10)
      ..write(obj.music)
      ..writeByte(11)
      ..write(obj.videoId)
      ..writeByte(12)
      ..write(obj.key);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AddmovieAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
