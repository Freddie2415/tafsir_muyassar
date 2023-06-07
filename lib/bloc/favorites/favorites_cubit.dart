import 'package:bloc/bloc.dart';
import 'package:tafsiri_muyassar/models/ayat.dart';
import 'package:tafsiri_muyassar/models/surah.dart';

import '../../repositories/local/box_repository.dart';

class FavoritesCubit extends Cubit<List<Ayat>> {
  final BoxRepository<Ayat> ayatBox;
  final BoxRepository<Surah> surahBox;

  FavoritesCubit({
    required this.ayatBox,
    required this.surahBox,
  }) : super([]) {
    load();
  }

  void load() async {
    final List<Ayat> favorites =
        ayatBox.box.values.where((element) => element.favorite).toList();

    favorites.forEach((favorite) {
      final surah =
          surahBox.box.values.firstWhere((e) => e.id == favorite.surahId);
      favorite.chapter = surah;
    });

    emit(favorites);
  }

  Future<void> favorite(Ayat ayat) async {
    ayat.favorite = !ayat.favorite;

    if (!ayat.favorite) {
      ayat.chapter = null;
    }

    await ayat.save();

    load();
  }
}
