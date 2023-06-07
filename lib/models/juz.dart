import 'package:hive/hive.dart';
import 'package:tafsiri_muyassar/models/chapter.dart';

import 'ayat.dart';

part 'juz.g.dart';

@HiveType(typeId: 3)
class Juz extends Chapter {
  Juz({
    required super.id,
    required super.title,
    required super.arabTitle,
    required super.latTitle,
    required super.sort,
    required super.updatedAt,
    required super.createdAt,
  });

  factory Juz.fromJSON(Map<String, dynamic> json) {
    return Juz(
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
