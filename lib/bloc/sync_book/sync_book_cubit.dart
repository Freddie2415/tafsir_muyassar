import 'package:bloc/bloc.dart';
import 'package:hive/hive.dart';
import 'package:meta/meta.dart';
import 'package:dio/dio.dart';

import '../../models/ayat.dart';
import '../../models/juz.dart';
import '../../models/surah.dart';
import '../../repositories/local/box_repository.dart';
import '../../repositories/remote/juzs_repository.dart';
import '../../repositories/remote/surahs_repository.dart';
import '../../services/http_client.dart';

part 'sync_book_state.dart';

class SyncBookCubit extends Cubit<SyncBookState> {
  final _surahRepository = SurahsRepository();
  final _juzRepository = JuzsRepository();
  final BoxRepository<Surah> surahBox;
  final BoxRepository<Juz> juzsBox;
  final BoxRepository<Ayat> ayatBox;

  SyncBookCubit({
    required this.surahBox,
    required this.juzsBox,
    required this.ayatBox,
  }) : super(SyncBookInitial());

  void sync() async {
    emit(SyncBookLoading());

    try {
      // get local version
      final box = Hive.box<String>('bookVersion');
      final String? localBookVersion = box.get('version', defaultValue: '');

      // get api version
      final http = HttpClient().request;
      final response = await http.get('/version');
      final String apiBookVersion = response.data['version'].toString();

      print("api version: $apiBookVersion");
      print("local version: $localBookVersion");

      if (localBookVersion != apiBookVersion) {
        await _syncBook();
        await box.put('version', apiBookVersion);
      }

      print("saved local version: ${box.get('version', defaultValue: '')}");

      emit(SyncBookSuccess());
    } catch (e) {
      if (e is DioError) {
        final box = Hive.box<String>('bookVersion');
        final String? localBookVersion = box.get('version', defaultValue: "");
        print("last local book version: $localBookVersion");
        if (localBookVersion == "") {
          emit(SyncBookFailure(e.toString()));
          return;
        }
        emit(SyncBookSuccess());
      } else {
        emit(SyncBookFailure(e.toString()));
      }
    }
  }

  Future<void> _syncBook() async {
    emit(SyncBookLoading("Deleting cache..."));
    ayatBox.removeAll();
    juzsBox.removeAll();
    surahBox.removeAll();
    emit(SyncBookLoading("Surahs loading..."));
    await _syncSurahs();
    emit(SyncBookLoading("Juzs loading..."));
    await _syncJuzs();
  }

  Future<void> _syncSurahs() async {
    int page = 1;
    bool isLastPage = false;

    while (!isLastPage) {
      final surahResponse = await _surahRepository.getSurahs(page: page);
      final surahJsonList = surahResponse.data['data'] as List;

      isLastPage = surahJsonList.isEmpty;
      if (isLastPage) {
        break;
      }
      print(">>>>SURAHS IN API: ${surahJsonList.length}");

      for (var jsonSurah in surahJsonList) {
        final Surah surah = Surah.fromJSON(jsonSurah);
        surahBox.add(surah);
        surah.ayats = HiveList<Ayat>(ayatBox.box);

        final ayats = List.of(jsonSurah['ayats'])
            .map((ayatJson) => Ayat.fromJSON(ayatJson))
            .toList();

        await ayatBox.addAll(ayats);

        print("ayats length: ${ayatBox.box.values.length}");

        surah.ayats?.addAll(ayats);
        await surah.save();
        print("ayats length: ${ayatBox.getAll().length}");

        print("SURAH ID: ${surah.id} AYATS COUNT: ${surah.ayats?.length}");
      }

      emit(SyncBookLoading(
          "Loading surahs $page/${surahResponse.data['last_page']}"));
      page++;
    }
  }

  Future<void> _syncJuzs() async {
    int page = 1;
    bool isLastPage = false;

    while (!isLastPage) {
      final juzResponse = await _juzRepository.getJuzs(page: page);
      final juzJsonList = juzResponse.data['data'] as List;
      isLastPage = juzJsonList.isEmpty;
      if (isLastPage) {
        break;
      }
      for (var jsonJuz in juzJsonList) {
        final Juz juz = Juz.fromJSON(jsonJuz);
        juzsBox.add(juz);

        juz.ayats = HiveList<Ayat>(ayatBox.box);
        final ayats = List.of(jsonJuz['ayats'])
            .map((ayatJson) => Ayat.fromJSON(ayatJson))
            .toList();

        await ayatBox.addAll(ayats);
        juz.ayats?.addAll(ayats);
        juz.save();

        print("JUZ ID: ${juz.id} AYATS COUNT: ${juz.ayats?.length}");
      }

      emit(SyncBookLoading(
          "Loading juzs $page/${juzResponse.data['last_page']}"));
      page++;
    }
  }
}
