import 'dart:ui';

import 'package:hive/hive.dart';
import 'ayat.dart';

part 'chapter.g.dart';

@HiveType(typeId: 0)
class Chapter extends HiveObject {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String latTitle;

  @HiveField(3)
  final int sort;

  @HiveField(4)
  final String createdAt;

  @HiveField(5)
  final String updatedAt;

  @HiveField(6)
  final String arabTitle;

  @HiveField(7)
  HiveList<Ayat>? ayats;

  List<Ayat> get ayatList => ayats?.toList() ?? [];

  @HiveField(8)
  Ayat? lastReadAyat;

  Chapter({
    required this.title,
    required this.arabTitle,
    required this.updatedAt,
    required this.createdAt,
    required this.id,
    required this.latTitle,
    required this.sort,
  });

  String getTitle(Locale locale) {
    return locale == const Locale('uz') ? latTitle : title;
  }
}
