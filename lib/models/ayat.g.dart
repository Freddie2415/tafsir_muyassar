// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ayat.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AyatAdapter extends TypeAdapter<Ayat> {
  @override
  final int typeId = 1;

  @override
  Ayat read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Ayat(
      id: fields[0] as int,
      number: fields[1] as int,
      text: fields[2] as String,
      latinText: fields[3] as String,
      arabText: fields[4] as String,
      surahId: fields[5] as int,
      juzId: fields[6] as int,
      createdAt: fields[7] as String,
      updatedAt: fields[8] as String,
      favorite: fields[9] as bool,
    )..lastReadAt = fields[10] as DateTime?;
  }

  @override
  void write(BinaryWriter writer, Ayat obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.number)
      ..writeByte(2)
      ..write(obj.text)
      ..writeByte(3)
      ..write(obj.latinText)
      ..writeByte(4)
      ..write(obj.arabText)
      ..writeByte(5)
      ..write(obj.surahId)
      ..writeByte(6)
      ..write(obj.juzId)
      ..writeByte(7)
      ..write(obj.createdAt)
      ..writeByte(8)
      ..write(obj.updatedAt)
      ..writeByte(9)
      ..write(obj.favorite)
      ..writeByte(10)
      ..write(obj.lastReadAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AyatAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
