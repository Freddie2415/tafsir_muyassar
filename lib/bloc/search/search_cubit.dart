import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:tafsiri_muyassar/models/ayat.dart';
import 'package:tafsiri_muyassar/models/surah.dart';

import '../../models/juz.dart';
import '../../repositories/local/box_repository.dart';

class SearchCubit extends Cubit<List<Ayat>> {
  final BoxRepository<Ayat> ayatBox;
  final BoxRepository<Surah> surahBox;
  final BoxRepository<Juz> juzBox;

  SearchCubit({
    required this.ayatBox,
    required this.surahBox,
    required this.juzBox,
  }) : super([]);

  Future<void> search(String query, Locale locale) async {
    if (query.trim().isEmpty) {
      emit([]);
      return;
    }

    Set<String> seen = {};

    List<Ayat> results = ayatBox.box.values.where((element) {
      if (locale == const Locale('uz')) {
        return element.latinText.toLowerCase().contains(query.toLowerCase()) &&
            seen.add(element.id.toString());
      }

      return element.text.toLowerCase().contains(query.toLowerCase()) &&
          seen.add(element.id.toString());
    }).map((e) {
      if (surahBox.box.values.any((element) => element.id == e.surahId)) {
        e.surah = surahBox.box.values
            .firstWhere((element) => element.id == e.surahId);
        e.chapter = e.surah;
      }

      if (juzBox.box.values.any((element) => element.id == e.juzId)) {
        e.juz =
            juzBox.box.values.firstWhere((element) => element.id == e.juzId);
      }
      return e;
    }).toList();

    emit(results);
  }
}
