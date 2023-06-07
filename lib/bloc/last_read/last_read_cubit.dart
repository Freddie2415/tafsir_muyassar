import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tafsiri_muyassar/models/ayat.dart';
import 'package:tafsiri_muyassar/models/chapter.dart';
import 'package:tafsiri_muyassar/models/juz.dart';
import 'package:tafsiri_muyassar/models/surah.dart';
import 'package:tafsiri_muyassar/repositories/local/box_repository.dart';

part 'last_read_state.dart';

class LastReadCubit extends Cubit<LastReadState> {
  final BoxRepository<Ayat> ayatBox;
  final BoxRepository<Surah> surahBox;
  final BoxRepository<Juz> juzBox;

  LastReadCubit({
    required this.ayatBox,
    required this.surahBox,
    required this.juzBox,
  }) : super(LastReadInitial()) {
    load();
  }

  load() {
    final List<Ayat> values = ayatBox.box.values
        .toList()
        .where((element) => element.lastReadAt != null)
        .toList();

    values.sort((a, b) => a.lastReadAt!.compareTo(b.lastReadAt!));

    if (values.isEmpty) {
      emit(LastReadInitial());
    } else {
      final ayat = values.first;

      Chapter? chapter;

      try {
        chapter = surahBox.box.values
            .firstWhere((element) => element.id == ayat.surahId);
      } catch (e) {
        print(e);
      }

      try {
        chapter ??=
            juzBox.box.values.firstWhere((element) => element.id == ayat.juzId);

        emit(LastReadSaved(chapter: chapter, ayat: ayat));
      } catch (e) {
        print(e);
      }
    }
  }

  Future<void> setLastRead(Chapter chapter, Ayat ayat) async {
    chapter.lastReadAyat = ayat;
    chapter.lastReadAyat?.lastReadAt = DateTime.now();

    await chapter.lastReadAyat?.save();
    await chapter.save();

    emit(LastReadSaved(chapter: chapter, ayat: ayat));
  }
}
