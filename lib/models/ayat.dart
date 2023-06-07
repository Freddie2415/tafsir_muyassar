import 'dart:ui';

import 'package:hive/hive.dart';
import 'package:tafsiri_muyassar/models/chapter.dart';

part 'ayat.g.dart';

@HiveType(typeId: 1)
class Ayat extends HiveObject {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final int number;

  @HiveField(2)
  final String text;

  @HiveField(3)
  final String latinText;

  @HiveField(4)
  final String arabText;

  @HiveField(5)
  final int surahId;

  @HiveField(6)
  final int juzId;

  @HiveField(7)
  final String createdAt;

  @HiveField(8)
  final String updatedAt;

  @HiveField(9)
  bool favorite;

  @HiveField(10)
  DateTime? lastReadAt;

  Chapter? chapter;
  Chapter? juz;
  Chapter? surah;

  Ayat({
    required this.id,
    required this.number,
    required this.text,
    required this.latinText,
    required this.arabText,
    required this.surahId,
    required this.juzId,
    required this.createdAt,
    required this.updatedAt,
    this.favorite = false,
    this.chapter,
  });

  factory Ayat.fromJSON(Map<String, dynamic> json) {
    return Ayat(
      id: json['id'],
      number: json['number'],
      text: json['text'],
      latinText: json['latinText'],
      arabText: json['arabText'],
      surahId: json['surah_id'],
      juzId: json['juz_id'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  @override
  String toString() {
    return "number: $number | text: ${text}";
  }

  String getText(Locale locale) {
    return locale == const Locale('uz') ? latinText : text;
  }
}
