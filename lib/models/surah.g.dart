// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'surah.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SurahAdapter extends TypeAdapter<Surah> {
  @override
  final int typeId = 2;

  @override
  Surah read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Surah(
      id: fields[0] as int,
      title: fields[1] as String,
      arabTitle: fields[6] as String,
      latTitle: fields[2] as String,
      sort: fields[3] as int,
      updatedAt: fields[5] as String,
      createdAt: fields[4] as String,
    )
      ..ayats = (fields[7] as HiveList?)?.castHiveList()
      ..lastReadAyat = fields[8] as Ayat?;
  }

  @override
  void write(BinaryWriter writer, Surah obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.latTitle)
      ..writeByte(3)
      ..write(obj.sort)
      ..writeByte(4)
      ..write(obj.createdAt)
      ..writeByte(5)
      ..write(obj.updatedAt)
      ..writeByte(6)
      ..write(obj.arabTitle)
      ..writeByte(7)
      ..write(obj.ayats)
      ..writeByte(8)
      ..write(obj.lastReadAyat);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SurahAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
