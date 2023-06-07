import 'package:hive/hive.dart';
import 'chapter.dart';

import 'ayat.dart';

part 'surah.g.dart';

@HiveType(typeId: 2)
class Surah extends Chapter {
  Surah({
    required super.id,
    required super.title,
    required super.arabTitle,
    required super.latTitle,
    required super.sort,
    required super.updatedAt,
    required super.createdAt,
  });

  factory Surah.fromJSON(Map<String, dynamic> json) {
    return Surah(
      title: json['title'],
      arabTitle: json['arabTitle'],
      updatedAt: json['updated_at'],
      createdAt: json['created_at'],
      id: json['id'],
      latTitle: json['latTitle'],
      sort: json['sort'],
    );
  }
}
